import 'package:flutter/material.dart';
import 'package:users_app/presentation/theme/scale.dart';
import 'package:users_app/presentation/utils/type_scale.dart';

class TileButton extends StatelessWidget {
  const TileButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.leading,
    this.trailing,
    this.padding,
    this.leadingPadding,
    this.textStyle,
    this.splashColor = Colors.grey,
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;
  final Widget? leading;
  final Widget? trailing;
  final Color? splashColor;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final EdgeInsets? leadingPadding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      splashColor: splashColor?.withOpacity(0.2),
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Padding(
        padding: padding ?? EdgeInsets.symmetric(horizontal: 24.hs, vertical: 12.hs),
        child: Row(
          children: [
            if (leading != null)
              Container(
                padding: leadingPadding ?? EdgeInsets.only(right: 16.hs),
                child: leading,
              ),
            Expanded(
              child: TypeScale.bodyText1(Text(
                text,
                style: const TextStyle(height: 1.1).merge(textStyle),
              )),
            ),
            if (trailing != null) trailing!
          ],
        ),
      ),
    );
  }
}