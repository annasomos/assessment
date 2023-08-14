
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

final slideInTopOffset = Tween<Offset>(
  begin: const Offset(0.0, -1.0),
  end: const Offset(0.0, 0.0),
);

class CompanionSlideIn extends StatelessWidget {
  const CompanionSlideIn({
    Key? key,
    required this.builder,
    required this.companionBuilder,
    required this.visible,
  }) : super(key: key);

  final WidgetBuilder builder;
  final WidgetBuilder companionBuilder;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      verticalDirection: VerticalDirection.up,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HookBuilder(
          builder: (context) {
            final companionSlideController = useAnimationController(
              duration: const Duration(milliseconds: 200),
              initialValue: visible ? 1 : 0,
            );
            useValueChanged<bool, void>(visible, (_, __) {
              if (visible) {
                companionSlideController.forward();
              } else {
                companionSlideController.animateBack(0, duration: Duration.zero);
              }
            });

            return AnimatedBuilder(
              animation: companionSlideController,
              builder: (context, child) {
                if (!visible) {
                  return const SizedBox();
                }

                return SizeTransition(
                  sizeFactor: companionSlideController.drive(
                    CurveTween(curve: Curves.easeIn),
                  ),
                  child: SlideTransition(
                    position: companionSlideController.drive(slideInTopOffset),
                    child: child,
                  ),
                );
              },
              child: companionBuilder(context),
            );
          },
        ),
        builder(context),
      ],
    );
  }
}