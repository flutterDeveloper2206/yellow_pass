
import 'package:flutter/material.dart';
import 'package:yellow_pass/core/utils/color_constant.dart';
import 'package:yellow_pass/core/utils/size_utils.dart';

abstract class PMT {
  /// Default font family
  static const String defaultFontOfApp = 'Inter';
  static const String _defaultFontFamily = defaultFontOfApp;
  static const FontWeight _defaultFontWeight = FontWeight.w400;
  //static var defaultFontColor = LmgColors().fontBlack;

  static TextStyle style(int size, {Color? fontColor, String? fontFamily, FontWeight? fontWeight}) {
    final defaultFontColor = ColorConstant.textDarkBrown;
    switch (size) {
      case 10:
        return TextStyle(
            fontFamily: fontFamily ?? _defaultFontFamily,
            fontSize: getFontSize(7),
            fontWeight: fontWeight??_defaultFontWeight,
            color: fontColor ?? defaultFontColor);

      case 12:
        return TextStyle(
            fontFamily: fontFamily ?? _defaultFontFamily,
            fontSize: getFontSize(9), //7.5.sp
            fontWeight: fontWeight??_defaultFontWeight,
            color: fontColor ?? defaultFontColor);

      case 14:
        return TextStyle(
            fontFamily: fontFamily ?? _defaultFontFamily,
            fontSize: getFontSize(14), //7.5.sp
            fontWeight: fontWeight??_defaultFontWeight,
            color: fontColor ?? defaultFontColor);

      case 18:
        return TextStyle(
            fontFamily: fontFamily ?? _defaultFontFamily,
            fontSize: getFontSize(18), //7.5.sp
            fontWeight: fontWeight??_defaultFontWeight,
            color: fontColor ?? defaultFontColor);
      case 24:
        return TextStyle(
            fontFamily: fontFamily ?? _defaultFontFamily,
            fontSize: getFontSize(24), //7.5.sp
            fontWeight: fontWeight??_defaultFontWeight,
            color: fontColor ?? defaultFontColor);

      case 28:
        return TextStyle(
            fontFamily: fontFamily ?? _defaultFontFamily,
            fontSize: getFontSize(28), //7.5.sp
            fontWeight: fontWeight??_defaultFontWeight,
            color: fontColor ?? defaultFontColor);

      case 36:
        return TextStyle(
            fontFamily: fontFamily ?? _defaultFontFamily,
            fontSize: getFontSize(36), //8.sp,
            fontWeight: fontWeight??_defaultFontWeight,
            color: fontColor ?? defaultFontColor);

      default:
        return TextStyle(
            fontFamily: fontFamily ?? _defaultFontFamily,
            fontSize: getFontSize(10.5), //12,
            fontWeight: fontWeight??_defaultFontWeight,
            color: fontColor ?? defaultFontColor);
    }
  }
}