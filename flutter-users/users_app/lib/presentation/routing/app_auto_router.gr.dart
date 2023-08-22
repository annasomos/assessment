// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:flutter/widgets.dart' as _i8;

import '../../screens/edit_user_screen.dart' as _i2;
import '../../screens/new_user.dart' as _i4;
import '../../screens/user_list_screen.dart' as _i3;
import 'app_auto_router.dart' as _i1;
import 'route_transition_builders.dart' as _i7;

class AppAutoRouter extends _i5.RootStackRouter {
  AppAutoRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    SharedRoute.name: (routeData) {
      return _i5.CustomPage<void>(
        routeData: routeData,
        child: const _i1.SharedScreen(),
        transitionsBuilder: _i7.RouteTransitionBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    EditUserRoute.name: (routeData) {
      final args = routeData.argsAs<EditUserRouteArgs>();
      return _i5.CustomPage<void>(
        routeData: routeData,
        child: _i2.EditUserScreen(
          key: args.key,
          userId: args.userId,
          firstName: args.firstName,
          lastName: args.lastName,
          status: args.status,
        ),
        transitionsBuilder: _i7.RouteTransitionBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    UserListRoute.name: (routeData) {
      return _i5.CustomPage<void>(
        routeData: routeData,
        child: const _i3.UserListScreen(),
        transitionsBuilder: _i7.RouteTransitionBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    NewUserRoute.name: (routeData) {
      return _i5.CustomPage<void>(
        routeData: routeData,
        child: const _i4.NewUserScreen(),
        transitionsBuilder: _i7.RouteTransitionBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(
          SharedRoute.name,
          path: '/',
          children: [
            _i5.RouteConfig(
              UserListRoute.name,
              path: '',
              parent: SharedRoute.name,
            ),
            _i5.RouteConfig(
              NewUserRoute.name,
              path: 'new-user-screen',
              parent: SharedRoute.name,
            ),
          ],
        ),
        _i5.RouteConfig(
          EditUserRoute.name,
          path: '/edit-user-screen',
        ),
      ];
}

/// generated route for
/// [_i1.SharedScreen]
class SharedRoute extends _i5.PageRouteInfo<void> {
  const SharedRoute({List<_i5.PageRouteInfo>? children})
      : super(
          SharedRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'SharedRoute';
}

/// generated route for
/// [_i2.EditUserScreen]
class EditUserRoute extends _i5.PageRouteInfo<EditUserRouteArgs> {
  EditUserRoute({
    _i8.Key? key,
    required int userId,
    required String firstName,
    required String lastName,
    required String status,
  }) : super(
          EditUserRoute.name,
          path: '/edit-user-screen',
          args: EditUserRouteArgs(
            key: key,
            userId: userId,
            firstName: firstName,
            lastName: lastName,
            status: status,
          ),
        );

  static const String name = 'EditUserRoute';
}

class EditUserRouteArgs {
  const EditUserRouteArgs({
    this.key,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.status,
  });

  final _i8.Key? key;

  final int userId;

  final String firstName;

  final String lastName;

  final String status;

  @override
  String toString() {
    return 'EditUserRouteArgs{key: $key, userId: $userId, firstName: $firstName, lastName: $lastName, status: $status}';
  }
}

/// generated route for
/// [_i3.UserListScreen]
class UserListRoute extends _i5.PageRouteInfo<void> {
  const UserListRoute()
      : super(
          UserListRoute.name,
          path: '',
        );

  static const String name = 'UserListRoute';
}

/// generated route for
/// [_i4.NewUserScreen]
class NewUserRoute extends _i5.PageRouteInfo<void> {
  const NewUserRoute()
      : super(
          NewUserRoute.name,
          path: 'new-user-screen',
        );

  static const String name = 'NewUserRoute';
}
