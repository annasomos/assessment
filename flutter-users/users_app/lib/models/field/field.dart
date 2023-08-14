import 'package:flutter/cupertino.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart' hide TextField;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:users_app/models/field/field_type.dart';
import 'package:users_app/models/field/fields.dart';
import 'package:users_app/models/field/field_validator.dart';
import 'package:users_app/models/field/select_field_option.dart';
import 'package:users_app/utils/translated_value.dart';

export 'package:users_app/models/field/select_field_option.dart';
export 'package:users_app/models/field/field_type.dart';
export 'package:users_app/models/field/field_validator.dart';

part 'field.freezed.dart';

class Field<T> {
  const Field({
    required this.key,
    required this.initialValue,
    required this.type,
    this.label,
    this.hint,
    this.rules = const [],
    this.errorVisible = false,
    T? draftValue,
  }) : draftValue = draftValue ?? initialValue;

  final String key;
  final T initialValue;
  final TranslatedValue? label;
  final TranslatedValue? hint;
  final List<FieldRule<T>> rules;
  final bool errorVisible;
  final FieldType type;
  final T draftValue;

  static Field<String> text({
    required String key,
    required String initialValue,
    TranslatedValue? label,
    TranslatedValue? hint,
    List<FieldRule<String>> rules = const [],
    bool errorVisible = false,
    String? draftValue,
  }) {
    return TextField(
      key: key,
      initialValue: initialValue,
      label: label,
      hint: hint,
      rules: rules,
      errorVisible: errorVisible,
      draftValue: draftValue,
    );
  }

  static Field<String> password({
    required String key,
    required String initialValue,
    TranslatedValue? label,
    TranslatedValue? hint,
    List<FieldRule<String>> rules = const [],
    bool errorVisible = false,
    String? draftValue,
  }) {
    return PasswordField(
      key: key,
      initialValue: initialValue,
      label: label,
      hint: hint,
      rules: rules,
      errorVisible: errorVisible,
      draftValue: draftValue,
    );
  }

  static Field<String> email({
    required String key,
    required String initialValue,
    TranslatedValue? label,
    TranslatedValue? hint,
    List<FieldRule<String>> rules = const [],
    bool errorVisible = false,
    String? draftValue,
  }) {
    return EmailField(
      key: key,
      initialValue: initialValue,
      label: label,
      hint: hint,
      rules: rules,
      errorVisible: errorVisible,
      draftValue: draftValue,
    );
  }

  static Field<String> number({
    required String key,
    required String initialValue,
    TranslatedValue? label,
    TranslatedValue? hint,
    List<FieldRule<String>> rules = const [],
    bool errorVisible = false,
    String? draftValue,
  }) {
    return NumberField(
      key: key,
      initialValue: initialValue,
      label: label,
      hint: hint,
      rules: rules,
      errorVisible: errorVisible,
      draftValue: draftValue,
    );
  }

  static Field<String> phone({
    required String key,
    required String initialValue,
    TranslatedValue? label,
    TranslatedValue? hint,
    List<FieldRule<String>> rules = const [],
    bool errorVisible = false,
    String? draftValue,
  }) {
    return PhoneField(
      key: key,
      initialValue: initialValue,
      label: label,
      hint: hint,
      rules: rules,
      errorVisible: errorVisible,
      draftValue: draftValue,
    );
  }

  static Field<Duration?> duration({
    required String key,
    required Duration? initialValue,
    TranslatedValue? label,
    TranslatedValue? hint,
    List<FieldRule<Duration?>> rules = const [],
    bool errorVisible = false,
    Duration? draftValue,
    TranslatedValue? title,
    CupertinoTimerPickerMode mode = CupertinoTimerPickerMode.hms,
    String Function(Duration?)? formatter,
  }) {
    return DurationField(
      key: key,
      initialValue: initialValue,
      label: label,
      hint: hint,
      rules: rules,
      errorVisible: errorVisible,
      draftValue: draftValue,
      title: title,
      mode: mode,
      formatter: formatter,
    );
  }

  static Field<TimeOfDay?> time({
    required String key,
    required TimeOfDay? initialValue,
    TranslatedValue? label,
    TranslatedValue? hint,
    List<FieldRule<TimeOfDay?>> rules = const [],
    bool errorVisible = false,
    TimeOfDay? draftValue,
    TimeOfDay? initialTime,
  }) {
    return TimeField(
      key: key,
      initialValue: initialValue,
      label: label,
      hint: hint,
      rules: rules,
      errorVisible: errorVisible,
      draftValue: draftValue,
      initialTime: initialTime,
    );
  }

  static Field<DateTime?> date({
    required String key,
    required DateTime? initialValue,
    TranslatedValue? label,
    TranslatedValue? hint,
    List<FieldRule<DateTime?>> rules = const [],
    bool errorVisible = false,
    DateTime? draftValue,
    required DateTime minValue,
    required DateTime maxValue,
    String Function(DateTime?)? formatter,
  }) {
    return DateField(
      key: key,
      initialValue: initialValue,
      label: label,
      hint: hint,
      rules: rules,
      errorVisible: errorVisible,
      draftValue: draftValue,
      minValue: minValue,
      maxValue: maxValue,
      formatter: formatter,
    );
  }

  static Field<SelectFieldOption?> select({
    required String key,
    required SelectFieldOption? initialValue,
    TranslatedValue? label,
    TranslatedValue? hint,
    List<FieldRule<SelectFieldOption?>> rules = const [],
    bool errorVisible = false,
    SelectFieldOption? draftValue,
    required Map<String, SelectFieldOption> options,
    TranslatedValue? title,
  }) {
    return SelectField(
      key: key,
      initialValue: initialValue,
      label: label,
      hint: hint,
      rules: rules,
      errorVisible: errorVisible,
      draftValue: draftValue,
      options: options,
      title: title,
    );
  }

  static Field<List<SelectFieldOption>> multiSelect({
    required String key,
    required List<SelectFieldOption> initialValue,
    TranslatedValue? label,
    TranslatedValue? hint,
    List<FieldRule<List<SelectFieldOption>>> rules = const [],
    bool errorVisible = false,
    List<SelectFieldOption>? draftValue,
    required Map<String, SelectFieldOption> options,
    TranslatedValue? title,
    String? valueSeparator = ', ',
  }) =>
      MultiSelectField(
        key: key,
        initialValue: initialValue,
        label: label,
        hint: hint,
        rules: rules,
        errorVisible: errorVisible,
        draftValue: draftValue,
        options: options,
        title: title,
        valueSeparator: valueSeparator,
      );

  bool get mandatory {
    return rules.any(
      (rule) => rule.when(
        mandatory: (_) => true,
        validation: (_, __) => false,
      ),
    );
  }

  bool get isEmpty {
    if (draftValue == null) {
      return true;
    }

    if (draftValue is String) {
      return (draftValue as String).isEmpty;
    }

    return false;
  }

  bool get isDirty => draftValue != initialValue;

  bool get hasError => _firstUnsatisfiedRule != null;

  bool get invalid {
    return _unsatisfiedRules.any(
      (rule) => rule.maybeWhen(
        validation: (_, __) => true,
        orElse: () => false,
      ),
    );
  }

  TranslatedValue? get errorMessage {
    final message = _firstUnsatisfiedRule?.message;
    return errorVisible ? message : null;
  }

  List<FieldRule> get _unsatisfiedRules {
    return rules.where((rule) => !rule.isSatisfied(this)).toList();
  }

  FieldRule? get _firstUnsatisfiedRule {
    return _unsatisfiedRules.firstOrNull;
  }

  bool get isManualInputField => type.maybeMap(
        time: (_) => false,
        date: (_) => false,
        select: (_) => false,
        multiSelect: (_) => false,
        orElse: () => true,
      );

  String getDisplayValue(BuildContext context, WidgetRef ref) {
    if (draftValue is String) {
      return draftValue as String;
    }

    return '$draftValue';
  }

  Field<T> copyWith({
    required T initialValue,
    required T draftValue,
    bool? errorVisible,
  }) {
    throw UnimplementedError();
  }
}

@freezed
class FieldRule<T> with _$FieldRule<T> {
  const FieldRule._();
  const factory FieldRule.validation(FieldValidator<T> validator, {TranslatedValue? message}) = _ValidationFieldRule<T>;
  const factory FieldRule.mandatory({TranslatedValue? message}) = _MandatoryFieldRule<T>;

  bool isSatisfied(Field field) => when(
        mandatory: (_) => !field.isEmpty,
        validation: (validator, _) {
          return field.isEmpty || validator.isValid(field.draftValue);
        },
      );
}