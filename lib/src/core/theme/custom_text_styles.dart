import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextStyle {
  CustomTextStyle._();
  static final CustomTextStyle _instance = CustomTextStyle._();
  static CustomTextStyle get i => _instance;

  TextStyle get interLight => GoogleFonts.inter(fontWeight: FontWeight.w300);
  TextStyle get interRegular => GoogleFonts.inter(fontWeight: FontWeight.w400);
  TextStyle get interMedium => GoogleFonts.inter(fontWeight: FontWeight.w500);
  TextStyle get interSemiBold => GoogleFonts.inter(fontWeight: FontWeight.w600);
  TextStyle get interBold => GoogleFonts.inter(fontWeight: FontWeight.w700);
  TextStyle get interBlack => GoogleFonts.inter(fontWeight: FontWeight.w900);

  TextStyle get poppinsLight =>
      GoogleFonts.poppins(fontWeight: FontWeight.w300);
  TextStyle get poppinsRegular =>
      GoogleFonts.poppins(fontWeight: FontWeight.w400);
  TextStyle get poppinsMedium =>
      GoogleFonts.poppins(fontWeight: FontWeight.w500);
  TextStyle get poppinsSemiBold =>
      GoogleFonts.poppins(fontWeight: FontWeight.w600);
  TextStyle get poppinsBold => GoogleFonts.poppins(fontWeight: FontWeight.w700);
  TextStyle get poppinsBlack =>
      GoogleFonts.poppins(fontWeight: FontWeight.w900);
  TextStyle get poppinsItalic =>
      GoogleFonts.poppins(fontStyle: FontStyle.italic);

  //? Google Fonts Custom
  TextStyle get button => poppinsBold.copyWith(
        fontSize: 16,
        color: Colors.white,
        letterSpacing: 1,
      );

  TextStyle get buttonAction => poppinsBold.copyWith(
        fontSize: 14,
        color: Colors.white,
        letterSpacing: 1,
      );

  TextStyle get crudTitle => poppinsBold.copyWith(
        fontSize: 18,
        color: Colors.white,
        letterSpacing: 1,
      );

  TextStyle get title => poppinsBold.copyWith(
        fontSize: 16,
        color: Colors.white,
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
