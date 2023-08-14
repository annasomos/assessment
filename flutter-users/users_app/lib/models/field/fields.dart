import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:users_app/models/field/field.dart';
import 'package:users_app/utils/translated_value.dart';

class TextField extends Field<String> {
  TextField({
    required String key,
    required String initialValue,
    TranslatedValue? label,
    TranslatedValue? hint,
    List<FieldRule<String>> rules = const [],
    bool errorVisible = false,
    String? draftValue,
  }) : super(
          key: key,
          initialValue: initialValue,
          label: label,
          hint: hint,
          rules: rules,
          errorVisible: errorVisible,
          draftValue: draftValue,
          type: const FieldType.text(),
        );

  @override
  Field<String> copyWith({
    required String initialValue,
    required String draftValue,
    bool? errorVisible,
  }) {
    return TextField(
      key: key,
      initialValue: initialValue,
      draftValue: draftValue,
      label: label,
      hint: hint,
      errorVisible: errorVisible ?? this.errorVisible,
      rules: rules,
    );
  }
}

class PasswordField extends Field<String> {
  PasswordField({
    required String key,
    required String initialValue,
    TranslatedValue? label,
    TranslatedValue? hint,
    List<FieldRule<String>> rules = const [],
    bool errorVisible = false,
    String? draftValue,
  }) : super(
          key: key,
          initialValue: initialValue,
          label: label,
          hint: hint,
          rules: rules,
          errorVisible: errorVisible,
          draftValue: draftValue,
          type: const FieldType.password(),
        );

  @override
  Field<String> copyWith({
    required String initialValue,
    required String draftValue,
    bool? errorVisible,
  }) {
    return PasswordField(
      key: key,
      initialValue: initialValue,
      draftValue: draftValue,
      label: label,
      hint: hint,
      errorVisible: errorVisible ?? this.errorVisible,
      rules: rules,
    );
  }
}

class EmailField extends Field<String> {
  EmailField({
    required String key,
    required String initialValue,
    TranslatedValue? label,
    TranslatedValue? hint,
    List<FieldRule<String>> rules = const [],
    bool errorVisible = false,
    String? draftValue,
  }) : super(
          key: key,
          initialValue: initialValue,
          label: label,
          hint: hint,
          rules: rules,
          errorVisible: errorVisible,
          draftValue: draftValue,
          type: const FieldType.email(),
        );

  @override
  Field<String> copyWith({
    required String initialValue,
    required String draftValue,
    bool? errorVisible,
  }) {
    return EmailField(
      key: key,
      initialValue: initialValue,
      draftValue: draftValue,
      label: label,
      hint: hint,
      errorVisible: errorVisible ?? this.errorVisible,
      rules: rules,
    );
  }
}

class NumberField extends Field<String> {
  NumberField({
    required String key,
    required String initialValue,
    TranslatedValue? label,
    TranslatedValue? hint,
    List<FieldRule<String>> rules = const [],
    bool errorVisible = false,
    String? draftValue,
  }) : super(
          key: key,
          initialValue: initialValue,
          label: label,
          hint: hint,
          rules: rules,
          errorVisible: errorVisible,
          draftValue: draftValue,
          type: const FieldType.number(),
        );

  @override
  Field<String> copyWith({
    required String initialValue,
    required String draftValue,
    bool? errorVisible,
  }) {
    return NumberField(
      key: key,
      initialValue: initialValue,
      draftValue: draftValue,
      label: label,
      hint: hint,
      errorVisible: errorVisible ?? this.errorVisible,
      rules: rules,
    );
  }
}

class PhoneField extends Field<String> {
  PhoneField({
    required String key,
    required String initialValue,
    TranslatedValue? label,
    TranslatedValue? hint,
    List<FieldRule<String>> rules = const [],
    bool errorVisible = false,
    String? draftValue,
  }) : super(
          key: key,
          initialValue: initialValue,
          label: label,
          hint: hint,
          rules: rules,
          errorVisible: errorVisible,
          draftValue: draftValue,
          type: const FieldType.phone(),
        );

  @override
  Field<String> copyWith({
    required String initialValue,
    required String draftValue,
    bool? errorVisible,
  }) {
    return PhoneField(
      key: key,
      initialValue: initialValue,
      draftValue: draftValue,
      label: label,
      hint: hint,
      errorVisible: errorVisible ?? this.errorVisible,
      rules: rules,
    );
  }
}

class DurationField extends Field<Duration?> {
  DurationField({
    required String key,
    required Duration? initialValue,
    TranslatedValue? label,
    TranslatedValue? hint,
    List<FieldRule<Duration?>> rules = const [],
    bool errorVisible = false,
    Duration? draftValue,
    this.title,
    this.mode = CupertinoTimerPickerMode.hms,
    this.formatter,
  }) : super(
          key: key,
          initialValue: initialValue,
          label: label,
          hint: hint,
          rules: rules,
          errorVisible: errorVisible,
          draftValue: draftValue,
          type: const FieldType.duration(),
        );

  final TranslatedValue? title;
  final CupertinoTimerPickerMode mode;
  final String Function(Duration?)? formatter;

  @override
  String getDisplayValue(BuildContext context, WidgetRef ref) {
    if (draftValue == null) {
      return '';
    }

    if (formatter != null) {
      return formatter!(draftValue);
    } else {
      return draftValue!.formatDuration();
    }
  }

  @override
  Field<Duration?> copyWith({
    required Duration? initialValue,
    required Duration? draftValue,
    bool? errorVisible,
  }) {
    return DurationField(
      key: key,
      initialValue: initialValue,
      draftValue: draftValue,
      label: label,
      hint: hint,
      errorVisible: errorVisible ?? this.errorVisible,
      rules: rules,
      title: title,
      formatter: formatter,
      mode: mode,
    );
  }
}

class TimeField extends Field<TimeOfDay?> {
  TimeField({
    required String key,
    required TimeOfDay? initialValue,
    TranslatedValue? label,
    TranslatedValue? hint,
    List<FieldRule<TimeOfDay?>> rules = const [],
    bool errorVisible = false,
    TimeOfDay? draftValue,
    this.initialTime,
  }) : super(
          key: key,
          initialValue: initialValue,
          label: label,
          hint: hint,
          rules: rules,
          errorVisible: errorVisible,
          draftValue: draftValue,
          type: const FieldType.time(),
        );

  final TimeOfDay? initialTime;

  @override
  String getDisplayValue(BuildContext context, WidgetRef ref) {
    if (draftValue == null) {
      return '';
    }

    return draftValue!.format(context);
  }

  @override
  Field<TimeOfDay?> copyWith({
    required TimeOfDay? initialValue,
    required TimeOfDay? draftValue,
    bool? errorVisible,
  }) {
    return TimeField(
      key: key,
      initialValue: initialValue,
      draftValue: draftValue,
      label: label,
      hint: hint,
      errorVisible: errorVisible ?? this.errorVisible,
      rules: rules,
      initialTime: initialTime,
    );
  }
}

class DateField extends Field<DateTime?> {
  DateField({
    required String key,
    required DateTime? initialValue,
    TranslatedValue? label,
    TranslatedValue? hint,
    List<FieldRule<DateTime?>> rules = const [],
    bool errorVisible = false,
    DateTime? draftValue,
    required this.minValue,
    required this.maxValue,
    this.formatter,
  }) : super(
          key: key,
          initialValue: initialValue,
          label: label,
          hint: hint,
          rules: rules,
          errorVisible: errorVisible,
          draftValue: draftValue,
          type: const FieldType.date(),
        );

  final DateTime minValue;
  final DateTime maxValue;
  final String Function(DateTime?)? formatter;

  @override
  String getDisplayValue(BuildContext context, WidgetRef ref) {
    if (draftValue == null) {
      return '';
    }

    if (formatter != null) {
      return formatter!(draftValue);
    } else {
      return DateFormat("yyyy.MM.dd").format(draftValue!);
    }
  }

  @override
  Field<DateTime?> copyWith({
    required DateTime? initialValue,
    required DateTime? draftValue,
    bool? errorVisible,
  }) {
    return DateField(
      key: key,
      initialValue: initialValue,
      draftValue: draftValue,
      label: label,
      hint: hint,
      errorVisible: errorVisible ?? this.errorVisible,
      rules: rules,
      maxValue: maxValue,
      minValue: minValue,
      formatter: formatter,
    );
  }
}

class SelectField extends Field<SelectFieldOption?> {
  SelectField({
    required String key,
    required SelectFieldOption? initialValue,
    TranslatedValue? label,
    TranslatedValue? hint,
    List<FieldRule<SelectFieldOption?>> rules = const [],
    bool errorVisible = false,
    SelectFieldOption? draftValue,
    required this.options,
    this.title,
  }) : super(
          key: key,
          initialValue: initialValue,
          label: label,
          hint: hint,
          rules: rules,
          errorVisible: errorVisible,
          draftValue: draftValue,
          type: const FieldType.select(),
        );

  final Map<String, SelectFieldOption> options;
  final TranslatedValue? title;

  @override
  String getDisplayValue(BuildContext context, WidgetRef ref) {
    if (draftValue == null) {
      return '';
    }

    return draftValue!.label.getValue(ref);
  }

  @override
  Field<SelectFieldOption?> copyWith({
    required SelectFieldOption? initialValue,
    required SelectFieldOption? draftValue,
    bool? errorVisible,
  }) {
    return SelectField(
      key: key,
      initialValue: initialValue,
      draftValue: draftValue,
      label: label,
      hint: hint,
      errorVisible: errorVisible ?? this.errorVisible,
      rules: rules,
      options: options,
      title: title,
    );
  }
}

class MultiSelectField extends Field<List<SelectFieldOption>> {
  MultiSelectField({
    required String key,
    required List<SelectFieldOption> initialValue,
    TranslatedValue? label,
    TranslatedValue? hint,
    List<FieldRule<List<SelectFieldOption>>> rules = const [],
    bool errorVisible = false,
    List<SelectFieldOption>? draftValue,
    required this.options,
    this.title,
    this.valueSeparator = ', ',
  }) : super(
          key: key,
          initialValue: initialValue,
          label: label,
          hint: hint,
          rules: rules,
          errorVisible: errorVisible,
          draftValue: draftValue,
          type: const FieldType.multiSelect(),
        );

  final Map<String, SelectFieldOption> options;
  final TranslatedValue? title;
  final String? valueSeparator;

  @override
  bool get mandatory => initialValue.isEmpty;

  @override
  String getDisplayValue(BuildContext context, WidgetRef ref) {
    final labels = draftValue.map((option) {
      return option.label.getValue(ref);
    });

    return labels.join(valueSeparator ?? ', ');
  }

  @override
  Field<List<SelectFieldOption>> copyWith({
    required List<SelectFieldOption> initialValue,
    required List<SelectFieldOption> draftValue,
    bool? errorVisible,
  }) {
    return MultiSelectField(
      key: key,
      initialValue: initialValue,
      draftValue: draftValue,
      label: label,
      hint: hint,
      errorVisible: errorVisible ?? this.errorVisible,
      rules: rules,
      options: options,
      title: title,
      valueSeparator: valueSeparator,
    );
  }
}

extension DurationX on Duration {
  String formatDuration() {
    final hours = inHours.toString().padLeft(2, '0');
    final minutes = inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = inSeconds.remainder(60).toString().padLeft(2, '0');

    if (hours == '00') {
      return "$minutes:$seconds";
    }

    return "$hours:$minutes:$seconds";
  }
}