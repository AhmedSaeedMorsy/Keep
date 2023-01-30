// ignore_for_file: must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/app/constant/enums_extentions.dart';
import 'package:keep/app/resources/font_manager.dart';
import '../../../app/common/widget.dart';
import '../../../app/resources/assets_manager.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/routes_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/values_manager.dart';
import '../../add_task/view/add_task_screen.dart';
import '../../edit_task/view/edit_task_screen.dart';
import '../../home/controller/home_bloc.dart';
import '../../home/controller/home_states.dart';
import '../../layout/controller/layout_bloc.dart';
import '../../layout/controller/layout_states.dart';
import '../../layout/view/layout_screen.dart';

class CalendarDailyScreen extends StatelessWidget {
  CalendarDailyScreen({super.key});
  var scaffoldKey = GlobalKey<ScaffoldState>();

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
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: ColorManager.white,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppStrings.calendar.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
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
                                );
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    DateFormat.E().format(
                                      DateTime.now(),
                                    ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                  ),
                                  CircleAvatar(
                                    radius: AppSize.s22.h,
                                    backgroundColor: ColorManager.primaryColor,
                                    child: Text(
                                      DateFormat.d().format(DateTime.now()),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            fontSize: FontSizeManager.s24.sp,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
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
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height /
                                AppSize.s50,
                          ),
                          BlocProvider(
                            create: (context) => HomeBloc(),
                            child: BlocBuilder<HomeBloc, HomeStates>(
                              builder: (context, state) {
                                return ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) =>
                                      taskItem(context, index),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        AppSize.s50,
                                  ),
                                  itemCount: 10,
                                );
                              },
                            ),
                          ),
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

  Widget taskItem(
    BuildContext context,
    int index,
  ) =>
      InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const EditTaskScreen()));
        },
        child: Container(
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
                    bottomSheetItem(context, index);

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
                        bottomSheetItem(context, index);

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
                ),
            ],
          ),
        ),
      );
  void bottomSheetItem(context, index) {
    scaffoldKey.currentState!
        .showBottomSheet(
          (context) => Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsetsDirectional.all(
                AppPadding.p20,
              ),
              child: Form(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SharedWidget.addReasonFormField(
                          controller: TextEditingController()),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width / AppSize.s30,
                        ),
                        child: BlocProvider(
                            create: (context) => HomeBloc(),
                            child: BlocBuilder<HomeBloc, HomeStates>(
                              builder: (context, state) {
                                return SharedWidget.defaultButton(
                                  context: context,
                                  function: () {
                                    HomeBloc.get(context).addToDecline(index);
                                    Navigator.pop(context);
                                  },
                                  text: AppStrings.submit.tr(),
                                  backgroundColor: ColorManager.primaryColor,
                                  style: Theme.of(context).textTheme.bodyLarge!,
                                );
                              },
                            )),
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
        .closed
        .then((value) {
      HomeBloc.get(context).changeBottomSheet(
        isShow: false,
      );
    });
    HomeBloc.get(context).changeBottomSheet(
      isShow: true,
    );
  }
}
