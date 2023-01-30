// ignore_for_file: must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/app/common/widget.dart';
import 'package:keep/app/resources/color_manager.dart';
import 'package:keep/app/resources/values_manager.dart';
import '../../../app/resources/font_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/styles_manager.dart';

class EditTaskScreen extends StatelessWidget {
  const EditTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeInDown(
        duration:const Duration( milliseconds: AppIntDuration.duration500,),
        child: Container(
          color: ColorManager.white,
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / AppSize.s16,
            vertical: MediaQuery.of(context).size.height / AppSize.s26,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / AppPadding.p40,
                    bottom: MediaQuery.of(context).size.height / AppPadding.p40,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: ColorManager.primaryColor,
                      ),
                    ),
                  ),
                ),
                Text(
                  AppStrings.editTask.tr(),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / AppSize.s50,
                ),
                SharedWidget.addTaskFormField(
                  textInputType: TextInputType.name,
                  controller: TextEditingController(),
                  hint: AppStrings.meetingTitle.tr(),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / AppSize.s100,
                ),
                SizedBox(
                  height: AppSize.s120.h,
                  child: SharedWidget.addTaskFormField(
                    textInputType: TextInputType.text,
                    controller: TextEditingController(),
                    hint: AppStrings.meetingDescription.tr(),
                    maxLines: 20,
                    minLines: 20,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / AppSize.s100,
                ),
                SharedWidget.addTaskFormField(
                  textInputType: TextInputType.emailAddress,
                  controller: TextEditingController(),
                  hint: AppStrings.email.tr(),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / AppSize.s100,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SharedWidget.addTaskFormField(
                          textInputType: TextInputType.none,
                          controller: TextEditingController(),
                          hint: AppStrings.date.tr(),
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(
                                const Duration(
                                  days: 1000,
                                ),
                              ),
                            );
                          }),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / AppSize.s18,
                    ),
                    Expanded(
                      child: SharedWidget.addTaskFormField(
                        textInputType: TextInputType.none,
                        controller: TextEditingController(),
                        hint: AppStrings.time.tr(),
                        onTap: () {
                          showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / AppSize.s100,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SharedWidget.addTaskFormField(
                        textInputType: TextInputType.name,
                        controller: TextEditingController(),
                        hint: AppStrings.clientName.tr(),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / AppSize.s18,
                    ),
                    Expanded(
                      child: SharedWidget.addTaskFormField(
                        textInputType: TextInputType.name,
                        controller: TextEditingController(),
                        hint: AppStrings.companyName.tr(),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / AppSize.s100,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SharedWidget.addTaskFormField(
                        textInputType: TextInputType.name,
                        controller: TextEditingController(),
                        hint: AppStrings.address.tr(),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / AppSize.s18,
                    ),
                    Expanded(
                      child: SharedWidget.addTaskFormField(
                        textInputType: TextInputType.name,
                        controller: TextEditingController(),
                        hint: AppStrings.duration,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / AppSize.s100,
                ),
                SizedBox(
                  height: AppSize.s120.h,
                  child: SharedWidget.addTaskFormField(
                    textInputType: TextInputType.text,
                    controller: TextEditingController(),
                    hint: "Task Summary",
                    maxLines: 20,
                    minLines: 20,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / AppSize.s18,
                ),
                SharedWidget.defaultButton(
                  context: context,
                  function: () {},
                  text: AppStrings.submit.tr(),
                  backgroundColor: ColorManager.primaryColor,
                  style: getExtraBoldStyle(
                    fontSize: FontSizeManager.s24.sp,
                    color: ColorManager.white,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / AppSize.s100,
                ),
                SharedWidget.defaultButton(
                  context: context,
                  function: () {
                    Navigator.pop(context);
                  },
                  text: AppStrings.cancel.tr(),
                  backgroundColor: ColorManager.primaryColor,
                  style: getExtraBoldStyle(
                    fontSize: FontSizeManager.s24.sp,
                    color: ColorManager.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
