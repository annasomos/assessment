import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:users_app/providers/users_provider.dart';
import 'package:users_app/screens/edit_user_screen.dart';
import 'package:users_app/screens/new_user.dart';

import '../models/user.dart';

class UserListScreen extends ConsumerWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future handleStatusChange(User user) async {
      return await ref.read(updateUserStatusMutation).mutate(user);
    }

    Future handleDelete(int userId) async {
      return await ref.read(deleteUserMutation).mutate(userId);
    }

    final AsyncValue<List<User>> users = ref.watch(getAllUsersProvider);
    users.whenData(
        (value) => value.sort((a, b) => b.createdAt.compareTo(a.createdAt)));
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Users'),
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
            label: const Text('Add User'),
          )
        ],
      ),
      body: users.when(
          data: (allUsers) => ListView.builder(
                itemCount: allUsers.length,
                itemBuilder: (context, index) => Card(
                  key: ValueKey(allUsers[index]),
                  elevation: 2,
                  color: allUsers[index].status == Status.active
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Theme.of(context)
                          .colorScheme
                          .primaryContainer
                          .withOpacity(0.4),
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${allUsers[index].firstName} ${allUsers[index].lastName}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                              'Created at: ${allUsers[index].createdAt}'),
                          Text(
                              'Last updated: ${allUsers[index].updatedAt}'),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  key: ValueKey(allUsers[index]),
                                  onPressed: users.isRefreshing
                                      ? null
                                      : () {
                                          handleStatusChange(allUsers[index]);
                                        },
                                  icon: allUsers[index].status == Status.active
                                      ? const Icon(Icons.lock)
                                      : const Icon(Icons.lock_open),
                                  label: Text(allUsers[index].status == Status.active
                                      ? 'Lock'
                                      : 'Activate'),
                                ),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton.icon(
                                icon: const Icon(Icons.edit),
                                label: const Text('Edit'),
                                onPressed: users.isRefreshing
                                    ? null
                                    : () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (ctx) => EditUserScreen(
                                              userId: allUsers[index].id,
                                            ),
                                          ),
                                        );
                                      },
                              ),
                              const SizedBox(width: 10),
                              TextButton.icon(
                                  label: const Text('Delete'),
                                  onPressed: users.isRefreshing
                                      ? null
                                      : () {
                                          handleDelete(allUsers[index].id);
                                        },
                                  icon: const Icon(Icons.delete)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
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
