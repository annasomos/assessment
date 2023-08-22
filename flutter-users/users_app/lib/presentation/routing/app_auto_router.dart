import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:users_app/presentation/routing/route_transition_builders.dart';
import 'package:users_app/screens/edit_user_screen.dart';
import 'package:users_app/screens/new_user.dart';
import 'package:users_app/screens/user_list_screen.dart';

@CustomAutoRouter(
  transitionsBuilder: RouteTransitionBuilders.fadeIn,
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute<void>(page: SharedScreen, initial: true, children: [
      AutoRoute<void>(page: UserListScreen, initial: true),
      AutoRoute<void>(page: NewUserScreen),
    ]),
    AutoRoute<void>(page: EditUserScreen),
  ],
)
class $AppAutoRouter {}

class SharedScreen extends StatelessWidget {
  const SharedScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
