// ignore_for_file: must_be_immutable, library_prefixes, prefer_final_fields

import 'package:conditional_builder_rec/conditional_builder_rec.dart';
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
import '../../../model/task_model.dart';
import '../../edit_task/view/edit_task_screen.dart';
import '../../home/controller/home_bloc.dart';
import '../../home/controller/home_states.dart';
import '../../layout/controller/layout_bloc.dart';
import '../../layout/controller/layout_states.dart';
import 'dart:ui' as UI;

class CalendarDailyScreen extends StatelessWidget {
  CalendarDailyScreen({super.key});
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  UI.TextDirection direction = UI.TextDirection.ltr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                    top: MediaQuery.of(context).size.height / AppPadding.p30,
                    left: MediaQuery.of(context).size.width / AppPadding.p20,
                    right: MediaQuery.of(context).size.width / AppPadding.p20,
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
                                          fontSize: FontSizeManager.s20.sp,
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
                          height:
                              MediaQuery.of(context).size.height / AppSize.s50,
                        ),
                        BlocProvider(
                          create: (context) => HomeBloc()..getTask(context: context,),
                          child: BlocBuilder<HomeBloc, HomeStates>(
                            builder: (context, state) {
                              return ConditionalBuilderRec(
                                condition:
                                    HomeBloc.get(context).taskList.isNotEmpty,
                                builder: (context) {
                                  return ListView.separated(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) => taskItem(
                                      context,
                                      index,
                                      HomeBloc.get(context).taskList[index],
                                    ),
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              AppSize.s50,
                                    ),
                                    itemCount:
                                        HomeBloc.get(context).taskList.length,
                                  );
                                },
                                fallback: (context) => Center(
                                  child: Text(
                                    AppStrings.notTaskesYet.tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                ),
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
          ],
        ),
      ),
    );
  }

  var bottomSheetController = TextEditingController();
  Widget taskItem(
    BuildContext context,
    int index,
    TaskData model,
  ) =>
      InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditTaskScreen(
                task: model,
              ),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / AppSize.s22,
            vertical: MediaQuery.of(context).size.height / AppSize.s30,
          ),
          decoration: BoxDecoration(
            color: HomeBloc.get(context).taskState[index] == "agree" ||
                    model.status == "completed"
                ? ColorManager.agree
                : HomeBloc.get(context).taskState[index] == "decline" ||
                        model.status == "rejected"
                    ? ColorManager.error
                    : ColorManager.grey,
            borderRadius: BorderRadius.circular(
              MediaQuery.of(context).size.width / AppSize.s30,
            ),
          ),
          child: Row(
            children: [
              Text(
                model.title!.toTitleCase(),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: HomeBloc.get(context).taskState[index] == "agree" ||
                        model.status == "completed"
                    ? Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: ColorManager.white,
                        )
                    : HomeBloc.get(context).taskState[index] == "decline" ||
                            model.status == "rejected"
                        ? Theme.of(context).textTheme.headlineSmall!.copyWith(
                              color: ColorManager.white,
                            )
                        : Theme.of(context).textTheme.headlineSmall,
              ),
              const Spacer(),
              HomeBloc.get(context).taskState[index] == "agree" ||
                      model.status == "completed"
                  ? InkWell(
                      onTap: () {
                        HomeBloc.get(context).addToDecline(index);

                        bottomSheetItem(context, index, model.id, "rejected");
                      },
                      child: const Image(
                        image: AssetImage(
                          AssetsManager.delete,
                        ),
                      ),
                    )
                  : HomeBloc.get(context).taskState[index] == "decline" ||
                          model.status == "rejected"
                      ? InkWell(
                          onTap: () {
                            HomeBloc.get(context).addToAgree(index);
                            bottomSheetItem(
                                context, index, model.id, "completed");
                          },
                          child: const Image(
                            image: AssetImage(
                              AssetsManager.agree,
                            ),
                          ),
                        )
                      : HomeBloc.get(context).taskState[index] == null &&
                              model.status != "completed" &&
                              model.status != "rejected"
                          ? Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    bottomSheetItem(
                                        context, index, model.id, "rejected");

                                    HomeBloc.get(context).addToDecline(index);
                                  },
                                  child: const Image(
                                    image: AssetImage(
                                      AssetsManager.delete,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width /
                                      AppSize.s30,
                                ),
                                InkWell(
                                  onTap: () {
                                    HomeBloc.get(context).addToAgree(index);
                                    bottomSheetItem(
                                      context,
                                      index,
                                      model.id,
                                      "completed",
                                    );
                                  },
                                  child: const Image(
                                    image: AssetImage(
                                      AssetsManager.agree,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Container(),
            ],
          ),
        ),
      );
  void bottomSheetItem(context, index, int id, String status) {
    _scaffoldKey.currentState!
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
                          controller: bottomSheetController),
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
                                    HomeBloc.get(context).changeTaskStatus(
                                        id: id,context: context,
                                        status: status,
                                        summary: bottomSheetController.text);
                                    Navigator.pop(context);
                                  },
                                  text: AppStrings.submit.tr(),
                                  backgroundColor: ColorManager.white,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: ColorManager.primaryColor),
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
