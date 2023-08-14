import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'input_field_theme.freezed.dart';

class InputFieldTheme {
  const InputFieldTheme({
    this.textStyle,
    this.labelStyle,
    this.border,
    this.suffixIconStyle,
  });

  final InputFieldStateProperty<TextStyle>? textStyle;
  final InputFieldStateProperty<TextStyle>? labelStyle;
  final InputFieldStateProperty<InputBorder>? border;
  final InputFieldIconStyle? suffixIconStyle;

  TextStyle? getTextStyle(InputFieldState fieldState) {
    return _getTextStyle(
      style: textStyle,
      fieldState: fieldState,
    );
  }

  TextStyle? getLabelStyle(InputFieldState fieldState) {
    return _getTextStyle(
      style: labelStyle,
      fieldState: fieldState,
    );
  }

  InputBorder? getBorderStyle(InputFieldState fieldState) {
    return _getBorderStyle(fieldState);
  }

  InputBorder? getEnabledBorder({bool error = false}) {
    if (error) {
      return _getBorderStyle(const InputFieldState.error());
    }

    return _getBorderStyle(const InputFieldState.active());
  }

  InputBorder? getDisabledBorder({bool error = false}) {
    if (error) {
      return _getBorderStyle(const InputFieldState.error());
    }

    return _getBorderStyle(const InputFieldState.disabled());
  }

  InputBorder? getFocusedBorder({bool error = false}) {
    if (error) {
      return _getBorderStyle(const InputFieldState.error());
    }

    return _getBorderStyle(const InputFieldState.focused());
  }

  TextStyle _getTextStyle({
    InputFieldStateProperty<TextStyle>? style,
    required InputFieldState fieldState,
  }) {
    return style?.resolve(fieldState) ?? const TextStyle();
  }

  InputBorder? _getBorderStyle(InputFieldState fieldState) {
    return border?.resolve(fieldState);
  }
}

class InputFieldIconStyle {
  InputFieldIconStyle({
    InputFieldStateProperty<Color>? color,
    this.constraints,
    this.margin = EdgeInsets.zero,
  }) : _color = color;

  final InputFieldStateProperty<Color>? _color;
  final BoxConstraints? constraints;
  final EdgeInsets margin;

  Color? getColor(InputFieldState fieldState) {
    return _color?.resolve(fieldState) ?? Colors.black;
  }
}

@freezed
class InputFieldState with _$InputFieldState {
  const InputFieldState._();

  const factory InputFieldState.active() = ActiveInputState;
  const factory InputFieldState.disabled() = DisabledInputState;
  const factory InputFieldState.focused() = FocusedInputState;
  const factory InputFieldState.error() = ErrorInputState;
  const factory InputFieldState.focusedError() = FocusedErrorInputState;
}

class InputFieldStateProperty<T> {
  const InputFieldStateProperty({
    required this.active,
    this.disabled,
    this.focused,
    this.error,
    this.focusedError,
  });

  final T active;
  final T? disabled;
  final T? focused;
  final T? error;
  final T? focusedError;

  T resolve(InputFieldState fieldState) {
    return fieldState.when(
      active: () => active,
      disabled: () => disabled ?? active,
      focused: () => focused ?? active,
      error: () => error ?? active,
      focusedError: () => focusedError ?? error ?? focused ?? active,
    );
  }
}
