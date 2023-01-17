import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/app/resources/assets_manager.dart';
import 'package:keep/app/resources/font_manager.dart';
import 'package:keep/presentation/layout/controller/layout_bloc.dart';
import 'package:keep/presentation/layout/controller/layout_states.dart';
import 'package:keep/presentation/layout/view/layout_screen.dart';
import 'package:keep/presentation/notification/view/notification_view.dart';
import '../resources/color_manager.dart';
import '../resources/language_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';

class SharedWidget {
  static Widget defaultTextFormField({
    final TextEditingController? controller,
    required TextInputType textInputType,
    bool obscure = false,
    void Function(String?)? onChange,
    void Function()? onTap,
    String? hint,
    bool? enabled,
    String? Function(String?)? validator,
    IconButton? suffixIcon,
    void Function(String)? onFieldSubmitted,
    int maxLines = 1,
    int minLines = 1,
  }) =>
      SizedBox(
        height: AppSize.s50.h,
        child: TextFormField(
          controller: controller,
          cursorColor: ColorManager.primaryColor,
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: hint,
            fillColor: ColorManager.lightGrey, filled: true,
            suffixIcon: suffixIcon,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSize.s50.h),
              borderSide: const BorderSide(
                color: ColorManager.primaryColor,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSize.s50.h),
              borderSide: const BorderSide(
                color: ColorManager.primaryColor,
              ),
            ),
            contentPadding:
                EdgeInsets.only(top: AppPadding.p1.h, left: AppPadding.p16.w),
            // hint style
            hintStyle: getBoldStyle(
              color: ColorManager.grey,
              fontSize: FontSizeManager.s22.sp,
            ),
          ),
          onFieldSubmitted: onFieldSubmitted,
          onChanged: onChange,
          onTap: onTap,
          enabled: enabled,
          minLines: minLines,
          validator: validator,
          keyboardType: textInputType,
          maxLines: maxLines,
        ),
      );

  static Widget header(context) => BlocProvider(
      create: (context) => LayoutBloc(),
      child: BlocBuilder<LayoutBloc, LayoutStates>(
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / AppSize.s20,
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    profile(context);
                  },
                  child: CircleAvatar(
                    radius: AppSize.s30.w,
                    backgroundColor: ColorManager.white,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / AppSize.s30.w,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical:
                          MediaQuery.of(context).size.height / AppSize.s120,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppStrings.userName.tr(),
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width /
                                        AppSize.s30,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, Routes.layoutRoute);
                                      screen = const NotificationScreen();
                                      LayoutBloc.get(context)
                                          .changeBottomNavBar(5);
                                    },
                                    child: Icon(
                                      Icons.notifications,
                                      size: AppSize.s18.w,
                                      color: ColorManager.white,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width /
                                        AppSize.s30,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      showPopupSettings(context);
                                    },
                                    child: Icon(
                                      Icons.settings,
                                      size: AppSize.s18.w,
                                      color: ColorManager.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          AppStrings.jobDescription.tr(),
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ));

  static Widget addTaskFormField({
    final TextEditingController? controller,
    required TextInputType textInputType,
    void Function(String?)? onChange,
    void Function()? onTap,
    String? hint,
    String? Function(String?)? validator,
    void Function(String)? onFieldSubmitted,
    int maxLines = 1,
    int minLines = 1,
  }) =>
      SizedBox(
        height: AppSize.s50.h,
        child: TextFormField(
          controller: controller,
          cursorHeight: 5,
          cursorColor: ColorManager.primaryColor,
          decoration: InputDecoration(
            hintText: hint,
            fillColor: ColorManager.lightGrey, filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppSize.s16,
              ),
              borderSide: const BorderSide(
                color: ColorManager.primaryColor,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppSize.s16,
              ),
              borderSide: const BorderSide(
                color: ColorManager.primaryColor,
              ),
            ),
            contentPadding: EdgeInsetsDirectional.only(
              top: AppPadding.p1.h,
              start: AppPadding.p12.w,
            ),
            // hint style
            hintStyle: getMediumStyle(
              color: ColorManager.grey,
              fontSize: FontSizeManager.s18.sp,
            ),
          ),
          onTap: onTap,
          onFieldSubmitted: onFieldSubmitted,
          minLines: minLines,
          validator: validator,
          keyboardType: textInputType,
          maxLines: maxLines,
        ),
      );

  static Widget addReasonFormField({
    final TextEditingController? controller,
    String? Function(String?)? validator,
    void Function(String)? onFieldSubmitted,
  }) =>
      SizedBox(
        height: AppSize.s150.h,
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: AppStrings.reasonOfcancellation.tr(),
            fillColor: Colors.white, filled: true,

            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: ColorManager.grey,
              ),
            ),
            contentPadding: EdgeInsetsDirectional.all(AppPadding.p12.w),
            // hint style
            hintStyle: getMediumStyle(
              color: ColorManager.grey,
              fontSize: FontSizeManager.s18.sp,
            ),
          ),
          onFieldSubmitted: onFieldSubmitted,
          minLines: 50,
          validator: validator,
          keyboardType: TextInputType.text,
          maxLines: 50,
        ),
      );

  static void showPopupFilter(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FadeInDown(
          child: Column(
            children: [
              Container(
                height: AppSize.s250.h,
                color: ColorManager.grey,
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width / AppSize.s18,
                          vertical:
                              MediaQuery.of(context).size.height / AppSize.s50,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.calendarHourlyRoute,
                            );
                          },
                          child: Text(
                            AppStrings.hourly.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  fontSize: FontSizeManager.s22.sp,
                                ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: ColorManager.darkGrey,
                      width: double.infinity,
                      height: AppSize.s1.h,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width / AppSize.s18,
                          vertical:
                              MediaQuery.of(context).size.height / AppSize.s50,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.calendarDailyRoute,
                            );
                          },
                          child: Text(
                            AppStrings.daily.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  fontSize: FontSizeManager.s22.sp,
                                ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: ColorManager.darkGrey,
                      width: double.infinity,
                      height: AppSize.s1.h,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width / AppSize.s18,
                          vertical:
                              MediaQuery.of(context).size.height / AppSize.s50,
                        ),
                        child: GestureDetector(
                          onTap: () {},
                          child: Text(
                            AppStrings.weekly.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  fontSize: FontSizeManager.s22.sp,
                                ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: ColorManager.darkGrey,
                      width: double.infinity,
                      height: AppSize.s1.h,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width / AppSize.s18,
                          vertical:
                              MediaQuery.of(context).size.height / AppSize.s50,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.calendarMonthlyRoute,
                            );
                          },
                          child: Text(
                            AppStrings.monthly.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  fontSize: FontSizeManager.s22.sp,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  static void profile(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FadeInRight(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / AppSize.s1_3,
                color: ColorManager.white,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / AppSize.s3,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Align(
                              alignment: AlignmentDirectional.topCenter,
                              child: Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height /
                                        AppSize.s4_3,
                                    color: ColorManager.primaryColor,
                                  ),
                                ],
                              ),
                            ),
                            Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                CircleAvatar(
                                  radius: MediaQuery.of(context).size.height /
                                      AppSize.s10,
                                  backgroundColor: ColorManager.grey,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s80,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width / AppSize.s12,
                        ),
                        child: Container(
                          height: AppSize.s150.h,
                          decoration: const BoxDecoration(
                            color: ColorManager.grey,
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                AppSize.s16,
                              ),
                            ),
                          ),
                          child: Column(children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        AppStrings.editCard.tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge!
                                            .copyWith(
                                              color: ColorManager.primaryColor,
                                              fontSize: FontSizeManager.s18.sp,
                                            ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: double.infinity,
                                    width: AppSize.s1.h,
                                    color: ColorManager.darkGrey,
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        AppStrings.editCard.tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge!
                                            .copyWith(
                                              fontSize: FontSizeManager.s18.sp,
                                              color: ColorManager.primaryColor,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: AppSize.s1.w,
                              color: ColorManager.darkGrey,
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  AppStrings.addLinksandContactInfo.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                        color: ColorManager.primaryColor,
                                      ),
                                ),
                              ),
                            )
                          ]),
                        ),
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s50,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width / AppSize.s18,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                height: AppSize.s1.w,
                                color: ColorManager.darkGrey,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width /
                                            AppSize.s80),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image(
                                      image: const AssetImage(
                                        AssetsManager.facebook,
                                      ),
                                      width: AppSize.s32.w,
                                      height: AppSize.s32.h,
                                    ),
                                    Image(
                                      image: const AssetImage(
                                        AssetsManager.instagram,
                                      ),
                                      width: AppSize.s32.w,
                                      height: AppSize.s32.h,
                                    ),
                                    Image(
                                      image: const AssetImage(
                                        AssetsManager.linkedin,
                                      ),
                                      width: AppSize.s32.w,
                                      height: AppSize.s32.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                height: AppSize.s1.w,
                                color: ColorManager.darkGrey,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width / AppSize.s18,
                          vertical:
                              MediaQuery.of(context).size.height / AppSize.s30,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  showPopupScannerProfile(context);
                                },
                                child: Image(
                                  image: const AssetImage(
                                    AssetsManager.scanner,
                                  ),
                                  color: ColorManager.primaryColor,
                                  width: AppSize.s36.w,
                                  height: AppSize.s36.h,
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.pushNamed(
                                    context,
                                    Routes.mapRoute,
                                  );
                                },
                                child: Image(
                                  image: const AssetImage(
                                    AssetsManager.mapIcon,
                                  ),
                                  color: ColorManager.primaryColor,
                                  width: AppSize.s36.w,
                                  height: AppSize.s36.h,
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  showPopupShare(context);
                                },
                                child: Image(
                                  image: const AssetImage(
                                    AssetsManager.share,
                                  ),
                                  color: ColorManager.primaryColor,
                                  width: AppSize.s36.w,
                                  height: AppSize.s36.h,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  static void showPopupScannerProfile(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FadeInDown(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: AppSize.s220.h,
                color: ColorManager.grey,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / AppSize.s22,
                  ),
                  child: const Image(
                    image: AssetImage(
                      AssetsManager.qrCode,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  // static Widget noItemWidget(context) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       SvgPicture.asset(AssetsManager.empty,),
  //       const SizedBox(
  //         height: AppSize.s30,
  //       ),
  //       Text(
  //         AppStrings.cartEmpty,
  //         style: Theme.of(context).textTheme.bodyLarge,
  //       ),
  //       const SizedBox(
  //         height: AppSize.s20,
  //       ),
  //       Text(
  //         AppStrings.emptyBio,
  //         style: Theme.of(context).textTheme.displayLarge,
  //       ),
  //     ],
  //   );
  // }

  // static toast({required String message,required Color backgroundColor}) {
  //   return Fluttertoast.showToast(
  //     msg: message,
  //     toastLength: Toast.LENGTH_SHORT,
  //     gravity: ToastGravity.BOTTOM,
  //     backgroundColor: backgroundColor,
  //     textColor: ColorManager.white,
  //     fontSize: FontSizeManager.s16.sp,
  //   );
  // }

  static void showPopupShare(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider(
            create: (context) => LayoutBloc(),
            child: BlocBuilder<LayoutBloc, LayoutStates>(
              builder: (context, state) {
                return FadeInRight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: AppSize.s120.h,
                        color: ColorManager.grey,
                        child: Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width /
                                          AppSize.s18,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pushNamed(
                                        context, Routes.shareRoute);
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        AssetsManager.people,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                AppSize.s50,
                                      ),
                                      Text(
                                        AppStrings.shareToStaff.tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium!
                                            .copyWith(
                                              fontSize: FontSizeManager.s22.sp,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              color: ColorManager.darkGrey,
                              width: double.infinity,
                              height: AppSize.s1.h,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width /
                                          AppSize.s18,
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      AssetsManager.share,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          AppSize.s50,
                                    ),
                                    Text(
                                      AppStrings.shareVia.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!
                                          .copyWith(
                                            fontSize: FontSizeManager.s22.sp,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ));
      },
    );
  }

  static void showPopupSettings(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FadeInRight(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: AppSize.s120.h,
                color: ColorManager.grey,
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width / AppSize.s18,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            changeLanguage(context);
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                AssetsManager.language,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width /
                                    AppSize.s50,
                              ),
                              Text(
                                AppStrings.language.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                      fontSize: FontSizeManager.s22.sp,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: ColorManager.darkGrey,
                      width: double.infinity,
                      height: AppSize.s1.h,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width / AppSize.s18,
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              AssetsManager.logOut,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width /
                                  AppSize.s50,
                            ),
                            Text(
                              AppStrings.logOut.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    fontSize: FontSizeManager.s22.sp,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  static void changeLanguage(context) {
    changeAppLanguage();
    Phoenix.rebirth(context);
  }

  static Widget defaultButton({
    required BuildContext context,
    required Function() function,
    required String text,
    required Color backgroundColor,
    required TextStyle style,
  }) {
    return Container(
      height: AppSize.s42.h,
      width: double.infinity,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorManager.primaryColor,
        ),
        color: backgroundColor,
        borderRadius: BorderRadius.circular(
          AppSize.s50.h,
        ),
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text,
          style: style,
        ),
      ),
    );
  }

  // static Widget dropDown({
  //   required String hintText,
  //   required List<String> list,
  //   void Function(String?)? onChanged,
  //   final FormFieldSetter? onSaved,
  //   final String? validateText,
  //   String? Function(String?)? validator,
  // }) =>
  //     DropdownButtonFormField2(
  //       isExpanded: true,
  //       decoration: InputDecoration(
  //         contentPadding: EdgeInsets.symmetric(
  //           vertical: AppSize.s10.h,
  //           horizontal: AppSize.s10.w,
  //         ),
  //         fillColor: ColorManager.white,
  //         filled: true,
  //         border: OutlineInputBorder(
  //           borderRadius: BorderRadius.all(
  //             Radius.circular(
  //               AppSize.s100.h,
  //             ),
  //           ),
  //         ),
  //       ),
  //       hint: Text(
  //         hintText,
  //         style: TextStyle(
  //           fontSize: FontSizeManager.s16.sp,
  //           color: ColorManager.grey,
  //         ),
  //       ),
  //       icon: const Icon(
  //         Icons.arrow_drop_down,
  //         color: ColorManager.black,
  //       ),
  //       iconSize: AppSize.s20.w,
  //       buttonHeight: AppSize.s30.w,
  //       items: list
  //           .map(
  //             (item) => DropdownMenuItem<String>(
  //               value: item,
  //               child: Text(
  //                 item,
  //                 style: TextStyle(
  //                   fontSize: FontSizeManager.s12.sp,
  //                   color: ColorManager.black,
  //                 ),
  //               ),
  //             ),
  //           )
  //           .toList(),
  //       onChanged: onChanged,
  //       onSaved: onSaved,
  //       validator: validator,
  //     );

//   static Widget searchItem({
//     required TextEditingController controller,
//     required BuildContext context,
//     required TextInputType textInputType,
//     bool obscure = false,
//     void Function(String?)? onChange,
//     void Function()? onTap,
//     String? hint,
//     bool? enabled,
//     Icon? suffixIcon,
//     void Function(String)? onFieldSubmitted,
//     int maxLines = 1,
//     int minLines = 1,
//   }) =>
//       Padding(
//           padding: EdgeInsets.symmetric(
//             vertical: MediaQuery.of(context).size.height / AppSize.s180,
//             horizontal: MediaQuery.of(context).size.width / AppSize.s50,
//           ),
//           child: Container(
//             clipBehavior: Clip.antiAlias,
//             decoration: BoxDecoration(
//               color: ColorManager.white,
//               borderRadius: BorderRadius.all(
//                 Radius.circular(
//                   AppSize.s100.h,
//                 ),
//               ),
//               border: Border.all(
//                 color: ColorManager.grey,
//               ),
//             ),
//             width: double.infinity,
//             height: AppSize.s40.h,
//             child: TextFormField(
//               cursorColor: ColorManager.primaryColor,
//               obscureText: obscure,
//               decoration: InputDecoration(
//                 hintText: hint,
//                 suffixIcon: suffixIcon,
//                 border: InputBorder.none,

//                 contentPadding: EdgeInsets.symmetric(
//                     vertical: AppSize.s10.h, horizontal: AppSize.s10.w),
//                 // hint style
//                 hintStyle: getRegularStyle(
//                   color: ColorManager.grey,
//                 ),
//               ),
//               onFieldSubmitted: onFieldSubmitted,
//               onChanged: onChange,
//               onTap: onTap,
//               enabled: enabled,
//               minLines: minLines,
//               controller: controller,
//               keyboardType: textInputType,
//               maxLines: maxLines,
//             ),
//           ));
// }

  // number of notification
  // Container(
  //   padding: EdgeInsets.all(
  //     MediaQuery.of(context).size.width /
  //         AppSize.s100,
  //   ),
  //   clipBehavior: Clip.antiAliasWithSaveLayer,
  //   decoration: BoxDecoration(
  //     color: ColorManager.error,
  //     shape: BoxShape.circle,
  //   ),
  //   child: Text(
  //     AppStrings.three,
  //     style: Theme.of(context)
  //         .textTheme
  //         .bodySmall!
  //         .copyWith(
  //           fontSize: FontSizeManager.s16.sp,
  //         ),
  //   ),
  // ),
}
