import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:users_app/presentation/theme/app_theme.dart';

class RouteTransitionBuilders {
  RouteTransitionBuilders();

  static const RouteTransitionsBuilder fadeIn = _fadeIn;

  static Widget _fadeIn(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return Builder(
      builder: (context) {
        final isRoot = AutoRouter.of(context).isRoot;
        return Container(
          decoration: BoxDecoration(color: isRoot ? AppTheme.of(context).background : Colors.transparent),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
    );
  }
}