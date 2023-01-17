// ignore_for_file: file_names

import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/app/common/widget.dart';
import 'package:keep/app/resources/assets_manager.dart';
import 'package:keep/app/resources/font_manager.dart';
import 'package:keep/app/resources/routes_manager.dart';
import 'package:keep/presentation/layout/controller/layout_bloc.dart';
import 'package:keep/presentation/layout/view/layout_screen.dart';
import 'package:keep/presentation/view_knowledge/view/view_knowledge_screen.dart';

import '../../../app/resources/color_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/values_manager.dart';

class KnowledgeScreen extends StatelessWidget {
  const KnowledgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          end: Alignment.bottomCenter,
          begin: Alignment.topCenter,
          colors: [
            ColorManager.primaryColor,
            ColorManager.primaryColor,
            ColorManager.primaryColor,
            ColorManager.white,
          ],
        ),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: FadeInDown(
              duration: const Duration(
                seconds: AppIntDuration.s1,
              ),
              child: SharedWidget.header(
                context,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: FadeInUp(
              duration: const Duration(
                seconds: AppIntDuration.s1,
              ),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      AppSize.s40.w,
                    ),
                    topRight: Radius.circular(
                      AppSize.s40.w,
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / AppPadding.p30,
                    left: MediaQuery.of(context).size.width / AppPadding.p12,
                    right: MediaQuery.of(context).size.width / AppPadding.p12,
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(
                          AppStrings.businessKit.tr(),
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s22,
                      ),
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) =>
                              businessKitItem(context: context),
                          separatorBuilder: (context, index) => SizedBox(
                            height: MediaQuery.of(context).size.height /
                                AppSize.s22,
                          ),
                          itemCount: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget businessKitItem({
    required BuildContext context,
  }) {
    return Container(
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
            AppStrings.fileName.tr(),
            style: Theme.of(context).textTheme.displayLarge,
          ),
          Text(
            AppStrings.fileDescription.tr(),
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontSize: FontSizeManager.s12.sp,
                ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
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
                    screen = const ViewKnowledgeScreen();
                    LayoutBloc.get(context).changeBottomNavBar(5);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.visibility,
                        size: AppSize.s18.w,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / AppSize.s100,
                      ),
                      Text(
                        AppStrings.view.tr(),
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
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AssetsManager.download,
                        width: AppSize.s12.w,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / AppSize.s100,
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
                flex: 3,
                child: InkWell(
                  onTap: () {
                    showPopupScanner(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AssetsManager.scanner,
                        width: AppSize.s18.w,
                        color: ColorManager.primaryColor,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / AppSize.s100,
                      ),
                      Text(
                        AppStrings.qrcode.tr(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / AppSize.s200,
                ),
                color: ColorManager.darkGrey,
                width: 1,
                height: AppSize.s24.h,
              ),
              Expanded(
                flex: 2,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.shareRoute,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.share,
                        size: AppSize.s18.w,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / AppSize.s100,
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
    );
  }

  void showPopupScanner(context) {
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
}
