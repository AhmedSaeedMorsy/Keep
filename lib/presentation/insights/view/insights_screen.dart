// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/app/resources/font_manager.dart';
import 'package:keep/app/resources/strings_manager.dart';
import 'package:keep/presentation/insights/controller/insights_states.dart';
import '../../../app/common/widget.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/values_manager.dart';
import '../controller/insights_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class InsightsScreen extends StatelessWidget {
  InsightsScreen({super.key});
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        color: ColorManager.white,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: SharedWidget.header(
                context,
              ),
            ),
            BlocProvider(
              create: (context) => InsightsBloc()
                ..getInsightsConnects(context: context)
                ..getInsightsVisits(context: context)
                ..getInsightsKits(context: context)
                ..getGoal(context: context),
              child: BlocBuilder<InsightsBloc, InsightsStates>(
                builder: (context, state) {
                  return Expanded(
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
                              AppPadding.p20,
                          right: MediaQuery.of(context).size.width /
                              AppPadding.p20,
                        ),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppStrings.goal.tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(
                                          fontSize: FontSizeManager.s22.sp,
                                        ),
                                  ),
                                  Text(
                                    "${(InsightsBloc.get(context).goalValue * 100).round()}%",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(
                                          fontSize: FontSizeManager.s22.sp,
                                        ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height /
                                    AppSize.s80,
                              ),
                              LinearPercentIndicator(
                                animation: true,
                                barRadius: const Radius.circular(
                                  AppSize.s50,
                                ),
                                clipLinearGradient: true,
                                lineHeight: AppSize.s24.h,
                                animationDuration:
                                    AppIntDuration.linearDuration,
                                percent: InsightsBloc.get(context).goalValue,
                                center: Text(
                                  "${(InsightsBloc.get(context).goalValue * 100).round()}%",
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                                progressColor: InsightsBloc.get(context)
                                    .getSleekSliderColor(
                                  InsightsBloc.get(context).goalValue,
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height /
                                    AppSize.s20,
                              ),
                              Row(
                                children: [
                                  InsightsBloc.get(context)
                                          .insightsVisitsModel
                                          .data
                                          .isNotEmpty
                                      ? Expanded(
                                          child: insightsItem(
                                            context: context,
                                            name: AppStrings.profileVisits.tr(),
                                            data: InsightsBloc.get(context)
                                                    .insightsVisitsModel
                                                    .data[0]
                                                    .visits ??
                                                "0",
                                          ),
                                        )
                                      : Expanded(
                                          child: insightsItem(
                                              context: context,
                                              name:
                                                  AppStrings.profileVisits.tr(),
                                              data: "0"),
                                        ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width /
                                        AppSize.s50,
                                  ),
                                  Expanded(
                                    child: insightsItem(
                                      context: context,
                                      name: AppStrings.kitsViews.tr(),
                                      data: InsightsBloc.get(context)
                                              .insightsKitsModel
                                              .data
                                              .count ??
                                          "0",
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height /
                                    AppSize.s50,
                              ),
                              insightsItem(
                                context: context,
                                name: AppStrings.numberOfConnects.tr(),
                                data: InsightsBloc.get(context)
                                    .insightsConnectsModel
                                    .data
                                    .toString(),
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget insightsItem({
    required BuildContext context,
    required String name,
    required String data,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width / AppSize.s40,
        vertical: MediaQuery.of(context).size.height / AppSize.s20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppSize.s18.w,
        ),
        color: ColorManager.grey,
      ),
      child: Column(
        children: [
          Text(
            data.toString(),
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontSize: FontSizeManager.s24.sp,
                ),
          ),
          Text(
            name,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ],
      ),
    );
  }
}
