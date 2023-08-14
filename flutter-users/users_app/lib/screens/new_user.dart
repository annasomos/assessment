import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:users_app/models/field/field.dart';
import 'package:users_app/models/user_params.dart';
import 'package:flutter/material.dart';
import 'package:users_app/presentation/utils/form_handler.dart';
import 'package:users_app/presentation/widgets/user_form.dart';
import 'package:users_app/utils/translated_value.dart';
import '../models/user.dart';
import '../providers/users_provider.dart';

class NewUserScreen extends HookConsumerWidget {
  const NewUserScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formHandler = useFormHandler({
      "first_name": Field.text(
        key: "first_name",
        initialValue: "",
        label: TranslatedValue.key(
          "firstname",
        ),
      ),
      "last_name": Field.text(
        key: "last_name",
        initialValue: "",
        label: TranslatedValue.key(
          "lastname",
        ),
      ),
    });
    final AsyncValue<List<User>> users = ref.watch(getAllUsersProvider);
    Future onSave(UserParams params) async {
      await ref.read(addUserMutation).mutate(params);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
      ),
      body: Center(
        child: Column(
          children: [
            UserForm(formHandler: formHandler),
            ElevatedButton.icon(
              label: const Text('Save User'),
              icon: const Icon(Icons.save),
              onPressed: users.isRefreshing
                  ? null
                  : () {
                      final params =
                          UserParams(firstName: formHandler.getFieldValue("first_name"), lastName: formHandler.getFieldValue("last_name"));
                      onSave(params)
                          .then((value) => Navigator.of(context).pop());
                    },
            )
          ],
        ),
      ),
    );
  }
}
