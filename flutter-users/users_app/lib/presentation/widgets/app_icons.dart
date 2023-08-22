import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:users_app/presentation/theme/app_theme.dart';
import 'package:users_app/presentation/theme/scale.dart';

class AppIcon extends StatelessWidget {
  const AppIcon(
    this.path, {
    Key? key,
    this.width = 24,
    this.height = 24,
    this.color,
    this.fit = BoxFit.contain,
  }) : super(key: key);

  final String path;
  final double width;
  final double height;
  final BoxFit fit;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      width: width.hs,
      height: height.hs,
      fit: fit,
      colorFilter: ColorFilter.mode(
        color ?? context.appTheme.iconColor,
        BlendMode.srcIn,
      ),
    );
  }
}

class AppIcons {
  static const arrowLeft = 'assets/icons/arrow-left.svg';
  static const calendar = 'assets/icons/calendar.svg';
  static const chevronDown = 'assets/icons/chevron-down.svg';
  static const close = 'assets/icons/close.svg';
  static const eyeSlash = 'assets/icons/eye-slash.svg';
  static const eye = 'assets/icons/eye.svg';
  static const facebook = 'assets/icons/facebook-flat.svg';
  static const google = 'assets/icons/google-flat.svg';
  static const apple = 'assets/icons/apple-flat.svg';
  static const fingerprint = 'assets/icons/finger-print.svg';
  static const faceId = 'assets/icons/face-id.svg';

  static List<String> get values => const [
        arrowLeft,
        calendar,
        chevronDown,
        close,
        eyeSlash,
        eye,
      ];
}
