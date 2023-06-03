import 'package:flutter/widgets.dart';
import 'package:tfg_front/src/core/theme/custom_colors.dart';
import 'package:tfg_front/src/core/theme/custom_text_styles.dart';

extension BuildContextExtension on BuildContext {
  CustomTextStyle get style => CustomTextStyle.i;
  CustomColors get colors => CustomColors.i;
  Size get size2 => MediaQuery.sizeOf(this);
  double get height => MediaQuery.sizeOf(this).height;
  double get width => MediaQuery.sizeOf(this).width;
}
