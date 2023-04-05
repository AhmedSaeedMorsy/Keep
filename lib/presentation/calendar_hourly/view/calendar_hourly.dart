// ignore_for_file: must_be_immutable, library_prefixes

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/app/resources/font_manager.dart';
import 'package:keep/presentation/home/controller/home_bloc.dart';
import 'package:keep/presentation/home/controller/home_states.dart';
import 'package:keep/presentation/layout/controller/layout_states.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../app/common/widget.dart';
import '../../../app/resources/assets_manager.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/routes_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/values_manager.dart';
import '../../../app/services/calender_helper/calender_helper.dart';
import '../../add_task/view/add_task_screen.dart';
import '../../layout/controller/layout_bloc.dart';
import '../../layout/view/layout_screen.dart';
import 'dart:ui' as UI;

class CalendarHorlyScreen extends StatelessWidget {
  CalendarHorlyScreen({super.key});
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
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / AppPadding.p30,
                    left: MediaQuery.of(context).size.width / AppPadding.p20,
                    right: MediaQuery.of(context).size.width / AppPadding.p20,
                  ),
                  child: Column(
                    children: [
                      BlocProvider(
                        create: (context) => LayoutBloc(),
                        child: BlocBuilder<LayoutBloc, LayoutStates>(
                          builder: (context, state) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppStrings.calendar.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    IconButton(
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
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s50,
                      ),
                      Expanded(
                        child: BlocProvider(
                          create: (context) => HomeBloc()..getTask(),
                          child: BlocBuilder<HomeBloc, HomeStates>(
                            builder: (context, state) {
                              return SfCalendar(
                                viewNavigationMode: ViewNavigationMode.snap,
                                headerHeight: 0,
                                view: CalendarView.day,
                                dataSource: MeetingDataSource(
                                    HomeBloc.get(context).meetings),
                                todayHighlightColor: ColorManager.primaryColor,
                                appointmentTextStyle: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(
                                      color: ColorManager.white,
                                    ),
                                todayTextStyle: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontSize: FontSizeManager.s26,
                                    ),
                                headerStyle: CalendarHeaderStyle(
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(color: ColorManager.white),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
