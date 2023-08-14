// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'field.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FieldRule<T> {
  TranslatedValue? get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            FieldValidator<T> validator, TranslatedValue? message)
        validation,
    required TResult Function(TranslatedValue? message) mandatory,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(FieldValidator<T> validator, TranslatedValue? message)?
        validation,
    TResult? Function(TranslatedValue? message)? mandatory,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(FieldValidator<T> validator, TranslatedValue? message)?
        validation,
    TResult Function(TranslatedValue? message)? mandatory,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ValidationFieldRule<T> value) validation,
    required TResult Function(_MandatoryFieldRule<T> value) mandatory,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ValidationFieldRule<T> value)? validation,
    TResult? Function(_MandatoryFieldRule<T> value)? mandatory,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ValidationFieldRule<T> value)? validation,
    TResult Function(_MandatoryFieldRule<T> value)? mandatory,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FieldRuleCopyWith<T, FieldRule<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FieldRuleCopyWith<T, $Res> {
  factory $FieldRuleCopyWith(
          FieldRule<T> value, $Res Function(FieldRule<T>) then) =
      _$FieldRuleCopyWithImpl<T, $Res, FieldRule<T>>;
  @useResult
  $Res call({TranslatedValue? message});
}

/// @nodoc
class _$FieldRuleCopyWithImpl<T, $Res, $Val extends FieldRule<T>>
    implements $FieldRuleCopyWith<T, $Res> {
  _$FieldRuleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as TranslatedValue?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ValidationFieldRuleCopyWith<T, $Res>
    implements $FieldRuleCopyWith<T, $Res> {
  factory _$$_ValidationFieldRuleCopyWith(_$_ValidationFieldRule<T> value,
          $Res Function(_$_ValidationFieldRule<T>) then) =
      __$$_ValidationFieldRuleCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({FieldValidator<T> validator, TranslatedValue? message});
}

/// @nodoc
class __$$_ValidationFieldRuleCopyWithImpl<T, $Res>
    extends _$FieldRuleCopyWithImpl<T, $Res, _$_ValidationFieldRule<T>>
    implements _$$_ValidationFieldRuleCopyWith<T, $Res> {
  __$$_ValidationFieldRuleCopyWithImpl(_$_ValidationFieldRule<T> _value,
      $Res Function(_$_ValidationFieldRule<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? validator = null,
    Object? message = freezed,
  }) {
    return _then(_$_ValidationFieldRule<T>(
      null == validator
          ? _value.validator
          : validator // ignore: cast_nullable_to_non_nullable
              as FieldValidator<T>,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as TranslatedValue?,
    ));
  }
}

/// @nodoc

class _$_ValidationFieldRule<T> extends _ValidationFieldRule<T> {
  const _$_ValidationFieldRule(this.validator, {this.message}) : super._();

  @override
  final FieldValidator<T> validator;
  @override
  final TranslatedValue? message;

  @override
  String toString() {
    return 'FieldRule<$T>.validation(validator: $validator, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ValidationFieldRule<T> &&
            (identical(other.validator, validator) ||
                other.validator == validator) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, validator, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ValidationFieldRuleCopyWith<T, _$_ValidationFieldRule<T>> get copyWith =>
      __$$_ValidationFieldRuleCopyWithImpl<T, _$_ValidationFieldRule<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            FieldValidator<T> validator, TranslatedValue? message)
        validation,
    required TResult Function(TranslatedValue? message) mandatory,
  }) {
    return validation(validator, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(FieldValidator<T> validator, TranslatedValue? message)?
        validation,
    TResult? Function(TranslatedValue? message)? mandatory,
  }) {
    return validation?.call(validator, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(FieldValidator<T> validator, TranslatedValue? message)?
        validation,
    TResult Function(TranslatedValue? message)? mandatory,
    required TResult orElse(),
  }) {
    if (validation != null) {
      return validation(validator, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ValidationFieldRule<T> value) validation,
    required TResult Function(_MandatoryFieldRule<T> value) mandatory,
  }) {
    return validation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ValidationFieldRule<T> value)? validation,
    TResult? Function(_MandatoryFieldRule<T> value)? mandatory,
  }) {
    return validation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ValidationFieldRule<T> value)? validation,
    TResult Function(_MandatoryFieldRule<T> value)? mandatory,
    required TResult orElse(),
  }) {
    if (validation != null) {
      return validation(this);
    }
    return orElse();
  }
}

abstract class _ValidationFieldRule<T> extends FieldRule<T> {
  const factory _ValidationFieldRule(final FieldValidator<T> validator,
      {final TranslatedValue? message}) = _$_ValidationFieldRule<T>;
  const _ValidationFieldRule._() : super._();

  FieldValidator<T> get validator;
  @override
  TranslatedValue? get message;
  @override
  @JsonKey(ignore: true)
  _$$_ValidationFieldRuleCopyWith<T, _$_ValidationFieldRule<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_MandatoryFieldRuleCopyWith<T, $Res>
    implements $FieldRuleCopyWith<T, $Res> {
  factory _$$_MandatoryFieldRuleCopyWith(_$_MandatoryFieldRule<T> value,
          $Res Function(_$_MandatoryFieldRule<T>) then) =
      __$$_MandatoryFieldRuleCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({TranslatedValue? message});
}

/// @nodoc
class __$$_MandatoryFieldRuleCopyWithImpl<T, $Res>
    extends _$FieldRuleCopyWithImpl<T, $Res, _$_MandatoryFieldRule<T>>
    implements _$$_MandatoryFieldRuleCopyWith<T, $Res> {
  __$$_MandatoryFieldRuleCopyWithImpl(_$_MandatoryFieldRule<T> _value,
      $Res Function(_$_MandatoryFieldRule<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$_MandatoryFieldRule<T>(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as TranslatedValue?,
    ));
  }
}

/// @nodoc

class _$_MandatoryFieldRule<T> extends _MandatoryFieldRule<T> {
  const _$_MandatoryFieldRule({this.message}) : super._();

  @override
  final TranslatedValue? message;

  @override
  String toString() {
    return 'FieldRule<$T>.mandatory(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MandatoryFieldRule<T> &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MandatoryFieldRuleCopyWith<T, _$_MandatoryFieldRule<T>> get copyWith =>
      __$$_MandatoryFieldRuleCopyWithImpl<T, _$_MandatoryFieldRule<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            FieldValidator<T> validator, TranslatedValue? message)
        validation,
    required TResult Function(TranslatedValue? message) mandatory,
  }) {
    return mandatory(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(FieldValidator<T> validator, TranslatedValue? message)?
        validation,
    TResult? Function(TranslatedValue? message)? mandatory,
  }) {
    return mandatory?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(FieldValidator<T> validator, TranslatedValue? message)?
        validation,
    TResult Function(TranslatedValue? message)? mandatory,
    required TResult orElse(),
  }) {
    if (mandatory != null) {
      return mandatory(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ValidationFieldRule<T> value) validation,
    required TResult Function(_MandatoryFieldRule<T> value) mandatory,
  }) {
    return mandatory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ValidationFieldRule<T> value)? validation,
    TResult? Function(_MandatoryFieldRule<T> value)? mandatory,
  }) {
    return mandatory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ValidationFieldRule<T> value)? validation,
    TResult Function(_MandatoryFieldRule<T> value)? mandatory,
    required TResult orElse(),
  }) {
    if (mandatory != null) {
      return mandatory(this);
    }
    return orElse();
  }
}

abstract class _MandatoryFieldRule<T> extends FieldRule<T> {
  const factory _MandatoryFieldRule({final TranslatedValue? message}) =
      _$_MandatoryFieldRule<T>;
  const _MandatoryFieldRule._() : super._();

  @override
  TranslatedValue? get message;
  @override
  @JsonKey(ignore: true)
  _$$_MandatoryFieldRuleCopyWith<T, _$_MandatoryFieldRule<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
