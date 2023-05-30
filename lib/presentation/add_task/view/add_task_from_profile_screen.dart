// ignore_for_file: must_be_immutable, library_prefixes

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as UI;

import '../../../app/common/widget.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/font_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/styles_manager.dart';
import '../../../app/resources/values_manager.dart';
import '../controller/add_task_bloc.dart';
import '../controller/add_task_states.dart';

class AddTaskFromProfile extends StatelessWidget {
  AddTaskFromProfile({
    super.key,
    required this.id,
    required this.date,
  });
  late String date;
  final titleController = TextEditingController();
  final clintNameController = TextEditingController();
  final companyNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final jopTitleController = TextEditingController();
  final clintEmailController = TextEditingController();
  final addressController = TextEditingController();
  final locationController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  final descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  UI.TextDirection direction = UI.TextDirection.ltr;
  final int id;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddTaskBloc(),
      child: BlocConsumer<AddTaskBloc, AddTaskStates>(
        listener: (context, state) {
          if (state is AddTaskSuccessState) {
            SharedWidget.toast(
              message: "The meeting was added successfully",
              backgroundColor: ColorManager.agree,
            );
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Form(
              key: _formKey,
              child: Container(
                color: ColorManager.white,
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / AppSize.s20,
                  right: MediaQuery.of(context).size.width / AppSize.s20,
                  top: MediaQuery.of(context).size.height / AppSize.s26,
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s20,
                      ),
                      Align(
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
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s50,
                      ),
                      Text(
                        AppStrings.addTask.tr(),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s50,
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
                          }),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s100,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SharedWidget.addTaskFormField(
                                textInputType: TextInputType.name,
                                controller: clintNameController,
                                hint: AppStrings.clientName.tr(),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppStrings.thisIsRequired.tr();
                                  }
                                  return null;
                                }),
                          ),
                          SizedBox(
                            width:
                                MediaQuery.of(context).size.width / AppSize.s18,
                          ),
                          Expanded(
                            child: SharedWidget.addTaskFormField(
                                textInputType: TextInputType.name,
                                controller: companyNameController,
                                hint: AppStrings.companyName.tr(),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppStrings.thisIsRequired.tr();
                                  }
                                  return null;
                                }),
                          )
                        ],
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s100,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SharedWidget.addTaskFormField(
                                textInputType: TextInputType.name,
                                controller: jopTitleController,
                                hint: AppStrings.jobTitle.tr(),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppStrings.thisIsRequired.tr();
                                  }
                                  return null;
                                }),
                          ),
                          SizedBox(
                            width:
                                MediaQuery.of(context).size.width / AppSize.s18,
                          ),
                          Expanded(
                            child: SharedWidget.addTaskFormField(
                                textInputType: TextInputType.phone,
                                controller: phoneNumberController,
                                hint: AppStrings.phoneNumber.tr(),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppStrings.thisIsRequired.tr();
                                  }
                                  return null;
                                }),
                          )
                        ],
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
                          }),
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
                          }),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s100,
                      ),
                      SharedWidget.addTaskFormField(
                          textInputType: TextInputType.streetAddress,
                          controller: locationController,
                          hint: AppStrings.location.tr(),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppStrings.thisIsRequired.tr();
                            }
                            return null;
                          }),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s100,
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
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s100,
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
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s100,
                      ),
                      state is AddTaskLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : SharedWidget.defaultButton(
                              context: context,
                              function: () {
                                if (_formKey.currentState!.validate()) {
                                  AddTaskBloc.get(context).addTaskFromProfile(
                                    id: id,
                                    context: context,
                                    startDate:
                                        "$date ${startTimeController.text}",
                                    endDate: "$date ${endTimeController.text}",
                                    title: titleController.text,
                                    label: "null",
                                    desc: descriptionController.text,
                                    clientName: clintNameController.text,
                                    clientMail: clintEmailController.text,
                                    clientTitle: titleController.text,
                                    clientPhone: phoneNumberController.text,
                                    clientAddress: addressController.text,
                                    clientLocation: locationController.text,
                                    companyName: companyNameController.text,
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
                            MediaQuery.of(context).size.height / AppSize.s50,
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
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s18,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget checkboxItem(
      {required BuildContext context,
      required bool checkBoxValue,
      required void Function(bool?)? onChanged}) {
    return Row(
      children: [
        Checkbox(
          value: checkBoxValue,
          onChanged: onChanged,
        ),
        Text(
          AppStrings.shareWithTeam.tr(),
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontSize: FontSizeManager.s14.sp,
                color: ColorManager.darkGrey,
              ),
        )
      ],
    );
  }

  List<Widget> departmentItem(
      {required BuildContext context, required List name}) {
    return List.generate(
      name.length,
      (index) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / AppSize.s80,
        ),
        child: Chip(
          backgroundColor: ColorManager.grey,
          onDeleted: () {},
          label: Text(
            name[index],
            style: Theme.of(context).textTheme.headlineSmall,
          ), //Text
        ),
      ),
    );
  }
}
