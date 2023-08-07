import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef MutationStateNotifierProvider<R, V> = StateNotifierProvider<MutationProvider<R, V>, AsyncValue>;

class MutationProvider<R, V> extends StateNotifier<AsyncValue<R?>> {
  MutationProvider({
    required this.mutationFn,
    this.onSuccess,
    this.onFailed,
  }) : super(const AsyncValue.data(null));

  final Future<R> Function(V variable) mutationFn;
  final Function(R value, V variable)? onSuccess;
  final Function(Object error)? onFailed;

  Future<AsyncValue<R?>> mutate(V variable) async {
    state = const AsyncValue.loading();

    final response = await AsyncValue.guard<R>(() => mutationFn(variable));

    response.maybeWhen(
      data: (value) {
        state = AsyncValue.data(value);
        onSuccess?.call(value, variable);
      },
      error: (error, stackTrace) {
        state = AsyncValue.error(error, stackTrace);
        onFailed?.call(error);
      },
      orElse: () => state = response,
    );

    return state;
  }
}

extension MutationStateNotifierProviderX on MutationStateNotifierProvider {
  ProviderListenable<bool> get isLoading => select((state) => state.isLoading);
}