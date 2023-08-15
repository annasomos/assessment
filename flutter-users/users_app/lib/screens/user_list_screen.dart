import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:users_app/i18n/i18n.dart';
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

    bool isActive(User user) {
      return user.status == Status.active;
    }

    final AsyncValue<List<User>> users = ref.watch(getAllUsersProvider);
    final activeContainerColor =
        Theme.of(context).colorScheme.secondaryContainer;
    final lockedContainerColor =
        Theme.of(context).colorScheme.primaryContainer.withOpacity(0.1);
    final activeTextColor = Theme.of(context).colorScheme.onPrimaryContainer;
    const lockedTextColor = Color.fromARGB(123, 0, 0, 0);

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
                      color: isActive(user)
                          ? activeContainerColor.withOpacity(0.4)
                          : lockedContainerColor,
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
                                  color: isActive(user)
                                      ? activeTextColor
                                      : lockedTextColor,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                user.getFormattedCreatedAt(),
                                style: TextStyle(
                                  color: isActive(user)
                                      ? activeTextColor
                                      : lockedTextColor,
                                ),
                              ),
                              Text(
                                user.getFormattedUpdatedAt(),
                                style: TextStyle(
                                  color: isActive(user)
                                      ? activeTextColor
                                      : lockedTextColor,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      key: ValueKey(user),
                                      style: ElevatedButton.styleFrom(backgroundColor: isActive(user) ? activeContainerColor : lockedTextColor),
                                      onPressed: isUserLoading
                                          ? null
                                          : () {
                                              handleStatusChange(user);
                                            },
                                      icon: user.status == Status.active
                                          ? const Icon(Icons.lock_open)
                                          : const Icon(Icons.lock),
                                      label: Text(
                                        user.status == Status.active
                                            ? context.tr('general_phrases.lock')
                                            : context
                                                .tr('general_phrases.activate'),
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(backgroundColor: isActive(user) ? activeContainerColor : lockedTextColor),
                                      icon: const Icon(Icons.edit),
                                      label: Text(
                                        context.tr('general_phrases.edit'),
                                        style: const TextStyle(fontSize: 12),
                                      ),
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
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextButton.icon(
                                        label: Text(
                                          context.tr('general_phrases.delete'),
                                          style: TextStyle(fontSize: 12, color: isActive(user) ? activeTextColor : lockedTextColor),
                                        ),
                                        onPressed: isUserLoading
                                            ? null
                                            : () {
                                                handleDelete(user.id);
                                              },
                                        icon: Icon(Icons.delete, color: isActive(user) ? activeTextColor : lockedTextColor,)),
                                  ),
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
