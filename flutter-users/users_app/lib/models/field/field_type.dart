import 'package:freezed_annotation/freezed_annotation.dart';

part 'field_type.freezed.dart';

@freezed
class FieldType with _$FieldType {
  const FieldType._();
  const factory FieldType.text() = TextFieldType;
  const factory FieldType.password() = PasswordFieldType;
  const factory FieldType.email() = EmailFieldType;
  const factory FieldType.number() = NumberFieldType;
  const factory FieldType.phone() = PhoneFieldType;
  const factory FieldType.duration() = DurationFieldType;
  const factory FieldType.time() = TimeFieldType;
  const factory FieldType.date() = DateFieldType;
  const factory FieldType.select() = SelectFieldType;
  const factory FieldType.multiSelect() = MultiSelectFieldType;
  const factory FieldType.asyncSearch() = AsyncSearchFieldType;
  const factory FieldType.search() = SearchFieldType;
  const factory FieldType.boolean() = BooleanFieldType;

  bool get isBoolean {
    return maybeWhen(
      boolean: () => true,
      orElse: () => false,
    );
  }
}