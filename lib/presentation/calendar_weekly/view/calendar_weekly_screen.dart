// ignore_for_file: library_prefixes, must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/app/resources/font_manager.dart';
import '../../../app/common/widget.dart';
import '../../../app/resources/assets_manager.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/routes_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/values_manager.dart';
import '../../add_task/view/add_task_screen.dart';
import '../../layout/controller/layout_bloc.dart';
import '../../layout/controller/layout_states.dart';
import '../../layout/view/layout_screen.dart';
import 'dart:ui' as UI;

class CalendarWeeklyScreen extends StatelessWidget {
  CalendarWeeklyScreen({super.key});
  var scaffoldKey = GlobalKey<ScaffoldState>();
  UI.TextDirection direction = UI.TextDirection.ltr;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / AppPadding.p30,
                      left: MediaQuery.of(context).size.width / AppPadding.p12,
                      right: MediaQuery.of(context).size.width / AppPadding.p12,
                    ),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          BlocProvider(
                            create: (context) => LayoutBloc(),
                            child: BlocBuilder<LayoutBloc, LayoutStates>(
                              builder: (context, state) {
                                return Row(
                                  children: [
                                    Text(
                                      AppStrings.calendar.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        screen = AddTask();
                                        LayoutBloc.get(context)
                                            .changeBottomNavBar(5);
                                        Navigator.pushNamed(
                                          context,
                                          Routes.layoutRoute,
                                        );
                                      },
                                      icon: Image(
                                        image: const AssetImage(
                                          AssetsManager.addTask,
                                        ),
                                        width: AppSize.s22.w,
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional.bottomEnd,
                                      child: IconButton(
                                        onPressed: () {
                                          SharedWidget.showPopupFilter(context);
                                        },
                                        icon: Image(
                                          image: const AssetImage(
                                            AssetsManager.filter,
                                          ),
                                          width: AppSize.s22.w,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) =>
                                listItem(context, index),
                            separatorBuilder: (context, index) => SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  AppSize.s50,
                            ),
                            itemCount: 7,
                          )
                        ],
                      ),
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

  Widget listItem(context, int index) {
    return Container(
      height: AppSize.s130.h,
      decoration: const BoxDecoration(
        color: ColorManager.grey,
        borderRadius: BorderRadius.all(
          Radius.circular(
            AppSize.s10,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height / AppSize.s50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    DateFormat.E().format(
                      DateTime.now().add(Duration(days: index)),
                    ),
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: FontSizeManager.s16.sp,
                        ),
                  ),
                  Text(
                    DateFormat.d().format(
                      DateTime.now().add(Duration(days: index)),
                    ),
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: FontSizeManager.s32.sp,
                        ),
                  ),
                  Text(
                    DateFormat.LLL().format(
                      DateTime.now().add(Duration(days: index)),
                    ),
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: FontSizeManager.s16.sp,
                        ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: ColorManager.darkGrey,
            width: AppSize.s1,
            height: double.infinity,
          ),
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height / AppSize.s50,
                  horizontal: MediaQuery.of(context).size.width / AppSize.s50,
                ),
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => taskItem(context),
                  separatorBuilder: (context, index) => SizedBox(
                      height: MediaQuery.of(context).size.height / AppSize.s80),
                  itemCount: 10,
                ),
              )),
        ],
      ),
    );
  }

  Widget taskItem(context) => Container(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height / AppSize.s120,
          horizontal: MediaQuery.of(context).size.width / AppSize.s50,
        ),
        decoration: const BoxDecoration(
            color: ColorManager.darkGrey,
            borderRadius: BorderRadius.all(
              Radius.circular(
                AppSize.s10,
              ),
            )),
        child: Text(
          "Task Name",
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .copyWith(fontSize: FontSizeManager.s16.sp),
        ),
      );
}
