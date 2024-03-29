import 'package:flutter/material.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
    fontFamily: FontConstance.fontFamily,
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
  );
}

// bold weight
TextStyle getBoldStyle({
  required double fontSize,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontWeightManager.bold,
    color,
  );
}

// light weight
TextStyle getLightStyle({
  required double fontSize,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontWeightManager.light,
    color,
  );
}

// medium weight
TextStyle getMediumStyle({
  required double fontSize,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontWeightManager.medium,
    color,
  );
}

// regular weight
TextStyle getRegularStyle({
  required double fontSize,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontWeightManager.regular,
    color,
  );
}

// extraBold weight
TextStyle getExtraBoldStyle({
  required double fontSize,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontWeightManager.extraBold,
    color,
  );
}

// semiBold weight
TextStyle getSemiBoldStyle({
  required double fontSize,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontWeightManager.semiBold,
    color,
  );
}
