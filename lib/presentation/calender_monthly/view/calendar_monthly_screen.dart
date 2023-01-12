import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/common/widget.dart';
import '../../../app/resources/assets_manager.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/values_manager.dart';
import '../../home/controller/home_bloc.dart';
import '../controller/calendar_monthly_bloc.dart';
import '../controller/calendar_monthly_states.dart';

class CalendarMonthlyScreen extends StatelessWidget {
  const CalendarMonthlyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalendarMonthlyBloc(),
      child: BlocBuilder<CalendarMonthlyBloc, CalendarMonthlyStates>(
        builder: (context, state) {
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
                          top: MediaQuery.of(context).size.height /
                              AppPadding.p30,
                          left: MediaQuery.of(context).size.width /
                              AppPadding.p12,
                          right: MediaQuery.of(context).size.width /
                              AppPadding.p12,
                        ),
                        child: Column(
                          children: [
                            Align(
                              alignment: AlignmentDirectional.topStart,
                              child: Text(
                                AppStrings.calendar.tr(),
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  AppSize.s22,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {},
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
                                IconButton(
                                  onPressed: () {},
                                  icon: Image(
                                    image: const AssetImage(
                                      AssetsManager.addTask,
                                    ),
                                    width: AppSize.s22.w,
                                  ),
                                ),
                              ],
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
          );
        },
      ),
    );
  }
}
