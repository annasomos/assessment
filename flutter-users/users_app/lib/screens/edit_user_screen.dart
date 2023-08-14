import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:users_app/models/user_params.dart';
import 'package:users_app/presentation/widgets/user_form.dart';
import '../models/field/field.dart';
import '../models/user.dart';
import 'package:flutter/material.dart';
import '../presentation/utils/form_handler.dart';
import '../providers/users_provider.dart';
import '../utils/translated_value.dart';

class EditUserScreen extends HookConsumerWidget {
  const EditUserScreen(
      {super.key,
      required this.userId,
      required this.firstName,
      required this.lastName});

  final int userId;
  final String firstName;
  final String lastName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future onSave(UserParams params) async {
      return await ref.read(editUserMutation).mutate(params);
    }

    final AsyncValue<User> user = ref.watch(getUserByIdProvider(userId));
    print(
      TranslatedValue.key(
        "lastname",
      ),
    );
    final formHandler = useFormHandler({
      "first_name": Field.text(
        key: "first_name",
        initialValue: firstName,
        label: TranslatedValue.key(
          "firstname",
        ),
      ),
      "last_name": Field.text(
        key: "last_name",
        initialValue: lastName,
        label: TranslatedValue.key(
          "lastname",
        ),
      ),
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('User #$userId'),
      ),
      body: user.when(
        data: (data) => Center(
          child: Column(
            children: [
              UserForm(formHandler: formHandler),
              ElevatedButton.icon(
                label: const Text('Save'),
                icon: const Icon(Icons.save),
                onPressed: () {
                  final params = UserParams(
                      id: userId,
                      firstName: formHandler.getFieldValue("first_name"),
                      lastName: formHandler.getFieldValue("last_name"));
                  onSave(params)
                      .then((value) => Navigator.of(context).pop(context));
                },
              )
            ],
          ),
        ),
        error: (e, s) => const Center(
          child: Text('Uh oh, something went wrong.'),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
