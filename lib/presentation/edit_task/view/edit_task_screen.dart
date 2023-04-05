// ignore_for_file: must_be_immutable, prefer_final_fields

import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/app/common/widget.dart';
import 'package:keep/app/resources/color_manager.dart';
import 'package:keep/app/resources/values_manager.dart';
import 'package:keep/model/task_model.dart';
import 'package:keep/presentation/edit_task/controller/bloc.dart';
import 'package:keep/presentation/edit_task/controller/states.dart';
import '../../../app/resources/font_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/styles_manager.dart';


class EditTaskScreen extends StatelessWidget {
  EditTaskScreen({
    super.key,
    required this.task,
  });
  final TaskData task;
  final titleController = TextEditingController();
  final clintNameController = TextEditingController();
  final companyNameController = TextEditingController();
  final jopTitleController = TextEditingController();
  final clintEmailController = TextEditingController();
  final addressController = TextEditingController();
  final locationController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  final descriptionController = TextEditingController();
  final summaryController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditTaskBloc(),
      child: BlocConsumer<EditTaskBloc, EditTaskStates>(
          listener: (context, state) {
        if (state is EditTaskSuccessState) {
          Navigator.pop(context);
        }
      }, builder: (context, state) {
       
        titleController.text = task.title ?? "";
        clintNameController.text = task.clientName;
        companyNameController.text = task.companyName;
        jopTitleController.text = task.label ?? "";
        clintEmailController.text = task.clientMail;
        addressController.text = task.clientAddress;
        locationController.text = task.clientLocation;
        startDateController.text =
            DateFormat("yyyy-MM-dd").format(DateTime.parse(task.startDate));
        endDateController.text =
            DateFormat("yyyy-MM-dd").format(DateTime.parse(task.endDate));
        startTimeController.text = task.startDate.replaceRange(0, 11, "");
        endTimeController.text = task.endDate.replaceRange(0, 11, "");
        descriptionController.text = task.desc ?? "";
        summaryController.text = task.summary ?? "";
        return Scaffold(
          body: FadeInDown(
            duration: const Duration(
              milliseconds: AppIntDuration.duration500,
            ),
            child: Form(
              key: _formKey,
              child: Container(
                color: ColorManager.white,
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / AppSize.s16,
                  vertical: MediaQuery.of(context).size.height / AppSize.s22,
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height /
                              AppPadding.p40,
                          bottom: MediaQuery.of(context).size.height /
                              AppPadding.p40,
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
                        height:
                            MediaQuery.of(context).size.height / AppSize.s50,
                      ),
                      Text(
                        AppStrings.meetingTitle.tr(),
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s100,
                      ),
                      SharedWidget.addTaskFormField(
                        textInputType: TextInputType.name,
                        controller: titleController,
                        hint: AppStrings.meetingTitle.tr(),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppStrings.thisIsRequired.tr();
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s100,
                      ),
                      Text(
                        AppStrings.meetingDescription.tr(),
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s100,
                      ),
                      SizedBox(
                        height: AppSize.s120.h,
                        child: SharedWidget.addTaskFormField(
                          textInputType: TextInputType.text,
                          controller: descriptionController,
                          hint: AppStrings.meetingDescription.tr(),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppStrings.thisIsRequired.tr();
                            }
                            return null;
                          },
                          maxLines: 20,
                          minLines: 20,
                        ),
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s100,
                      ),
                      Text(
                        AppStrings.emailAddress.tr(),
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s100,
                      ),
                      SharedWidget.addTaskFormField(
                        textInputType: TextInputType.emailAddress,
                        controller: clintEmailController,
                        hint: AppStrings.email.tr(),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppStrings.thisIsRequired.tr();
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s100,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.startDate.tr(),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height /
                                      AppSize.s100,
                                ),
                                SharedWidget.addTaskFormField(
                                  textInputType: TextInputType.none,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppStrings.thisIsRequired.tr();
                                    }
                                    return null;
                                  },
                                  controller: startDateController,
                                  hint: AppStrings.startDate.tr(),
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
                                    ).then((value) {
                                      startDateController.text =
                                          DateFormat("yyyy-MM-dd")
                                              .format(value!)
                                              .toString();
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width:
                                MediaQuery.of(context).size.width / AppSize.s18,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.startTime.tr(),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height /
                                      AppSize.s100,
                                ),
                                SharedWidget.addTaskFormField(
                                  textInputType: TextInputType.none,
                                  controller: startTimeController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppStrings.thisIsRequired.tr();
                                    }
                                    return null;
                                  },
                                  hint: AppStrings.startTime.tr(),
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      startTimeController.text =
                                          "${value!.hour}:${value.minute}:00";
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s100,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.endTime.tr(),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height /
                                      AppSize.s100,
                                ),
                                SharedWidget.addTaskFormField(
                                  textInputType: TextInputType.none,
                                  controller: endDateController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppStrings.thisIsRequired.tr();
                                    }
                                    return null;
                                  },
                                  hint: AppStrings.endDate.tr(),
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
                                    ).then((value) {
                                      endDateController.text =
                                          DateFormat("yyyy-MM-dd")
                                              .format(value!)
                                              .toString();
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width:
                                MediaQuery.of(context).size.width / AppSize.s18,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.endTime.tr(),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height /
                                      AppSize.s100,
                                ),
                                SharedWidget.addTaskFormField(
                                  textInputType: TextInputType.none,
                                  controller: endTimeController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppStrings.thisIsRequired.tr();
                                    }
                                    return null;
                                  },
                                  hint: AppStrings.endTime.tr(),
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      endTimeController.text =
                                          "${value!.hour}:${value.minute}:00";
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s100,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.clientName.tr(),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height /
                                      AppSize.s100,
                                ),
                                SharedWidget.addTaskFormField(
                                  textInputType: TextInputType.name,
                                  controller: clintNameController,
                                  hint: AppStrings.clientName.tr(),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppStrings.thisIsRequired.tr();
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width:
                                MediaQuery.of(context).size.width / AppSize.s18,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.companyName.tr(),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height /
                                      AppSize.s100,
                                ),
                                SharedWidget.addTaskFormField(
                                  textInputType: TextInputType.name,
                                  controller: companyNameController,
                                  hint: AppStrings.companyName.tr(),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppStrings.thisIsRequired.tr();
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s100,
                      ),
                      Text(
                        AppStrings.location.tr(),
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s100,
                      ),
                      SharedWidget.addTaskFormField(
                        textInputType: TextInputType.none,
                        controller: locationController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppStrings.thisIsRequired.tr();
                          }
                          return null;
                        },
                        hint: AppStrings.location.tr(),
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s100,
                      ),
                      Text(
                        AppStrings.address.tr(),
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s100,
                      ),
                      SharedWidget.addTaskFormField(
                        textInputType: TextInputType.streetAddress,
                        controller: addressController,
                        hint: AppStrings.address.tr(),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppStrings.thisIsRequired.tr();
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s100,
                      ),
                      Text(
                        AppStrings.meetingSummary.tr(),
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s100,
                      ),
                      SizedBox(
                        height: AppSize.s120.h,
                        child: SharedWidget.addTaskFormField(
                          textInputType: TextInputType.text,
                          controller: summaryController,
                          hint: "Task Summary",
                          maxLines: 20,
                          minLines: 20,
                        ),
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s18,
                      ),
                      SharedWidget.defaultButton(
                        context: context,
                        function: () {
                          if (_formKey.currentState!.validate()) {
                            EditTaskBloc.get(context).editTask(
                              context: context,
                              id: task.id,
                              startDate: startDateController.text,
                              endDate: endDateController.text,
                              title: titleController.text,
                              desc: descriptionController.text,
                              clientName: clintNameController.text,
                              clientMail: clintEmailController.text,
                              clientTitle: task.clientTitle!,
                              clientPhone: task.clientPhone!,
                              clientAddress: addressController.text,
                              clientLocation: locationController.text,
                              companyName: companyNameController.text,
                              label: task.label!,
                            );
                          }
                        },
                        text: AppStrings.submit.tr(),
                        backgroundColor: ColorManager.white,
                        style: getExtraBoldStyle(
                          fontSize: FontSizeManager.s20.sp,
                          color: ColorManager.primaryColor,
                        ),
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s100,
                      ),
                      SharedWidget.defaultButton(
                        context: context,
                        function: () {
                          Navigator.pop(context);
                        },
                        text: AppStrings.cancel.tr(),
                        backgroundColor: ColorManager.white,
                        style: getExtraBoldStyle(
                          fontSize: FontSizeManager.s20.sp,
                          color: ColorManager.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
