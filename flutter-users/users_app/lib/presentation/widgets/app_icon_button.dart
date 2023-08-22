import 'package:flutter/material.dart';
import 'package:users_app/presentation/theme/scale.dart';

const defaultSplashRadius = 20.0;

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    Key? key,
    required this.icon,
    this.onPressed,
    this.splashRadius = defaultSplashRadius,
    this.color,
  }) : super(key: key);

  final Widget icon;
  final VoidCallback? onPressed;
  final double splashRadius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon,
      color: color,
      onPressed: onPressed,
      splashRadius: splashRadius.hs,
    );
  }
}