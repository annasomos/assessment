import 'package:users_app/models/field/field_type.dart';
import 'package:users_app/presentation/theme/scale.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:users_app/presentation/widgets/input_field/input_field_theme.dart';

final screenInset = EdgeInsets.all(16.hs);
const entryDuration = Duration(milliseconds: 300);
const entryDelay = Duration(milliseconds: 300);

class AppTheme extends InheritedWidget {
  const AppTheme({
    Key? key,
    required Widget child,
    required this.brightness,
  }) : super(key: key, child: child);
  final Brightness brightness;

  @override
  bool updateShouldNotify(AppTheme oldWidget) => oldWidget.isDark != isDark;

  static AppTheme of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<AppTheme>()!;

  bool get isDark => brightness == Brightness.dark;

  static const white = Color(0xFFFFFFFF);
  static const dark = Color(0xFF222831);

  static const yellow = Color(0xFFFFD059);
  static const purple = Color(0xFF704cff);
  static const lightPurple = Color(0xFFe7e0ff);

  static const greenLight = Color(0xFF00E9E9);
  static const greenDark = Color(0xFF009999);

  static const redLight = Color.fromARGB(255, 253, 53, 77);
  static const redDark = Color(0xFFDC0018);

  static const blueLight = Color.fromARGB(255, 128, 190, 252);
  static const blueDark = Color(0xFF00679A);

  static const grayDark = Color(0xFFBCBCBC);
  static const grayLight = Color(0xFFDADADA);

  static const backgroundLight = Color(0xFFFAFAFA);
  static const backgroundDark = Color(0xFF393E46);

  TextStyle get h1 => GoogleFonts.roboto(fontSize: 96.hs, height: 1.1, fontWeight: FontWeight.w100);
  TextStyle get h2 => GoogleFonts.roboto(fontSize: 60.hs, height: 1.2, fontWeight: FontWeight.w100);
  TextStyle get h3 => GoogleFonts.roboto(fontSize: 36.hs, height: 1.1, fontWeight: FontWeight.w100);
  TextStyle get h4 => GoogleFonts.roboto(fontSize: 30.hs, height: 1.2, fontWeight: FontWeight.w500);
  TextStyle get h5 => GoogleFonts.roboto(fontSize: 24.hs, height: 1.3, fontWeight: FontWeight.w500);
  TextStyle get h6 => GoogleFonts.roboto(fontSize: 20.hs, height: 1.3, fontWeight: FontWeight.w500);
  TextStyle get subtitle1 => GoogleFonts.roboto(fontSize: 12.hs, height: 1.4, fontWeight: FontWeight.w500);
  TextStyle get subtitle2 => GoogleFonts.roboto(fontSize: 12.hs, height: 1.4, fontWeight: FontWeight.w300);
  TextStyle get bodyText1 => GoogleFonts.roboto(fontSize: 16.hs, height: 1.4, fontWeight: FontWeight.normal);
  TextStyle get bodyText2 => GoogleFonts.roboto(fontSize: 12.hs, height: 1.4, fontWeight: FontWeight.normal);
  TextStyle get button => GoogleFonts.roboto(fontSize: 14.hs, height: 1.35, fontWeight: FontWeight.w500);
  TextStyle get caption => GoogleFonts.roboto(fontSize: 12.hs, height: 1.45, fontWeight: FontWeight.normal);
  TextStyle get overline => GoogleFonts.roboto(fontSize: 12.hs, height: 1.45, fontWeight: FontWeight.w500);

  Color get primary => isDark ? blueLight : blueDark;
  Color get onPrimary => white;

  Color get surface => isDark ? dark : white;
  Color get onSurface => isDark ? white : dark;

  Color get background => isDark ? backgroundDark : backgroundLight;
  Color get onBackground => isDark ? white : dark;

  Color get error => isDark ? redLight : redDark;
  Color get success => isDark ? greenLight : greenDark;
  Color get link => isDark ? blueLight : blueDark;

  Color get disabledColor => isDark ? grayDark : grayLight;
  Color get iconColor => isDark ? white : dark;

  Color get backdrop {
    final opacity = isDark ? 0.7 : 0.4;
    return Colors.black.withOpacity(opacity);
  }

  ThemeData get theme => ThemeData(
        canvasColor: background,
        primaryColor: primary,
        appBarTheme: AppBarTheme(
          color: background,
          foregroundColor: onSurface,
        ),
        iconTheme: IconThemeData(
          color: iconColor,
        ),
        chipTheme: ChipThemeData(
          labelStyle: subtitle1,
          backgroundColor: primary,
        ),
        listTileTheme: ListTileThemeData(
          iconColor: iconColor,
          textColor: onBackground,
        ),
        textButtonTheme: textButtonThemeData,
        outlinedButtonTheme: outlinedButtonThemeData,
        elevatedButtonTheme: elevatedButtonThemeData,
        scaffoldBackgroundColor: background,
        colorScheme: ColorScheme.light(primary: primary).copyWith(background: background),
      );

  TextButtonThemeData get textButtonThemeData => TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          elevation: 0,
          enableFeedback: false,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.hs)),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: largeButtonPadding,
        ).copyWith(
          textStyle: buttonTextStyle,
          foregroundColor: createMaterialStateProperty(
            active: primary,
            disabled: disabledColor,
          ),
        ),
      );

  OutlinedButtonThemeData get outlinedButtonThemeData => OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,
          elevation: 0,
          padding: largeButtonPadding,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.hs)),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ).copyWith(
          textStyle: buttonTextStyle,
          side: createMaterialStateProperty(
            active: BorderSide(color: primary),
            disabled: BorderSide(color: disabledColor),
          ),
          foregroundColor: createMaterialStateProperty(
            active: primary,
            disabled: disabledColor,
          ),
        ),
      );

  ElevatedButtonThemeData get elevatedButtonThemeData => ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.hs)),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: smallButtonPadding,
        ).copyWith(
          textStyle: buttonTextStyle,
          elevation: MaterialStateProperty.all<double>(0),
          backgroundColor: createMaterialStateProperty(
            active: primary,
            disabled: disabledColor.withOpacity(0.4),
          ),
          foregroundColor: createMaterialStateProperty(
            active: onPrimary,
            disabled: onPrimary,
          ),
        ),
      );

  MaterialStateProperty<TextStyle> get buttonTextStyle =>
      MaterialStateProperty.all<TextStyle>(button.copyWith(height: 1));

  EdgeInsets get largeButtonPadding => EdgeInsets.symmetric(
        horizontal: 20.hs,
        vertical: 16.hs,
      );

  EdgeInsets get smallButtonPadding => EdgeInsets.symmetric(
        horizontal: 12.hs,
        vertical: 10.hs,
      );

  InputFieldTheme getInputFieldTheme(FieldType fieldType) {
    final selectFieldInsets = EdgeInsets.only(top: 12.hs, left: 15.hs);

    return InputFieldTheme(
      textStyle: InputFieldStateProperty(
        active: bodyText2.copyWith(color: onBackground),
        disabled: bodyText2.copyWith(color: disabledColor),
      ),
      labelStyle: InputFieldStateProperty(
        active: TextStyle(color: onBackground),
        focused: TextStyle(color: primary),
        disabled: TextStyle(color: disabledColor),
        error: TextStyle(color: error),
      ),
      border: InputFieldStateProperty(
        active: createInputBorder(color: onBackground),
        focused: createInputBorder(color: primary),
        disabled: createInputBorder(color: disabledColor),
        error: createInputBorder(color: error),
      ),
      suffixIconStyle: InputFieldIconStyle(
        constraints: BoxConstraints.loose(Size(50.hs, 50.hs)),
        color: InputFieldStateProperty(
          active: onBackground,
          disabled: disabledColor,
        ),
        margin: fieldType.maybeWhen(
          select: () => selectFieldInsets,
          multiSelect: () => selectFieldInsets,
          date: () => EdgeInsets.all(10.hs),
          orElse: () => EdgeInsets.zero,
        ),
      ),
    );
  }
}

UnderlineInputBorder createInputBorder({
  required Color color,
  double width = 1.0,
}) {
  return UnderlineInputBorder(
    borderSide: BorderSide(
      width: width,
      color: color,
    ),
  );
}

MaterialStateProperty<T> createMaterialStateProperty<T>({
  required T active,
  T? disabled,
  T? pressed,
}) {
  return MaterialStateProperty.resolveWith<T>(
    (states) {
      if (states.contains(MaterialState.disabled) && disabled != null) {
        return disabled;
      }

      if (states.contains(MaterialState.pressed) && pressed != null) {
        return pressed;
      }

      return active;
    },
  );
}

Color createColorFromHex(String hexColor) {
  final colorCode = hexColor.toUpperCase().replaceAll("#", "");
  return Color(int.parse('FF$colorCode', radix: 16));
}

extension BuildContextX on BuildContext {
  AppTheme get appTheme => AppTheme.of(this);
}