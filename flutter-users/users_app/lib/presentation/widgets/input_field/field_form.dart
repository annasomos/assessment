import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:users_app/models/field/field.dart';
import 'package:users_app/presentation/utils/form_handler.dart';
import 'package:users_app/presentation/widgets/input_field/default_text_input_action.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class FieldForm extends HookConsumerWidget {
  const FieldForm({
    Key? key,
    required this.fields,
    required this.fieldBuilder,
    this.formHandler,
    this.isScrollControlled = false,
  }) : super(key: key);

  final List<Field> fields;
  final Widget Function(BuildContext, Field) fieldBuilder;
  final bool isScrollControlled;
  final FormHandler? formHandler;

  Field? get lastManualInputField => fields.lastWhereOrNull((field) => field.isManualInputField);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultFormHandler(
      handler: formHandler ?? ref.read(formHandlerProvider),
      child: Builder(
        builder: (context) {
          if (isScrollControlled) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: fields.mapIndexed((index, field) {
                final field = fields[index];
                return DefaultTextInputAction(
                  textInputAction: field.key == lastManualInputField?.key ? TextInputAction.done : TextInputAction.next,
                  child: fieldBuilder(context, field),
                );
              }).toList(),
            );
          } else {
            return ListView.builder(
              shrinkWrap: isScrollControlled,
              physics: isScrollControlled ? const NeverScrollableScrollPhysics() : null,
              itemCount: fields.length,
              itemBuilder: (context, index) {
                final field = fields[index];
                return DefaultTextInputAction(
                  textInputAction: field.key == lastManualInputField?.key ? TextInputAction.done : TextInputAction.next,
                  child: fieldBuilder(context, field),
                );
              },
            );
          }
        },
      ),
    );
  }
}
