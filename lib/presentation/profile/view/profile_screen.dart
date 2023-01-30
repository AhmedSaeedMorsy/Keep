import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keep/app/common/widget.dart';

import '../../../app/resources/assets_manager.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/values_manager.dart';
import 'dart:ui' as UI;

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  UI.TextDirection direction = UI.TextDirection.ltr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.white,
        body: Column(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / AppSize.s3,
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Align(
                  alignment: AlignmentDirectional.topCenter,
                  child: Stack(
                    alignment: AlignmentDirectional.topStart,
                    children: [
                      Container(
                        width: double.infinity,
                        height:
                            MediaQuery.of(context).size.height / AppSize.s4_3,
                        color: ColorManager.primaryColor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height /
                              AppPadding.p20,
                          left: MediaQuery.of(context).size.width /
                              AppPadding.p20,
                        ),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Directionality(
                              textDirection: direction,
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: ColorManager.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius:
                              MediaQuery.of(context).size.height / AppSize.s9_4,
                          backgroundColor: ColorManager.white,
                        ),
                        CircleAvatar(
                          radius:
                              MediaQuery.of(context).size.height / AppSize.s10,
                          backgroundColor: ColorManager.grey,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / AppSize.s80,
          ),
          Text(
            AppStrings.leadName,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            AppStrings.jobTitle.tr(),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / AppSize.s22,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / AppSize.s8,
            ),
            child: SharedWidget.defaultButton(
              backgroundColor: ColorManager.primaryColor,
              function: () {},
              text: AppStrings.saveContact.tr(),
              context: context,
              style: Theme.of(context).textTheme.bodyLarge!,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / AppSize.s20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / AppSize.s18,
            ),
            child: Container(
              width: double.infinity,
              height: AppSize.s1.w,
              color: ColorManager.grey,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / AppSize.s18,
              vertical: MediaQuery.of(context).size.height / AppSize.s30,
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: SvgPicture.asset(
                      AssetsManager.customlink,
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: SvgPicture.asset(
                      AssetsManager.tiktok,
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: SvgPicture.asset(
                      AssetsManager.snapchat,
                    ),
                  ),
                ),
              ],
            ),
          )
        ]));
  }
}
