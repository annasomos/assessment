import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:users_app/models/user_params.dart';
import '../models/user.dart';
import 'package:flutter/material.dart';
import '../providers/users_provider.dart';

class EditUserScreen extends ConsumerWidget {
  const EditUserScreen({super.key, required this.userId});

  final int userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String firstName = '';
    String lastName = '';
    Future onSave(UserParams params) async {
      return await ref.read(editUserMutation).mutate(params);
    }

    final AsyncValue<User> user = ref.watch(getUserByIdProvider(userId));
    user.whenData(
      (value) {
        firstName = value.firstName;
        lastName = value.lastName;
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('User #$userId'),
      ),
      body: user.when(
        data: (data) => Center(
          child: Column(
            children: [
              TextFormField(
                initialValue: data.firstName,
                onChanged: (value) {
                  firstName = value;
                },
              ),
              TextFormField(
                initialValue: data.lastName,
                onChanged: (value) {
                  lastName = value;
                },
              ),
              ElevatedButton.icon(
                label: const Text('Save'),
                icon: const Icon(Icons.save),
                onPressed: () {
                  final params = UserParams(
                      id: userId, firstName: firstName, lastName: lastName);
                  onSave(params).then((value) => Navigator.of(context).pop(context));
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
