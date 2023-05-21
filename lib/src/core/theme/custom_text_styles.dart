import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextStyle {
  CustomTextStyle._();
  static final CustomTextStyle _instance = CustomTextStyle._();
  static CustomTextStyle get i => _instance;

  TextStyle get robotoLight => GoogleFonts.roboto(fontWeight: FontWeight.w300);
  TextStyle get robotoRegular => GoogleFonts.roboto(fontWeight: FontWeight.w400);
  TextStyle get robotoItalic => GoogleFonts.roboto(fontStyle: FontStyle.italic);
  TextStyle get robotoMedium => GoogleFonts.roboto(fontWeight: FontWeight.w500);
  TextStyle get robotoBold => GoogleFonts.roboto(fontWeight: FontWeight.w700);
  TextStyle get robotoBlack => GoogleFonts.roboto(fontWeight: FontWeight.w900);

  TextStyle get interLight => GoogleFonts.inter(fontWeight: FontWeight.w300);
  TextStyle get interRegular => GoogleFonts.inter(fontWeight: FontWeight.w400);
  TextStyle get interMedium => GoogleFonts.inter(fontWeight: FontWeight.w500);
  TextStyle get interSemiBold => GoogleFonts.inter(fontWeight: FontWeight.w600);
  TextStyle get interBold => GoogleFonts.inter(fontWeight: FontWeight.w700);
  TextStyle get interBlack => GoogleFonts.inter(fontWeight: FontWeight.w900);

  //? Google Fonts Custom
  TextStyle get button => interBold.copyWith(
        fontSize: 12,
        color: Colors.white,
        letterSpacing: 2,
      );
}

/*
  FontWeight.w100: 'Thin',
  FontWeight.w200: 'ExtraLight',
  FontWeight.w300: 'Light',
  FontWeight.w400: 'Regular',
  FontWeight.w500: 'Medium',
  FontWeight.w600: 'SemiBold',
  FontWeight.w700: 'Bold',
  FontWeight.w800: 'ExtraBold',
  FontWeight.w900: 'Black',
*/
