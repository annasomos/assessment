import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:users_app/models/field/field.dart';
import 'package:users_app/presentation/theme/app_theme.dart';
import 'package:users_app/presentation/theme/scale.dart';
import 'package:users_app/presentation/utils/type_scale.dart';
import 'package:users_app/presentation/widgets/app_icon_button.dart';
import 'package:users_app/presentation/widgets/app_icons.dart';
import 'package:users_app/presentation/widgets/scrollable_bottom_sheet.dart';
import 'package:users_app/presentation/widgets/tile_button.dart';

void showSelectFieldSheet(
  BuildContext context, {
  required String? title,
  required SelectFieldOption? selectedOption,
  required Map<String, SelectFieldOption> options,
  required void Function(SelectFieldOption value)? onSelect,
}) {
  showScrollableBottomSheet<void>(
    context: context,
    builder: (modalContext) => SelectFieldSheet(
      options: options,
      selectedOption: selectedOption,
      onSelect: onSelect,
      title: title,
    ),
  );
}

class SelectFieldSheet extends HookConsumerWidget {
  const SelectFieldSheet({
    Key? key,
    this.title,
    required this.options,
    required this.selectedOption,
    required this.onSelect,
  }) : super(key: key);

  final String? title;
  final SelectFieldOption? selectedOption;
  final Map<String, SelectFieldOption> options;
  final void Function(SelectFieldOption value)? onSelect;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _selectedOption = useState(selectedOption);

    return ScrollableBottomSheet<void>(
      isScrollControlled: true,
      headerBuilder: (context, closeSheet) => _SelectFieldSheetHeader(
        title: title,
        onPressed: closeSheet,
      ),
      padding: EdgeInsets.only(bottom: 20.hs),
      builder: (context, closeSheet, controller) => ListView.builder(
        controller: controller,
        padding: EdgeInsets.zero,
        shrinkWrap: options.length < 30,
        physics: const ClampingScrollPhysics(),
        itemCount: options.length,
        itemBuilder: (context, index) {
          final option = options.values.toList()[index];
          final isSelected = option.id == _selectedOption.value?.id;
          final textColor = isSelected
              ? context.appTheme.primaryButton
              : context.appTheme.onBackground;

          void handlePress() {
            onSelect?.call(option);
            _selectedOption.value = option;
            closeSheet();
           // context.popRoute();
          }

          return Column(
            children: [
              TileButton(
                text: option.label.getValue(ref),
                onPressed: isSelected ? null : handlePress,
                textStyle:
                    AppTheme.of(context).bodyText1.copyWith(color: textColor),
                padding:
                    EdgeInsets.symmetric(horizontal: 26.hs, vertical: 11.hs),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SelectFieldSheetHeader extends HookWidget {
  const _SelectFieldSheetHeader({
    Key? key,
    this.title,
    required this.onPressed,
  }) : super(key: key);

  final String? title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final titleWidget = useMemoized(() {
      if (title == null) {
        return const SizedBox();
      }
      return TypeScale.bodyText1(Text(title!));
    }, [title]);

    return Material(
      type: MaterialType.transparency,
      child: Padding(
        padding:
            EdgeInsets.only(top: 6.hs, left: 26.hs, right: 10.hs, bottom: 8.hs),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            titleWidget,
            SizedBox(
              width: 36.hs,
              height: 36.hs,
              child: AppIconButton(
                icon: AppIcon(
                  AppIcons.close,
                  color: context.appTheme.primaryButton,
                ),
                splashRadius: 14,
                onPressed: onPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
