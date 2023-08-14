import 'dart:async';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart' hide TextField;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:users_app/models/field/field.dart';

extension FieldIterableExtension on Iterable<Field> {
  Field? get firstErroneousField => firstWhereOrNull((field) => field.hasError);
  List<Field> get dirtyFields => where((field) => field.isDirty).toList();
  bool get hasError => firstErroneousField != null;
  bool get hasDirtyFields => dirtyFields.isNotEmpty;
}

extension FieldMapExtension on Map<String, Field> {
  List<Field> get fields => values.toList();

  Field? get firstErroneousField => values.firstErroneousField;
  Map<String, Field> get dirtyFields => Map.fromEntries(entries.where((element) => element.value.isDirty));
  bool get hasError => values.hasError;
  bool get hasDirtyFields => dirtyFields.isNotEmpty;
}

mixin FormHandlerState {
  Map<String, Field> get fieldMap;

  List<Field> get fields => fieldMap.fields;
  Map<String, Field> get dirtyFields => fieldMap.dirtyFields;
  bool get hasDirtyFields => fieldMap.hasDirtyFields;
  Field? get firstErroneousField => fieldMap.firstErroneousField;
  bool get hasError => fieldMap.hasError;

  F getField<F>(String key) => fieldMap[key]! as F;

  V getFieldValue<V>(String key) => (fieldMap[key]! as Field<V>).draftValue;
}

mixin FormHandler<T extends FormHandlerState> {
  void emitFields(Map<String, Field> fieldMap);
  FormHandlerState get formHolder;

  F getField<F>(String key) => formHolder.fieldMap[key]! as F;

  V getFieldValue<V>(String key) => (formHolder.fieldMap[key]! as Field<V>).draftValue;

  void setField(Field field) => emitFields({...formHolder.fieldMap, field.key: field});

  void setFieldValue(String key, dynamic value) => emitFields(
        _updateAField(
          key,
          (field) => field.copyWith(draftValue: value, initialValue: field.initialValue),
        ),
      );

  void showFieldError(String key, {bool onlyInvalid = true}) {
    showFieldErrors([key], onlyInvalid: onlyInvalid);
  }

  void showAllFieldErrors() {
    emitFields(_updateAllFields(
      (field) => field.copyWith(
        initialValue: field.initialValue,
        draftValue: field.draftValue,
        errorVisible: true,
      ),
    ));
  }

  void showFieldErrors(List<String> keys, {bool onlyInvalid = false}) {
    final updatedFieldMap = _updateFields(keys, (field) {
      if (field.invalid || !onlyInvalid) {
        return field.copyWith(
          initialValue: field.initialValue,
          draftValue: field.draftValue,
          errorVisible: true,
        );
      }

      return field;
    });
    emitFields(updatedFieldMap);
  }

  void hideFieldError(String key) => hideFieldErrors([key]);

  void hideAllFieldErrors() {
    emitFields(_updateAllFields(
      (field) => field.copyWith(
        initialValue: field.initialValue,
        draftValue: field.draftValue,
        errorVisible: false,
      ),
    ));
  }

  void hideFieldErrors(List<String> keys) {
    emitFields(_updateFields(
      keys,
      (field) => field.copyWith(
        initialValue: field.initialValue,
        draftValue: field.draftValue,
        errorVisible: false,
      ),
    ));
  }

  void resetField(String key) => resetFields([key]);

  void resetAllFields() => resetFields(formHolder.fieldMap.keys);

  void resetFields(Iterable<String> fieldKeys) {
    final updatedFieldMap = _updateFields(
      fieldKeys,
      (field) => field.copyWith(
        draftValue: field.initialValue,
        initialValue: field.initialValue,
        errorVisible: false,
      ),
    );

    emitFields(updatedFieldMap);
  }

  Map<String, Field> _updateAField(String fieldKey, Field Function(Field field) updateFn) {
    return _updateFields([fieldKey], updateFn);
  }

  Map<String, Field> _updateAllFields(Field Function(Field field) updateFn) {
    return _updateFields(formHolder.fieldMap.keys, updateFn);
  }

  Map<String, Field> _updateFields(Iterable<String> fieldKeys, Field Function(Field field) updateFn) {
    final keysNotFound = fieldKeys.where((fieldKeyToUpdate) => !formHolder.fieldMap.keys.contains(fieldKeyToUpdate));

    if (keysNotFound.isNotEmpty) {
      debugPrint('Could not find field(s): ${keysNotFound.toString()}');
    }

    final fieldsToUpdate = formHolder.fieldMap.entries.where((e) => fieldKeys.contains(e.key));
    final updatedEntries = fieldsToUpdate.map((e) => MapEntry<String, Field>(e.key, updateFn(e.value)));
    final updatedFieldMap = {...formHolder.fieldMap};

    updatedEntries.forEach((entry) {
      updatedFieldMap[entry.key] = entry.value;
    });

    return updatedFieldMap;
  }

  Future<Either<void, V>> trySubmit<V>(FutureOr<V> Function() submitFn) async {
    if (formHolder.hasError) {
      showAllFieldErrors();
      return const Left(null);
    } else {
      final submit = await submitFn();
      return Right(submit);
    }
  }
}

final formHandlerProvider = Provider<FormHandler?>((ref) {
  return null;
});

class DefaultFormHandler extends StatelessWidget {
  const DefaultFormHandler({Key? key, required this.child, required this.handler}) : super(key: key);

  final Widget child;
  final FormHandler? handler;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        formHandlerProvider.overrideWithValue(handler),
      ],
      child: child,
    );
  }
}

FormHandler useFormHandler(Map<String, Field> fields) {
  final formValueNotifier = useNotifierState(
    ValueNotifier<Map<String, Field>>(fields),
  );

  return _ValueFormHook(fields: formValueNotifier);
}

class _ValueFormHook with FormHandler, FormHandlerState {
  _ValueFormHook({required ValueNotifier<Map<String, Field>> fields}) : _fields = fields;

  final ValueNotifier<Map<String, Field>> _fields;

  @override
  void emitFields(Map<String, Field> fieldMap) => _fields.value = fieldMap;

  @override
  Map<String, Field> get fieldMap => _fields.value;

  @override
  FormHandlerState get formHolder => this;
}

ValueNotifier<T> useNotifierState<T>(ValueNotifier<T> initialData) {
  return use(_StateHook(initialData: initialData));
}

class _StateHook<T> extends Hook<ValueNotifier<T>> {
  const _StateHook({required this.initialData});

  final ValueNotifier<T> initialData;

  @override
  _StateHookState<T> createState() => _StateHookState();
}

class _StateHookState<T> extends HookState<ValueNotifier<T>, _StateHook<T>> {
  late final ValueNotifier<T> _state = hook.initialData..addListener(_listener);

  @override
  void dispose() => _state.dispose();

  @override
  ValueNotifier<T> build(BuildContext context) => _state;

  void _listener() => setState(() {});

  @override
  Object? get debugValue => _state.value;

  @override
  String get debugLabel => 'useNotifierState<$T>';
}