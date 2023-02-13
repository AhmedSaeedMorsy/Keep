// ignore_for_file: file_names, must_be_immutable, library_prefixes

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/common/widget.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/font_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/values_manager.dart';
import 'dart:ui' as UI;

class MapScreen extends StatelessWidget {
  MapScreen({super.key});
  UI.TextDirection direction = UI.TextDirection.ltr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorManager.white,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / AppPadding.p12,
                left: MediaQuery.of(context).size.width / AppPadding.p20,
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
                      color: ColorManager.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: SharedWidget.header(
                context,
              ),
            ),
            Expanded(
              flex: 4,
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
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / AppSize.s20,
                  ),
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => leadItem(context: context),
                    separatorBuilder: (context, index) => SizedBox(
                      height: MediaQuery.of(context).size.height / AppSize.s32,
                    ),
                    itemCount: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget leadItem({
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
          Row(
            children: [
              CircleAvatar(
                radius: AppSize.s30.w,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / AppSize.s50,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.leadName,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  Text(
                    "${AppStrings.ip} : 123452212633512",
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontSize: FontSizeManager.s12.sp,
                        ),
                  ),
                  Text(
                    "${AppStrings.location.tr()} : 123452212633512",
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontSize: FontSizeManager.s12.sp,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
