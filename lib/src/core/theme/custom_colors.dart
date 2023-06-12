import 'package:flutter/material.dart';

class CustomColors {
  CustomColors._();
  static final CustomColors _instance = CustomColors._();
  static CustomColors get i => _instance;

  /// Color(0xff6776ED)
  Color get primary => const Color(0xff6776ED);

  /// Color(0xff636185)
  Color get secondary => const Color(0xff636185);

  /// Color(0xff00CFDD)
  Color get ternary => const Color(0xff00CFDD);

  /// #8E8CAC
  Color get gray => const Color(0xff8E8CAC);

  /// #6F6E87
  Color get grayDark => const Color(0xff6F6E87);

  /// #00CFDD
  Color get greenBlue => const Color(0xff00CFDD);

  /// #35344F
  Color get backgroundPrimary => const Color(0xff35344F);

  /// back
  Color get backgroundSecondary => const Color(0xff000000);

  /// #6776ED
  Color get blue => const Color(0xff6776ED);

  /// #34C38F
  Color get green => const Color(0xff34C38F);

  /// #738ADB
  Color get backgroundTitle => const Color(0xff738ADB);

  /// #1C1C27
  Color get navBar => const Color(0xff1C1C27);

  // #FF3B3B
  Color get error => const Color(0xffFF3B3B);

  // #403F56
  Color get darkBackground => const Color(0xff403F56);

  //#828BB4
  Color get inputAlertModal => const Color(0xff828BB4);
}
