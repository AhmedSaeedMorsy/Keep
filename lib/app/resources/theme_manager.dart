import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/app/resources/values_manager.dart';
import 'color_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';

ThemeData getAppTheme() {
  return ThemeData(
    // main color
    primarySwatch: Colors.grey,
    primaryColor: ColorManager.primaryColor,

    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primaryColor,
      shadowColor: ColorManager.lightGrey,
      elevation: AppSize.s4,
      titleTextStyle: getRegularStyle(
        fontSize: FontSizeManager.s18.sp,
        color: ColorManager.white,
      ),
    ),

    //text theme
    textTheme: TextTheme(
      displayMedium: getMediumStyle(
        color: ColorManager.primaryColor,
        fontSize: FontSizeManager.s20.sp,
      ),
      displayLarge: getRegularStyle(
        color: ColorManager.primaryColor,
        fontSize: FontSizeManager.s22.sp,
      ),
      headlineLarge: getBoldStyle(
        color: ColorManager.white,
        fontSize: FontSizeManager.s26.sp,
      ),
      headlineMedium: getSemiBoldStyle(
        color: ColorManager.primaryColor,
        fontSize: FontSizeManager.s26,
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
    ),
  );
}
