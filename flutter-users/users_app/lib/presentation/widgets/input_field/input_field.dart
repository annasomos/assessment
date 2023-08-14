import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:users_app/presentation/theme/app_theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:users_app/models/field/field.dart';
import 'package:users_app/presentation/theme/scale.dart';
import 'package:users_app/presentation/utils/form_handler.dart';
import 'package:users_app/presentation/utils/type_scale.dart';
import 'package:users_app/presentation/widgets/companion_slide_in.dart';
import 'package:users_app/presentation/widgets/input_field/default_text_input_action.dart';
import 'package:users_app/presentation/widgets/input_field/input_field_theme.dart';
import 'package:users_app/utils/translated_value.dart';

class InputField<T> extends HookConsumerWidget {
  const InputField({
    Key? key,
    required this.field,
    this.onChanged,
    this.onFocusLost,
    this.suffix,
    this.formHandler,
    this.textInputAction,
    this.scrollPadding = const EdgeInsets.all(20),
    this.externalError,
  }) : super(key: key);
  final Field<T> field;
  final Function(T)? onChanged;
  final VoidCallback? onFocusLost;
  final Widget? suffix;
  final TranslatedValue? externalError;
  final FormHandler? formHandler;
  final EdgeInsets scrollPadding;
  final TextInputAction? textInputAction;
  T? get value => field.initialValue;
  TranslatedValue? get label => field.label;
  TranslatedValue? get hint => field.hint;
  String get fieldKey => field.key;
  FieldType get fieldType => field.type;
  TranslatedValue? get error => field.errorMessage ?? externalError;
  bool get mandatory => field.mandatory;
  bool get obscure => fieldType.maybeWhen(
        password: () => true,
        orElse: () => false,
      );
  int? get maxLines => field.type.maybeWhen(
        select: () => null,
        multiSelect: () => null,
        orElse: () => 1,
      );
  TextInputType? get keyboardType => fieldType.maybeWhen(
        email: () => TextInputType.emailAddress,
        phone: () => TextInputType.phone,
        number: () => TextInputType.number,
        orElse: () => TextInputType.text,
      );
  TextCapitalization get textCapitalization => fieldType.maybeWhen(
        email: () => TextCapitalization.none,
        password: () => TextCapitalization.none,
        orElse: () => TextCapitalization.sentences,
      );
  List<TextInputFormatter>? get inputFormatters => fieldType.maybeWhen(
        number: () => [FilteringTextInputFormatter.allow(RegExp(r'[0-9]|\.'))],
        orElse: () => null,
      );
  bool get absorbPointer {
    return fieldType.maybeMap(
      duration: (_) => true,
      date: (_) => true,
      time: (_) => true,
      select: (_) => true,
      multiSelect: (_) => true,
      orElse: () => false,
    );
  }
  FloatingLabelBehavior get floatingLabelBehavior {
    if (hint == null) {
      return FloatingLabelBehavior.auto;
    }
    return FloatingLabelBehavior.always;
  }
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFocused = useState(false);
    final isObscure = useState(obscure);
    final formHandlerOrDefault = formHandler ?? ref.watch(formHandlerProvider);
    final textInputActionOrDefault = textInputAction ?? ref.watch(textInputActionProvider);
    final enabled = onChanged != null || formHandlerOrDefault != null;
    final hasError = error != null;
    final inputState = _getInputFieldState(
      disabled: !enabled,
      focused: isFocused.value,
      error: hasError,
    );
    final inputFieldTheme = context.appTheme.getInputFieldTheme(fieldType);
    final displayValue = field.getDisplayValue(context, ref);
    final controller = useTextEditingController(text: displayValue);
    if (displayValue != controller.text) {
      controller.value = TextEditingValue(
        selection: controller.selection.copyWith(
          baseOffset: controller.selection.baseOffset.clamp(0, displayValue.length),
          extentOffset: controller.selection.extentOffset.clamp(0, displayValue.length),
        ),
        text: displayValue,
      );
    }
    void handleChange(String value) {
      formHandlerOrDefault?.setFieldValue(fieldKey, value);
      onChanged?.call(value as T);
    }
    void handleFocusChange(bool hasFocus) {
      if (!hasFocus) {
        onFocusLost?.call();
        formHandlerOrDefault?.showFieldError(fieldKey);
      }
      isFocused.value = hasFocus;
    }
    void handleSumbitted(String _) {
      if (textInputActionOrDefault == TextInputAction.next) {
        _focusNextNonUnspecifiedEditableText(context);
      }
    }
    String _getLabel() {
      if (label == null) {
        return '';
      }
      final mandatorySign = mandatory ? '*' : '';
      final displayLabel = label!.getValue(ref);
      return "$displayLabel$mandatorySign";
    }
    Widget? _getSuffix() {
      return suffix;
    }
    return CompanionSlideIn(
      builder: (context) {
        return Builder(
          builder: (context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  child: Focus(
                    onFocusChange: handleFocusChange,
                    child: AbsorbPointer(
                      absorbing: absorbPointer,
                      child: TextField(
                        controller: controller,
                        enabled: enabled,
                        autocorrect: false,
                        maxLines: maxLines,
                        keyboardType: keyboardType,
                        obscureText: isObscure.value,
                        textCapitalization: textCapitalization,
                        inputFormatters: inputFormatters,
                        textInputAction: textInputActionOrDefault,
                        onChanged: handleChange,
                        onSubmitted: handleSumbitted,
                        scrollPadding: scrollPadding,
                        style: inputFieldTheme.getTextStyle(inputState),
                        decoration: InputDecoration(
                          isDense: true,
                          labelText: _getLabel(),
                          hintText: hint?.getValue(ref),
                          suffixIcon: _getSuffix(),
                          alignLabelWithHint: true,
                          floatingLabelBehavior: floatingLabelBehavior,
                          labelStyle: inputFieldTheme.getLabelStyle(inputState),
                          floatingLabelStyle: inputFieldTheme.getLabelStyle(inputState),
                          enabledBorder: inputFieldTheme.getBorderStyle(inputState),
                          disabledBorder: inputFieldTheme.getBorderStyle(inputState),
                          focusedBorder: inputFieldTheme.getBorderStyle(inputState),
                          suffixIconConstraints: inputFieldTheme.suffixIconStyle?.constraints,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
      companionBuilder: (context) {
        return TypeScale.caption(
          Text(
            error?.getValue(ref) ?? '',
            style: TextStyle(color: context.appTheme.error),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        );
      },
      visible: hasError,
    );
  }
}
Widget _buildSelectFieldSuffix({Color? color, EdgeInsets? margin}) {
  return Container(
    margin: margin,
    child: Icon(
      Icons.arrow_drop_down,
      size: 24.hs,
      color: color,
    ),
  );
}
InputFieldState _getInputFieldState({
  required bool disabled,
  required bool focused,
  required bool error,
}) {
  if (disabled) {
    return const InputFieldState.disabled();
  }
  if (error && focused) {
    return const InputFieldState.focusedError();
  }
  if (error) {
    return const InputFieldState.error();
  }
  if (focused) {
    return const InputFieldState.focused();
  }
  return const InputFieldState.active();
}
void _focusNextNonUnspecifiedEditableText(BuildContext context) {
  FocusScope.of(context).nextFocus();
  final widget = FocusScope.of(context).focusedChild?.context?.widget;
  if (widget is! EditableText || widget.textInputAction == TextInputAction.unspecified) {
    _focusNextNonUnspecifiedEditableText(context);
  }
}