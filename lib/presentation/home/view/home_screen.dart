import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/app/constant/enums_extentions.dart';
import 'package:keep/app/resources/assets_manager.dart';
import 'package:keep/app/resources/font_manager.dart';
import 'package:keep/app/resources/strings_manager.dart';
import 'package:keep/presentation/add_task/view/add_task_screen.dart';
import 'package:keep/presentation/home/controller/home_bloc.dart';
import 'package:keep/presentation/home/controller/home_states.dart';
import 'package:keep/presentation/layout/controller/layout_bloc.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import '../../../app/common/widget.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/values_manager.dart';
import '../../calender_monthly/view/calendar_monthly_screen.dart';
import '../../layout/view/layout_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: BlocBuilder<HomeBloc, HomeStates>(
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
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: SleekCircularSlider(
                                  min: 0,
                                  max: 100,
                                  initialValue: 75,
                                  appearance: CircularSliderAppearance(
                                    startAngle: 270,
                                    angleRange: 360,
                                    size: AppSize.s130.w,
                                    animDurationMultiplier: AppIntDuration.s4_5,
                                    infoProperties: InfoProperties(
                                      topLabelText: AppStrings.kpi,
                                      mainLabelStyle: Theme.of(context)
                                          .textTheme
                                          .headlineLarge!
                                          .copyWith(
                                            color: ColorManager.primaryColor,
                                            fontSize: FontSizeManager.s26.sp,
                                          ),
                                      topLabelStyle: Theme.of(context)
                                          .textTheme
                                          .headlineLarge!
                                          .copyWith(
                                            fontSize: FontSizeManager.s32.sp,
                                            color: ColorManager.primaryColor,
                                          ),
                                    ),
                                    customColors: CustomSliderColors(
                                      progressBarColor:
                                          ColorManager.primaryColor,
                                      trackColor: ColorManager.grey,
                                      hideShadow: true,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height /
                                    AppSize.s30,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width /
                                          AppSize.s16,
                                  vertical: MediaQuery.of(context).size.height /
                                      AppSize.s50,
                                ),
                                child: Container(
                                  color: ColorManager.grey,
                                  width: double.infinity,
                                  height: AppSize.s2.h,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      screen = const CalendarMonthlyScreen();
                                      LayoutBloc.get(context)
                                          .changeBottomNavBar(5);
                                    },
                                    icon: Image(
                                      image: const AssetImage(
                                        AssetsManager.calender,
                                      ),
                                      width: AppSize.s22.w,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      HomeBloc.get(context).decressDate();
                                    },
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      size: AppSize.s18.w,
                                    ),
                                  ),
                                  Text(
                                    DateFormat.yMMMd().format(
                                      HomeBloc.get(context).dateTime,
                                    ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      HomeBloc.get(context).incressDate();
                                    },
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      size: AppSize.s18.w,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
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
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height /
                                    AppSize.s50,
                              ),
                              Text(
                                AppStrings.dailyTask.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .copyWith(
                                      color: ColorManager.greyWithOpacity,
                                    ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height /
                                    AppSize.s50,
                              ),
                              ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) =>
                                    taskItem(context, index),
                                separatorBuilder: (context, index) => SizedBox(
                                  height: MediaQuery.of(context).size.height /
                                      AppSize.s50,
                                ),
                                itemCount: 10,
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
          );
        },
      ),
    );
  }

  Widget taskItem(
    BuildContext context,
    int index,
  ) =>
      Container(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / AppSize.s22,
          vertical: MediaQuery.of(context).size.height / AppSize.s30,
        ),
        decoration: BoxDecoration(
          color: HomeBloc.get(context).taskState[index] == "agree"
              ? ColorManager.agree
              : HomeBloc.get(context).taskState[index] == "decline"
                  ? ColorManager.error
                  : ColorManager.grey,
          borderRadius: BorderRadius.circular(
            MediaQuery.of(context).size.width / AppSize.s30,
          ),
        ),
        child: Row(
          children: [
            Text(
              AppStrings.taskName.toTitleCase(),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: HomeBloc.get(context).taskState[index] == "agree"
                  ? Theme.of(context).textTheme.headlineSmall
                  : HomeBloc.get(context).taskState[index] == "decline"
                      ? Theme.of(context).textTheme.headlineSmall!.copyWith(
                            color: ColorManager.white,
                          )
                      : Theme.of(context).textTheme.headlineSmall,
            ),
            const Spacer(),
            if (HomeBloc.get(context).taskState[index] == "agree")
              InkWell(
                onTap: () {
                  HomeBloc.get(context).addToDecline(index);
                },
                child: const Image(
                  image: AssetImage(
                    AssetsManager.delete,
                  ),
                ),
              ),
            if (HomeBloc.get(context).taskState[index] == "decline")
              InkWell(
                onTap: () {
                  HomeBloc.get(context).addToAgree(index);
                },
                child: const Image(
                  image: AssetImage(
                    AssetsManager.agree,
                  ),
                ),
              ),
            if (HomeBloc.get(context).taskState[index] == null)
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      HomeBloc.get(context).addToDecline(index);
                    },
                    child: const Image(
                      image: AssetImage(
                        AssetsManager.delete,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / AppSize.s30,
                  ),
                  InkWell(
                    onTap: () {
                      HomeBloc.get(context).addToAgree(index);
                    },
                    child: const Image(
                      image: AssetImage(
                        AssetsManager.agree,
                      ),
                    ),
                  ),
                ],
              )
          ],
        ),
      );
}
