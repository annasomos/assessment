import 'package:auto_route/auto_route.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:users_app/i18n/i18n.dart';
import 'package:users_app/models/field/field.dart';
import 'package:users_app/models/user_params.dart';
import 'package:flutter/material.dart';
import 'package:users_app/presentation/theme/app_theme.dart';
import 'package:users_app/presentation/utils/form_handler.dart';
import 'package:users_app/presentation/widgets/input_field/select_field_sheet.dart';
import 'package:users_app/presentation/widgets/user_name_form.dart';
import 'package:users_app/providers/users_provider.dart';
import 'package:users_app/utils/translated_value.dart';

enum UserFormAction { add, edit }

class UserForm extends HookConsumerWidget {
  const UserForm(
      {super.key,
      required this.userId,
      required this.firstName,
      required this.lastName,
      required this.status,
      required this.userAction});

  final int? userId;
  final String firstName;
  final String lastName;
  final String status;
  final UserFormAction userAction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusOptions = {
      "active": SelectFieldOption(
          id: "active",
          label: TranslatedValue.key("general_phrases.active"),
          value: "active"),
      "locked": SelectFieldOption(
          id: "locked",
          label: TranslatedValue.key("general_phrases.locked"),
          value: "locked"),
    };

    final statusState = useState(status);

    final saveButtonIsLoading = useState(false);

    final buttonText = useState(Text(context.tr(status.isEmpty
        ? "general_phrases.select_status"
        : "general_phrases.$status")));

    final formHandler = useFormHandler({
      "first_name": Field.text(
        key: "first_name",
        initialValue: firstName,
        rules: [
          FieldRule.mandatory(
            message: TranslatedValue.key("general_phrases.first_name_error"),
          ),
          FieldRule.validation(
            message: TranslatedValue.key("general_phrases.first_name_invalid"),
            FieldValidator(
              validator: (value) {
                if (value.length < 2 || value.trim().isEmpty) {
                  return false;
                }
                return true;
              },
            ),
          )
        ],
        label: TranslatedValue.key(
          "general_phrases.first_name",
        ),
      ),
      "last_name": Field.text(
        key: "last_name",
        initialValue: lastName,
        rules: [
          FieldRule.mandatory(
            message: TranslatedValue.key("general_phrases.last_name_error"),
          ),
          FieldRule.validation(
            message: TranslatedValue.key("general_phrases.last_name_invalid"),
            FieldValidator(
              validator: (value) {
                if (value.length < 2 || value.trim().isEmpty) {
                  return false;
                }
                return true;
              },
            ),
          )
        ],
        label: TranslatedValue.key(
          "general_phrases.last_name",
        ),
      ),
    });

    Future onSave(dynamic params) async {
      formHandler.trySubmit(() async {
        saveButtonIsLoading.value = true;
        if (userAction == UserFormAction.add) {
          await ref
              .watch(addUserMutation)
              .mutate(params)
              .then((value) => context.popRoute());
        } else {
          await ref
              .watch(editUserMutation)
              .mutate(params)
              .then((value) => context.popRoute());
        }
      });
    }

    return Center(
      child: Column(
        children: [
          UserNameForm(
            formHandler: formHandler,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                    foregroundColor: context.appTheme.onBackground),
                onPressed: () {
                  showSelectFieldSheet(context,
                      title: "Choose a status",
                      selectedOption: null,
                      options: statusOptions, onSelect: (selectedOption) {
                    statusState.value = selectedOption.value;
                    buttonText.value = Text(
                        context.tr('general_phrases.${selectedOption.value}'));
                  });
                },
                child: buttonText.value,
              ),
            ],
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: context.appTheme.primaryButton,
            ),
            label: Text(
              context.tr("general_phrases.save"),
            ),
            icon: const Icon(Icons.save),
            onPressed: saveButtonIsLoading.value
                ? null
                : () {
                    if (userAction == UserFormAction.add) {
                      final params = NewUserParams(
                          firstName: formHandler.getFieldValue("first_name"),
                          lastName: formHandler.getFieldValue("last_name"),
                          status: statusState.value != ""
                              ? statusState.value
                              : "active");
                      onSave(params);
                    } else {
                      final params = EditUserParams(
                          id: userId,
                          firstName: formHandler.getFieldValue("first_name"),
                          lastName: formHandler.getFieldValue("last_name"),
                          status: statusState.value.isEmpty
                              ? "active"
                              : statusState.value);
                      onSave(params);
                    }
                  },
          )
        ],
      ),
    );
  }
}
