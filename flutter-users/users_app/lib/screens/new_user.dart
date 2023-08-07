import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:users_app/models/user_params.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../providers/users_provider.dart';

class NewUserScreen extends ConsumerWidget {
  const NewUserScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<User>> users = ref.watch(getAllUsersProvider);
    String firstName = '';
    String lastName = '';
    Future onSave(UserParams params) async {
      await ref.read(addUserMutation.notifier).mutate(params);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
      ),
      body: Center(
        child: Column(
          children: [
            TextFormField(
              onChanged: (value) {
                firstName = value;
              },
            ),
            TextFormField(
              onChanged: (value) {
                lastName = value;
              },
            ),
            ElevatedButton.icon(
              label: const Text('Save User'),
              icon: const Icon(Icons.save),
              onPressed: users.isRefreshing ? null : () {
                final params =
                    UserParams(firstName: firstName, lastName: lastName);
                onSave(params).then((value) => Navigator.of(context).pop());
                
              },
            )
          ],
        ),
      ),
    );
  }
}
