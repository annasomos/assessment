import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:users_app/i18n/i18n_provider.dart';
import 'package:users_app/providers/users_provider.dart';
import 'package:users_app/screens/edit_user_screen.dart';
import 'package:users_app/screens/new_user.dart';
import '../models/user.dart';

class UserListScreen extends ConsumerWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    Future handleDelete(int userId) async {
      return await ref.read(deleteUserMutation).mutate(userId);
    }

    final AsyncValue<List<User>> users = ref.watch(getAllUsersProvider);

    final primaryColor = Theme.of(context).colorScheme.primaryContainer;
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr("general_phrases.all_users")),
        actions: [
          TextButton.icon(
            onPressed: users.isRefreshing
                ? null
                : () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => const NewUserScreen(),
                      ),
                    );
                  },
            icon: const Icon(Icons.add),
            label: Text(context.tr('general_phrases.add_user')),
          )
        ],
      ),
      body: users.when(
          data: (allUsers) => ListView.builder(
                itemCount: allUsers.length,
                itemBuilder: (context, index) {
                  return HookBuilder(builder: (context) {
                    final user = allUsers[index];

                    final updateMutation =
                        useState(updateUserStatusMutation2());
                    final isUserLoading =
                        ref.watch(updateMutation.value).isLoading;
                    Future handleStatusChange(User user) async {
                      return await ref.read(updateMutation.value).mutate(user);
                    }

                    return Card(
                      key: ValueKey(user),
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                user.getFullName(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(user.getFormattedCreatedAt()),
                              Text(user.getFormattedUpdatedAt()),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      key: ValueKey(user),
                                      onPressed: isUserLoading
                                          ? null
                                          : () {
                                              handleStatusChange(user);
                                            },
                                      icon: user.status == Status.active
                                          ? const Icon(Icons.lock)
                                          : const Icon(Icons.lock_open),
                                      label: Text(user.status == Status.active
                                          ? context.tr('general_phrases.lock')
                                          : context.tr('general_phrases.activate')),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  ElevatedButton.icon(
                                    icon: const Icon(Icons.edit),
                                    label: Text(context.tr('general_phrases.edit')),
                                    onPressed: isUserLoading
                                        ? null
                                        : () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (ctx) =>
                                                    EditUserScreen(
                                                  userId: user.id,
                                                  firstName: user.firstName,
                                                  lastName: user.lastName,
                                                ),
                                              ),
                                            );
                                          },
                                  ),
                                  const SizedBox(width: 10),
                                  TextButton.icon(
                                      label: Text(context.tr('general_phrases.delete')),
                                      onPressed: isUserLoading
                                          ? null
                                          : () {
                                              handleDelete(user.id);
                                            },
                                      icon: const Icon(Icons.delete)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
                },
              ),
          error: (e, s) => Center(
                child: Text(e.toString() + s.toString()),
              ),
          loading: () => const Center(
                child: CircularProgressIndicator(),
              )),
    );
  }
}
