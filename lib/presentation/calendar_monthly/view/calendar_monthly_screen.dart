// ignore_for_file: must_be_immutable, library_prefixes

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/app/resources/routes_manager.dart';
import 'package:keep/presentation/add_task/view/add_task_screen.dart';
import 'package:keep/presentation/layout/controller/layout_bloc.dart';
import 'package:keep/presentation/layout/controller/layout_states.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../app/common/widget.dart';
import '../../../app/resources/assets_manager.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/values_manager.dart';
import '../../layout/view/layout_screen.dart';
import '../controller/calendar_monthly_bloc.dart';
import '../controller/calendar_monthly_states.dart';
import 'dart:ui' as UI;

class CalendarMonthlyScreen extends StatelessWidget {
  CalendarMonthlyScreen({super.key});
  UI.TextDirection direction = UI.TextDirection.ltr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => CalendarMonthlyBloc(),
        child: BlocBuilder<CalendarMonthlyBloc, CalendarMonthlyStates>(
          builder: (context, state) {
            return Container(
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
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height /
                              AppPadding.p30,
                          left: MediaQuery.of(context).size.width /
                              AppPadding.p12,
                          right: MediaQuery.of(context).size.width /
                              AppPadding.p12,
                        ),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              Align(
                                alignment: AlignmentDirectional.topStart,
                                child: Text(
                                  AppStrings.calendar.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height /
                                    AppSize.s22,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                  InkWell(
                                    onTap: () {
                                      CalendarMonthlyBloc.get(context)
                                          .decressDate();
                                    },
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      size: AppSize.s18.w,
                                    ),
                                  ),
                                  Text(
                                    DateFormat.yMMMM().format(
                                      DateTime(
                                        DateTime.now().year,
                                        CalendarMonthlyBloc.get(context)
                                            .dateTimeMonth,
                                      ),
                                    ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      CalendarMonthlyBloc.get(context)
                                          .incressDate();
                                    },
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      size: AppSize.s18.w,
                                    ),
                                  ),
                                  BlocProvider(
                                      create: (context) => LayoutBloc(),
                                      child: BlocBuilder<LayoutBloc,
                                          LayoutStates>(
                                        builder: (context, state) {
                                          return IconButton(
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                context,
                                                Routes.layoutRoute,
                                              );
                                              screen = AddTask();
                                              LayoutBloc.get(context)
                                                  .changeBottomNavBar(5);
                                            },
                                            icon: Image(
                                              image: const AssetImage(
                                                AssetsManager.addTask,
                                              ),
                                              width: AppSize.s22.w,
                                            ),
                                          );
                                        },
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height /
                                    AppSize.s50,
                              ),
                              SizedBox(
                                height: AppSize.s700.h,
                                child: SfCalendar(
                                  view: CalendarView.month,
                                  firstDayOfWeek: 7,
                                  viewNavigationMode: ViewNavigationMode.none,
                                  dataSource: MeetingDataSource(
                                    _getDataSource(),
                                  ),
                                  monthViewSettings: const MonthViewSettings(
                                    numberOfWeeksInView: 6,
                                    appointmentDisplayMode:
                                        MonthAppointmentDisplayMode
                                            .appointment,
                                  ),
                                  headerHeight: AppSize.s1,
                                  headerStyle: const CalendarHeaderStyle(
                                    textStyle: TextStyle(
                                      color: ColorManager.white,
                                      height: 0,
                                    ),
                                  ),
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
          },
        ),
      ),
    );
  }

  /// filter dialog

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
        DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Meeting(
        'Conference', startTime, endTime, ColorManager.primaryColor, false));
    meetings.add(Meeting(
        'Conference', startTime, endTime, ColorManager.primaryColor, false));

    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
