import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'color_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';

ThemeData getAppTheme() {
  return ThemeData(
    // main color

    timePickerTheme: TimePickerThemeData(
      dialHandColor: ColorManager.grey,
      backgroundColor: ColorManager.white,
      dialBackgroundColor: ColorManager.white,
      hourMinuteColor: ColorManager.grey,
      hourMinuteTextColor: ColorManager.primaryColor,
      dayPeriodTextColor: ColorManager.darkGrey,
      helpTextStyle: getSemiBoldStyle(
        fontSize: FontSizeManager.s22.sp,
        color: ColorManager.darkGrey,
      ),
      dayPeriodBorderSide: BorderSide.none,
      dayPeriodTextStyle: getSemiBoldStyle(
        fontSize: FontSizeManager.s18.sp,
        color: ColorManager.darkGrey,
      ),
    ),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: ColorManager.primaryColor,
      ),
    ),
    // primarySwatch: MaterialColor(),
    primaryColor: ColorManager.primaryColor,
    primarySwatch: Colors.grey,
    //text theme

    textTheme: TextTheme(
        displayMedium: getMediumStyle(
          color: ColorManager.primaryColor,
          fontSize: FontSizeManager.s18.sp,
        ),
        displayLarge: getRegularStyle(
          color: ColorManager.primaryColor,
          fontSize: FontSizeManager.s22.sp,
        ),
        headlineLarge: getBoldStyle(
          color: ColorManager.white,
          fontSize: FontSizeManager.s22.sp,
        ),
        headlineMedium: getSemiBoldStyle(
          color: ColorManager.primaryColor,
          fontSize: FontSizeManager.s24.sp,
        ),
        displaySmall: getLightStyle(
          color: ColorManager.white,
          fontSize: FontSizeManager.s18.sp,
        ),
        bodySmall: getRegularStyle(
          color: ColorManager.primaryColor,
          fontSize: FontSizeManager.s10.sp,
        ),
        headlineSmall: getMediumStyle(
          fontSize: FontSizeManager.s18.sp,
          color: ColorManager.darkGrey,
        ),
        bodyLarge: getExtraBoldStyle(
          fontSize: FontSizeManager.s22.sp,
          color: ColorManager.white,
        )),
  );
}
