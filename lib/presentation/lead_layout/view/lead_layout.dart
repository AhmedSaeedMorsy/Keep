// ignore_for_file: library_private_types_in_public_api

import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/app/resources/font_manager.dart';
import 'package:keep/app/resources/strings_manager.dart';

import '../../../app/common/widget.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/values_manager.dart';
import 'lead_screen.dart';

class LeadsLayout extends StatefulWidget {
  const LeadsLayout({super.key});

  @override
  _LeadsLayoutState createState() => _LeadsLayoutState();
}

class _LeadsLayoutState extends State<LeadsLayout>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 6, vsync: this);
    super.initState();
  }

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
                milliseconds: AppIntDuration.duration500,
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
                milliseconds: AppIntDuration.duration500,
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
                      )),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / AppPadding.p30,
                      left: MediaQuery.of(context).size.width / AppPadding.p12,
                      right: MediaQuery.of(context).size.width / AppPadding.p12,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TabBar(
                          isScrollable: true,
                          physics: const BouncingScrollPhysics(),
                          unselectedLabelColor: ColorManager.darkGrey,
                          labelColor: ColorManager.darkGrey,
                          labelStyle: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                fontSize: FontSizeManager.s18.sp,
                              ),
                          tabs: [
                            Tab(
                              text: AppStrings.total.tr(),
                            ),
                            Tab(
                              text: AppStrings.today.tr(),
                            ),
                            Tab(
                              text: AppStrings.yasterday.tr(),
                            ),
                            Tab(
                              text: AppStrings.thisWeek.tr(),
                            ),
                            Tab(
                              text: AppStrings.thisMonth.tr(),
                            ),
                            InkWell(
                              onTap: () {
                                showPopupCustomDate(context);
                              },
                              child: Tab(
                                text: AppStrings.custom.tr(),
                              ),
                            ),
                          ],
                          controller: _tabController,
                          indicatorSize: TabBarIndicatorSize.label,
                        ),
                        Expanded(
                          child: TabBarView(
                            physics: const BouncingScrollPhysics(),
                            controller: _tabController,
                            children: const [
                              LeedScreen(),
                              LeedScreen(),
                              LeedScreen(),
                              LeedScreen(),
                              LeedScreen(),
                              LeedScreen(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  static void showPopupCustomDate(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return FadeInDown(
            duration: const Duration(milliseconds: AppIntDuration.duration500),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: AppSize.s150.h,
                  color: ColorManager.white,
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width / AppSize.s18,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical:
                                        MediaQuery.of(context).size.height /
                                            AppSize.s80,
                                    horizontal:
                                        MediaQuery.of(context).size.width /
                                            AppSize.s50,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: ColorManager.grey,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        AppSize.s50,
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width /
                                              AppSize.s50,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          AppStrings.from.tr(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayLarge,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              AppSize.s8,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now()
                                                  .subtract(const Duration(
                                                      days: 365)),
                                              lastDate: DateTime.now().add(
                                                  const Duration(days: 365)),
                                            );
                                          },
                                          child: const Icon(
                                            Icons.calendar_month,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                          MediaQuery.of(context).size.height /
                                              AppSize.s80,
                                      horizontal:
                                          MediaQuery.of(context).size.width /
                                              AppSize.s50),
                                  decoration: const BoxDecoration(
                                    color: ColorManager.grey,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        AppSize.s50,
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width /
                                              AppSize.s50,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          AppStrings.to.tr(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayLarge,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              AppSize.s6,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now()
                                                  .subtract(const Duration(
                                                      days: 365)),
                                              lastDate: DateTime.now().add(
                                                  const Duration(days: 365)),
                                            );
                                          },
                                          child: const Icon(
                                            Icons.calendar_month,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s80,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width / AppSize.s18,
                                vertical:  MediaQuery.of(context).size.height / AppSize.s30,
                          ),
                          child: SharedWidget.defaultButton(
                            context: context,
                            function: () {
                              Navigator.pop(context);
                            },
                            text: AppStrings.submit.tr(),
                            backgroundColor: ColorManager.primaryColor,
                            style: Theme.of(context).textTheme.headlineLarge!,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
