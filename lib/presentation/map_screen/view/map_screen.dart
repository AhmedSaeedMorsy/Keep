// ignore_for_file: file_names, must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/common/widget.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/values_manager.dart';
import 'dart:ui' as UI;

class MapScreen extends StatelessWidget {
  MapScreen({super.key});
  UI.TextDirection direction = UI.TextDirection.ltr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / AppPadding.p20,
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
                      color: ColorManager.white,
                    ),
                  ),
                ),
              ),
            ),
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
                      top: MediaQuery.of(context).size.height / AppPadding.p12,
                      left: MediaQuery.of(context).size.width / AppPadding.p8,
                      right: MediaQuery.of(context).size.width / AppPadding.p8,
                    ),
                    child: Directionality(
                      textDirection: direction,
                      child: Column(children: [
                        Container(
                          height: AppSize.s150.h,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorManager.darkGrey,
                            ),
                            color: Colors.white,
                          ),
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => itemList(context),
                            separatorBuilder: (context, index) => Container(
                              color: ColorManager.darkGrey,
                              height: AppSize.s1,
                              width: double.infinity,
                            ),
                            itemCount: 10,
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemList(context) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / AppSize.s30,
          vertical: MediaQuery.of(context).size.height / AppSize.s50,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "IP: 123452212633512",
            ),
            Text("Cairo, Egypt")
          ],
        ),
      );
}
