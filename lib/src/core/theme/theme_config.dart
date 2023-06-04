import 'package:flutter/material.dart';

import 'package:tfg_front/src/core/theme/custom_colors.dart';
import 'package:tfg_front/src/core/theme/custom_text_styles.dart';

class ThemeConfig {
  ThemeConfig._();

  static const border = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(4),
    ),
    borderSide: BorderSide(color: Colors.transparent, width: 0),
  );

  static final defaultTheme = ThemeData(
    useMaterial3: true,
    primaryColor: CustomColors.i.primary,
    scaffoldBackgroundColor: CustomColors.i.backgroundPrimary,
    appBarTheme: AppBarTheme(
      backgroundColor: CustomColors.i.backgroundSecondary,
      foregroundColor: Colors.white,
      centerTitle: true,
    ),
    colorScheme: ColorScheme.fromSwatch(
      accentColor: CustomColors.i.primary,
      backgroundColor: CustomColors.i.backgroundPrimary,
      brightness: Brightness.dark,
    ),
    inputDecorationTheme: InputDecorationTheme(
      isDense: false,
      border: border,
      focusedBorder: border.copyWith(
        borderSide: const BorderSide(color: Colors.white, width: 2),
      ),
      enabledBorder: border,
      errorBorder: border,
      focusedErrorBorder: border,
      disabledBorder: border,
      errorStyle: CustomTextStyle.i.poppinsItalic.copyWith(color: Colors.red, fontSize: 14),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    ),
    dividerColor: Colors.black,
    dividerTheme: const DividerThemeData(
      color: Colors.black,
    ),
  );
}
