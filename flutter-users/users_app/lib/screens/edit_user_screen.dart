import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:users_app/i18n/i18n.dart';
import 'package:users_app/presentation/theme/app_theme.dart';
import 'package:users_app/presentation/widgets/user_form.dart';
import 'package:flutter/material.dart';

class EditUserScreen extends HookConsumerWidget {
  const EditUserScreen(
      {super.key,
      required this.userId,
      required this.firstName,
      required this.lastName,
      required this.status});

  final int userId;
  final String firstName;
  final String lastName;
  final String status;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        backgroundColor: context.appTheme.background,
        appBar: AppBar(
          backgroundColor: context.appTheme.background,
          title: Text(
            '${context.tr("general_phrases.user")} #$userId',
          ),
        ),
        body: UserForm(
            userId: userId,
            firstName: firstName,
            lastName: lastName,
            status: status,
            userAction: UserFormAction.edit));
  }
}
