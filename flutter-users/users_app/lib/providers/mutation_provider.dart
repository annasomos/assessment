import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef Mutation<T, P> = _Mutation<T, P>;
typedef MutationNotifierProvider<T, P> = AutoDisposeNotifierProvider<MutationProvider<T, P>, Mutation<T?, P>>;

class MutationProvider<T, P> extends AutoDisposeNotifier<Mutation<T?, P>> {
  MutationProvider._({
    required this.mutationFn,
    this.onSuccess,
    this.onError,
  });

  final _MutationFunction<T, P> mutationFn;
  final _MutationOnSuccess<T, P>? onSuccess;
  final _MutationOnError<P>? onError;

  @override
  Mutation<T?, P> build() {
    return Mutation<T?, P>(
      state: const AsyncValue.data(null),
      mutate: _mutate,
    );
  }

  Future<AsyncValue<T>> _mutate(P params) async {
    state = state.copyWith(state: const AsyncValue.loading());

    final response = await AsyncValue.guard<T>(() => mutationFn(ref, params));

    response.whenOrNull(
      data: (value) async {
        await onSuccess?.call(ref, value, params);
        state = state.copyWith(state: AsyncValue.data(value));
      },
      error: (error, stackTrace) async {
        await onError?.call(ref, error, params);
        state = state.copyWith(state: AsyncValue.error(error, stackTrace));
      },
    );

    return response;
  }

  static MutationNotifierProvider<T, P> create<T, P>({
    required _MutationFunction<T, P> mutationFn,
    _MutationOnSuccess<T, P>? onSuccess,
    _MutationOnError<P>? onError,
  }) {
    return MutationNotifierProvider(() {
      return MutationProvider<T, P>._(
        mutationFn: mutationFn,
        onSuccess: onSuccess,
        onError: onError,
      );
    });
  }
}

class _Mutation<T, P> {
  _Mutation({
    required this.state,
    required this.mutate,
  });

  final AsyncValue<T> state;
  final Future<AsyncValue<T>> Function(P params) mutate;

  bool get isLoading => state.isLoading;
  bool get hasError => state.hasError;
  bool get hasValue => state.hasValue;

  T? get valueOrNull => state.valueOrNull;
  Object? get error => state.error;

  Future<AsyncValue<T>> call(P params) => mutate(params);

  _Mutation<T, P> copyWith({AsyncValue<T>? state}) {
    return _Mutation(
      state: state ?? this.state,
      mutate: this.mutate,
    );
  }
}

typedef _MutationFunction<T, P> = Future<T> Function(Ref ref, P params);
typedef _MutationOnSuccess<T, P> = Future<void> Function(Ref ref, T value, P params);
typedef _MutationOnError<P> = Future<void> Function(Ref ref, Object error, P params);