import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:users_app/i18n/i18n.dart';
import 'package:users_app/models/user.dart';
import 'package:users_app/presentation/routing/app_auto_router.gr.dart';
import 'package:users_app/presentation/theme/app_theme.dart';
import 'package:users_app/providers/users_provider.dart';

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
    final activeContainerColor = context.appTheme.primaryContainer;
    final lockedContainerColor = context.appTheme.secondaryContainer;
    final activeTextColor = context.appTheme.primaryContainerText;
    final lockedTextColor = context.appTheme.onSecondary;
    final usernameText = context.appTheme.headingText;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr("general_phrases.all_users"),
          style: TextStyle(color: context.appTheme.onBackground),
        ),
        backgroundColor: context.appTheme.background,
        actions: [
          TextButton.icon(
            style:
                TextButton.styleFrom(iconColor: context.appTheme.primaryButton),
            onPressed: users.isRefreshing
                ? null
                : () {
                    context.navigateTo(
                        const SharedRoute(children: [NewUserRoute()]));
                  },
            icon: const Icon(Icons.add),
            label: Text(
              context.tr('general_phrases.add_user'),
              style: TextStyle(color: context.appTheme.primaryButton),
            ),
          )
        ],
      ),
      backgroundColor: context.appTheme.background,
      body: users.when(
          skipLoadingOnRefresh: false,
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

                    return Dismissible(
                      key: ValueKey(user),
                      confirmDismiss: (direction) {
                        return showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title:
                                  Text(context.tr("general_phrases.confirm")),
                              content: Text(
                                context.tr("general_phrases.confirm_delete"),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () =>
                                    context.popRoute(true),
                                    child: Text(
                                        context.tr("general_phrases.delete"))),
                                TextButton(
                                  onPressed: () =>
                                    context.popRoute(false),
                                  child: Text(
                                      context.tr("general_phrases.cancel")),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      onDismissed: (direction) {
                        handleDelete(user.id);
                      },
                      child: Container(
                        color: isActive(user)
                            ? activeContainerColor
                            : lockedContainerColor,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
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
                                  color: usernameText,
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
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            context.appTheme.primaryButton,
                                      ),
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
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            context.appTheme.primaryButton,
                                      ),
                                      icon: const Icon(Icons.edit),
                                      label: Text(
                                        context.tr('general_phrases.edit'),
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                      onPressed: isUserLoading
                                          ? null
                                          : () {
                                              context.navigateTo(EditUserRoute(
                                                  userId: user.id,
                                                  firstName: user.firstName,
                                                  lastName: user.lastName,
                                                  status: user.status.name));
                                            },
                                    ),
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
