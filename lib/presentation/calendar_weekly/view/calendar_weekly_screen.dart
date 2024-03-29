// ignore_for_file: library_prefixes, must_be_immutable

import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/app/resources/font_manager.dart';
import 'package:keep/app/services/shared_prefrences/cache_helper.dart';
import '../../../app/common/widget.dart';
import '../../../app/resources/assets_manager.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/routes_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/values_manager.dart';
import '../../../model/task_model.dart';
import '../../layout/controller/layout_bloc.dart';
import '../../layout/controller/layout_states.dart';
import 'dart:ui' as UI;

import '../controller/calendar_weekly_bloc.dart';
import '../controller/calendar_weekly_states.dart';

class CalendarWeeklyScreen extends StatelessWidget {
  CalendarWeeklyScreen({super.key});
  var scaffoldKey = GlobalKey<ScaffoldState>();
  UI.TextDirection direction = UI.TextDirection.ltr;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalendarWeeklyBloc()
        ..getTask(context: context,
          token: CacheHelper.getData(
            key: SharedKey.token,
          ),
        ),
      child: BlocBuilder<CalendarWeeklyBloc, CalendarWeeklyStates>(
          builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
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
                      padding: EdgeInsets.only(
                        top:
                            MediaQuery.of(context).size.height / AppPadding.p30,
                        left:
                            MediaQuery.of(context).size.width / AppPadding.p20,
                        right:
                            MediaQuery.of(context).size.width / AppPadding.p20,
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
                                          Navigator.pushNamed(
                                          context, Routes.addTaskFromFilter);
                                        },
                                        icon: Image(
                                          image: const AssetImage(
                                            AssetsManager.addTask,
                                          ),
                                          width: AppSize.s22.w,
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional.bottomEnd,
                                        child: IconButton(
                                          onPressed: () {
                                            SharedWidget.showPopupFilter(
                                                context);
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
                            listItem(
                              context,
                              0,
                              CalendarWeeklyBloc.get(context).getTaskPerDate(
                                dateTime: DateTime.now().add(
                                  const Duration(days: 0),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  AppSize.s50,
                            ),
                            listItem(
                              context,
                              1,
                              CalendarWeeklyBloc.get(context).getTaskPerDate(
                                dateTime: DateTime.now().add(
                                  const Duration(days: 1),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  AppSize.s50,
                            ),
                            listItem(
                              context,
                              2,
                              CalendarWeeklyBloc.get(context).getTaskPerDate(
                                dateTime: DateTime.now().add(
                                  const Duration(days: 2),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  AppSize.s50,
                            ),
                            listItem(
                              context,
                              3,
                              CalendarWeeklyBloc.get(context).getTaskPerDate(
                                dateTime: DateTime.now().add(
                                  const Duration(days: 3),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  AppSize.s50,
                            ),
                            listItem(
                              context,
                              4,
                              CalendarWeeklyBloc.get(context).getTaskPerDate(
                                dateTime: DateTime.now().add(
                                  const Duration(days: 4),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  AppSize.s50,
                            ),
                            listItem(
                              context,
                              5,
                              CalendarWeeklyBloc.get(context).getTaskPerDate(
                                dateTime: DateTime.now().add(
                                  const Duration(days: 5),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  AppSize.s50,
                            ),
                            listItem(
                              context,
                              6,
                              CalendarWeeklyBloc.get(context).getTaskPerDate(
                                dateTime: DateTime.now().add(
                                  const Duration(days: 6),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  AppSize.s50,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget listItem(context, int index, List<TaskData> listTask) {
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
                          fontSize: FontSizeManager.s14.sp,
                        ),
                  ),
                  Text(
                    DateFormat.d().format(
                      DateTime.now().add(Duration(days: index)),
                    ),
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: FontSizeManager.s26.sp,
                        ),
                  ),
                  Text(
                    DateFormat.LLL().format(
                      DateTime.now().add(Duration(days: index)),
                    ),
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: FontSizeManager.s14.sp,
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
              child: ConditionalBuilderRec(
                condition: listTask.isNotEmpty,
                builder: (context) {
                  return ListView.separated(
                    padding: EdgeInsets.zero,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        taskItem(context, listTask[index]),
                    separatorBuilder: (context, index) => SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s80),
                    itemCount: listTask.length,
                  );
                },
                fallback: (context) => Center(
                  child: Text(
                    AppStrings.notTaskesYet.tr(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget taskItem(context, TaskData model) => Container(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height / AppSize.s120,
          horizontal: MediaQuery.of(context).size.width / AppSize.s50,
        ),
        decoration: const BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.all(
              Radius.circular(
                AppSize.s10,
              ),
            )),
        child: Text(
          model.title!.toUpperCase(),
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: FontSizeManager.s14.sp,
                color: ColorManager.primaryColor,
              ),
        ),
      );
}
