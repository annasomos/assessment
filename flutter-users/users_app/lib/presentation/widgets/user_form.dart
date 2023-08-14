import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:users_app/presentation/utils/form_handler.dart';
import 'package:users_app/presentation/widgets/input_field/field_form.dart';
import 'package:users_app/presentation/widgets/input_field/input_field.dart';


class UserForm extends ConsumerWidget {
  const UserForm({super.key, required this.formHandler});

  final FormHandler<FormHandlerState> formHandler;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FieldForm(
      isScrollControlled: true,
      fields: formHandler.formHolder.fields,
      formHandler: formHandler,
      fieldBuilder: (context, field) {
        return InputField<dynamic>(field: field, formHandler: formHandler,);
      },
    );
  }
}
