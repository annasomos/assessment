import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final textInputActionProvider = Provider<TextInputAction>((ref) {
  return TextInputAction.done;
});

class DefaultTextInputAction extends StatelessWidget {
  const DefaultTextInputAction({Key? key, required this.child, required this.textInputAction}) : super(key: key);

  final Widget child;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: child,
      overrides: [
        textInputActionProvider.overrideWithValue(textInputAction),
      ],
    );
  }
}
