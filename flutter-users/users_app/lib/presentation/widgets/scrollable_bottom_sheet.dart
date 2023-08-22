import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:users_app/presentation/theme/app_theme.dart';
import 'package:users_app/presentation/theme/scale.dart';

final scrollableBottomSheetHeaderPadding =
    EdgeInsets.only(left: 20.hs, right: 10.hs, top: 6.hs, bottom: 6.hs);

Future<T?> showScrollableBottomSheet<T>({
  required BuildContext context,
  required Widget Function(BuildContext) builder,
}) async {
  return showMaterialModalBottomSheet<T>(
    useRootNavigator: true,
    context: context,
    backgroundColor: Colors.transparent,
    builder: builder,
  );
}

class ScrollableBottomSheet<T> extends HookWidget {
  const ScrollableBottomSheet({
    Key? key,
    required this.builder,
    this.headerBuilder,
    this.footerBuilder,
    this.isLoading = false,
    this.isScrollControlled = false,
    this.padding,
    this.backgroundColor,
  }) : super(key: key);

  final Widget Function(
    BuildContext context,
    Function({T? result}) closeSheet,
    ScrollController? controller,
  ) builder;

  final Widget Function(
    BuildContext context,
    Function({T? result}) closeSheet,
  )? headerBuilder;

  final Widget Function(
    BuildContext context,
    Function({T? result}) closeSheet,
  )? footerBuilder;

  final bool isScrollControlled;
  final bool isLoading;
  final EdgeInsets? padding;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final scrollController = useState(ModalScrollController.of(context));

    final isHeaderShadowVisible = useState(false);
    final isFooterShadowVisible = useState(false);

    void closeSheet({T? result}) {
        Navigator.pop(context, result);
    }

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        isFooterShadowVisible.value =
            ((scrollController.value?.position.maxScrollExtent) ?? 0) > 0;
      });
      return null;
    }, []);

    bool handleScrollNotification(ScrollNotification notification) {
      isHeaderShadowVisible.value = notification.metrics.extentBefore > 0;
      isFooterShadowVisible.value = notification.metrics.extentAfter != 0;
      return true;
    }

    final sheetBoxDecoration = useMemoized(() => BoxDecoration(
          color: backgroundColor ?? context.appTheme.primaryContainer,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.hs)),
        ));

    return SafeArea(
      bottom: false,
      child: Container(
        decoration: sheetBoxDecoration,
        padding: padding,
        child: SafeArea(
          bottom: footerBuilder == null,
          child: Material(
            type: MaterialType.transparency,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (headerBuilder != null)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: sheetBoxDecoration.copyWith(
                      boxShadow: [
                        BoxShadow(
                          color: isHeaderShadowVisible.value
                              ? AppTheme.dark.withOpacity(0.5)
                              : Colors.transparent,
                          offset: const Offset(0, -1),
                          blurRadius: 16,
                        )
                      ],
                    ),
                    child: headerBuilder!(context, closeSheet),
                  ),
                Flexible(
                  child: NotificationListener<ScrollUpdateNotification>(
                    onNotification: handleScrollNotification,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AnimatedOpacity(
                          opacity: isLoading ? 0 : 1,
                          duration: const Duration(milliseconds: 200),
                          child: Builder(
                            builder: (context) {
                              if (isScrollControlled) {
                                return builder(context, closeSheet,
                                    scrollController.value);
                              } else {
                                return SingleChildScrollView(
                                  physics: const ClampingScrollPhysics(),
                                  controller: scrollController.value,
                                  child: builder(context, closeSheet,
                                      scrollController.value),
                                );
                              }
                            },
                          ),
                        ),
                        if (isLoading) const CircularProgressIndicator()
                      ],
                    ),
                  ),
                ),
                if (footerBuilder != null)
                  _BottomSheetFooter(
                    shadowVisible: isFooterShadowVisible.value,
                    child: footerBuilder!(context, closeSheet),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomSheetFooter extends StatelessWidget {
  const _BottomSheetFooter({
    Key? key,
    required this.child,
    this.shadowVisible = false,
  }) : super(key: key);

  final Widget child;
  final bool shadowVisible;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: AppTheme.of(context).surface,
        boxShadow: [
          BoxShadow(
            color: shadowVisible
                ? AppTheme.dark.withOpacity(0.1)
                : Colors.transparent,
            offset: const Offset(0, -1),
            blurRadius: 16,
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Material(
              type: MaterialType.transparency,
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
