// ignore_for_file: deprecated_member_use

import 'package:animate_do/animate_do.dart';
import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keep/app/constant/enums_extentions.dart';
import 'package:keep/app/resources/assets_manager.dart';
import 'package:keep/app/resources/font_manager.dart';
import 'package:keep/app/services/shared_prefrences/cache_helper.dart';
import 'package:keep/presentation/layout/controller/layout_bloc.dart';
import 'package:keep/presentation/layout/controller/layout_states.dart';
import 'package:keep/presentation/login/controller/bloc.dart';
import 'package:keep/presentation/login/controller/states.dart';
import 'package:keep/presentation/share/view/share_screen.dart';
import 'package:share_plus/share_plus.dart';
import '../../model/leads_model.dart';
import '../../presentation/edit_lead/view/edit_lead_screen.dart';
import '../../presentation/layout/view/layout_screen.dart';
import '../../presentation/notification/view/notification_view.dart';
import '../../presentation/view_lead/view/view_lead_screen.dart';
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
            contentPadding: EdgeInsetsDirectional.only(
                top: AppPadding.p12.h, start: AppPadding.p16.w),
            // hint style
            hintStyle: getBoldStyle(
              color: ColorManager.grey,
              fontSize: FontSizeManager.s14.sp,
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
          return BlocProvider(
            create: (context) => LoginCubit()
              ..getUserData(token: CacheHelper.getData(key: SharedKey.token)),
            child:
                BlocBuilder<LoginCubit, LoginStates>(builder: (context, state) {
              return ConditionalBuilderRec(
                condition: state is UserSucecessState,
                builder: (context) => Container(
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
                          backgroundColor: ColorManager.primaryColor,
                          backgroundImage: LoginCubit.get(context)
                                      .userModel
                                      .data
                                      .imageProfile !=
                                  null
                              ? NetworkImage(LoginCubit.get(context)
                                  .userModel
                                  .data
                                  .imageProfile!)
                              : null,
                        ),
                      ),
                      SizedBox(
                        width:
                            MediaQuery.of(context).size.width / AppSize.s30.w,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height /
                                AppSize.s120,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    LoginCubit.get(context)
                                        .userModel
                                        .data
                                        .name
                                        .toCapitalized(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              AppSize.s30,
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                              context,
                                              Routes.layoutRoute,
                                            );

                                            screen = const NotificationScreen();
                                            LayoutBloc.get(context)
                                                .changeBottomNavBar(5);
                                          },
                                          child: Icon(
                                            Icons.notifications,
                                            size: AppSize.s18.w,
                                            color: ColorManager.darkGrey,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              AppSize.s30,
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            showPopupSettings(context);
                                          },
                                          child: Icon(
                                            Icons.settings,
                                            size: AppSize.s18.w,
                                            color: ColorManager.darkGrey,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                LoginCubit.get(context).userModel.data.title ??
                                    "",
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }),
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
    bool enabled = true,
  }) =>
      SizedBox(
        height: AppSize.s50.h,
        child: TextFormField(
          enabled: enabled,
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
              fontSize: FontSizeManager.s14.sp,
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
        height: AppSize.s120.h,
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
              fontSize: FontSizeManager.s14.sp,
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
          duration: const Duration(milliseconds: AppIntDuration.duration500),
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
                                  fontSize: FontSizeManager.s18.sp,
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
                                  fontSize: FontSizeManager.s18.sp,
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
                              Routes.calendarWeeklyRoute,
                            );
                          },
                          child: Text(
                            AppStrings.weekly.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  fontSize: FontSizeManager.s18.sp,
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
                                  fontSize: FontSizeManager.s18.sp,
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
        return FadeInDown(
            duration: const Duration(
              milliseconds: AppIntDuration.duration500,
            ),
            child: BlocProvider(
              create: (context) => LoginCubit()
                ..getUserData(token: CacheHelper.getData(key: SharedKey.token)),
              child: BlocBuilder<LoginCubit, LoginStates>(
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / AppSize.s2,
                        color: ColorManager.white,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height /
                                    AppSize.s3,
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
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                AppSize.s4_3,
                                            color: ColorManager.primaryColor,
                                            child: LoginCubit.get(context)
                                                        .userModel
                                                        .data
                                                        .imageCover ==
                                                    null
                                                ? null
                                                : Image(
                                                    fit: BoxFit.fill,
                                                    image: NetworkImage(
                                                        LoginCubit.get(context)
                                                            .userModel
                                                            .data
                                                            .imageCover!)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Stack(
                                      alignment: AlignmentDirectional.bottomEnd,
                                      children: [
                                        CircleAvatar(
                                          radius: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              AppSize.s10,
                                          backgroundColor: ColorManager.grey,
                                          backgroundImage:
                                              LoginCubit.get(context)
                                                          .userModel
                                                          .data
                                                          .imageProfile ==
                                                      null
                                                  ? null
                                                  : NetworkImage(
                                                      LoginCubit.get(context)
                                                          .userModel
                                                          .data
                                                          .imageProfile!,
                                                    ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height /
                                    AppSize.s80,
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height /
                                    AppSize.s50,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width /
                                          AppSize.s18,
                                  vertical: MediaQuery.of(context).size.height /
                                      AppSize.s60,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          GestureDetector(
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
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                AppSize.s80,
                                          ),
                                          Text(
                                            AppStrings.qr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          GestureDetector(
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
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                AppSize.s80,
                                          ),
                                          Text(
                                            AppStrings.unAssignedLead.tr(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
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
                  );
                },
              ),
            ));
      },
    );
  }

  static void showPopupScannerProfile(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FadeInDown(
          duration: const Duration(milliseconds: AppIntDuration.duration500),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: AppSize.s220.h,
                color: ColorManager.white,
                child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical:
                          MediaQuery.of(context).size.height / AppSize.s22,
                    ),
                    child: SvgPicture.string(
                        CacheHelper.getData(key: SharedKey.qr))),
              ),
            ],
          ),
        );
      },
    );
  }

  static void showPopupShare(
      context, id, String shareType, String name, String path, String desc,
      [String? email, String? position]) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider(
            create: (context) => LayoutBloc(),
            child: BlocBuilder<LayoutBloc, LayoutStates>(
              builder: (context, state) {
                return FadeInDown(
                  duration:
                      const Duration(milliseconds: AppIntDuration.duration500),
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
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ShareScreen(
                                          id: id,
                                          shareType: shareType,
                                        ),
                                      ),
                                    );
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
                                              fontSize: FontSizeManager.s18.sp,
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
                                child: GestureDetector(
                                  onTap: () async {
                                    if (shareType != "lead") {
                                      await Share.share(
                                          "Name: $name\nDescription: $desc\n$path");
                                    } else {
                                      await Share.share(
                                          "Name: $name\nCompany Name: $desc\nPosition:$position\nEmail: $email\nPhone: $path");
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        AssetsManager.share,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                AppSize.s50,
                                      ),
                                      Text(
                                        AppStrings.shareVia.tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium!
                                            .copyWith(
                                              fontSize: FontSizeManager.s18.sp,
                                            ),
                                      ),
                                    ],
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
            ));
      },
    );
  }

  static void showPopupSettings(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FadeInDown(
          duration: const Duration(milliseconds: AppIntDuration.duration500),
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
                                      fontSize: FontSizeManager.s18.sp,
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
                        child: GestureDetector(
                          onTap: () {
                            CacheHelper.removeData(key: SharedKey.token);
                            CacheHelper.removeData(key: SharedKey.qr);
                            CacheHelper.removeData(key: SharedKey.id);
                            CacheHelper.removeData(key: SharedKey.loginDate);
                            CacheHelper.removeData(key: SharedKey.bio);
                            CacheHelper.removeData(key: SharedKey.email);
                            CacheHelper.removeData(key: SharedKey.name);
                            CacheHelper.removeData(key: SharedKey.title);
                            CacheHelper.removeData(key: SharedKey.phone);
                            Navigator.pushReplacementNamed(
                              context,
                              Routes.loginRoute,
                            );
                          },
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
                                      fontSize: FontSizeManager.s18.sp,
                                    ),
                              ),
                            ],
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

  static Widget leadItem({
    required BuildContext context,
    required DataLeadMedel model,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewLeadScreen(
              model: model,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height / AppSize.s50,
          horizontal: MediaQuery.of(context).size.width / AppSize.s30,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AppSize.s18.w,
          ),
          color: ColorManager.grey,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.name!.toTitleCase(),
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Text(
              "${AppStrings.ip} : ${model.ip}",
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontSize: FontSizeManager.s12.sp,
                  ),
            ),
            Text(
              "${AppStrings.location.tr()} : ${model.latitude},${model.longitude}",
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontSize: FontSizeManager.s12.sp,
                  ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height / AppSize.s50,
              ),
              child: Container(
                width: double.infinity,
                height: AppSize.s1.h,
                color: ColorManager.darkGrey,
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditLeadScreen(
                            model: model,
                          ),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.edit,
                          size: AppSize.s18.w,
                        ),
                        SizedBox(
                          width:
                              MediaQuery.of(context).size.width / AppSize.s100,
                        ),
                        Text(
                          AppStrings.edit.tr(),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          MediaQuery.of(context).size.width / AppSize.s200),
                  color: ColorManager.darkGrey,
                  width: 1,
                  height: AppSize.s24.h,
                ),
                Expanded(
                  flex: 3,
                  child: InkWell(
                    onTap: () async {
                      if (await FlutterContacts.requestPermission()) {
                        // Insert new contact
                        final newContact = Contact()
                          ..name.first = model.name ?? ""
                          ..emails = [
                            Email(
                              model.email ?? "",
                            ),
                          ]
                          ..phones = [Phone(model.phone ?? "")];
                        await newContact.insert().then(
                          (value) {
                            toast(
                              message: AppStrings.saved.tr(),
                              backgroundColor: ColorManager.agree,
                            );
                          },
                        );
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AssetsManager.download,
                          width: AppSize.s12.w,
                        ),
                        SizedBox(
                          width:
                              MediaQuery.of(context).size.width / AppSize.s100,
                        ),
                        Text(
                          AppStrings.download.tr(),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          MediaQuery.of(context).size.width / AppSize.s200),
                  color: ColorManager.darkGrey,
                  width: 1,
                  height: AppSize.s24.h,
                ),
                Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: () {
                      SharedWidget.showPopupShare(
                        context,
                        model.id,
                        "lead",
                        model.name!,
                        model.phone!,
                        model.companyName ?? "",
                        model.email,
                        model.position,
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.share,
                          size: AppSize.s18.w,
                        ),
                        SizedBox(
                          width:
                              MediaQuery.of(context).size.width / AppSize.s100,
                        ),
                        Text(
                          AppStrings.share.tr(),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static toast({required String message, required Color backgroundColor}) {
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: ColorManager.white,
      fontSize: FontSizeManager.s14.sp,
    );
  }
}
