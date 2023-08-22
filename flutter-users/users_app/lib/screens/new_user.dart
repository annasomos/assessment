import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:users_app/i18n/i18n.dart';
import 'package:users_app/presentation/theme/app_theme.dart';
import 'package:users_app/presentation/widgets/user_form.dart';

class NewUserScreen extends HookConsumerWidget {
  const NewUserScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        backgroundColor: context.appTheme.background,
        appBar: AppBar(
          backgroundColor: context.appTheme.background,
          title: Text(
            context.tr("general_phrases.add_user"),
          ),
        ),
        body: const UserForm(
            userId: null,
            firstName: "",
            lastName: "",
            status: "",
            userAction: UserFormAction.add));
  }
}
