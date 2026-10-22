import 'package:flutter/material.dart';

class AppTextStyles {
  AppTextStyles._();

  static const String _headingFont = 'Sansation';
  static const String _headingFontBold = 'Sansation_bold';
  static const String _bodyFont = 'Inter';

  static TextStyle heading = TextStyle(
    fontFamily: _headingFont,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: Colors.black,
    height: 1.3,
  );


  static TextStyle headingBold = TextStyle(
    fontFamily: _headingFontBold,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: Colors.black,
    height: 1.3,
  );

  static TextStyle title = TextStyle(fontFamily: _headingFont, fontSize: 17, fontWeight: FontWeight.w600, color: Colors.black);

  static TextStyle body = TextStyle(
    fontFamily: _bodyFont,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.black,
    height: 1.4,
  );

  static TextStyle bodyMuted = TextStyle(
    fontFamily: _bodyFont,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.black,
    height: 1.4,
  );

  static TextStyle label = TextStyle(fontFamily: _bodyFont, fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black);

  static TextStyle caption = TextStyle(fontFamily: _bodyFont, fontSize: 11, fontWeight: FontWeight.w400, color: Colors.black);

  static TextStyle button = TextStyle(fontFamily: _bodyFont, fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black);

  static TextStyle link = TextStyle(fontFamily: _bodyFont, fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black);
}
