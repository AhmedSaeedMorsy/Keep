// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/app/common/widget.dart';
import 'package:keep/app/resources/color_manager.dart';
import 'package:keep/app/resources/values_manager.dart';
import 'package:keep/presentation/home/view/home_screen.dart';
import 'package:keep/presentation/layout/controller/layout_bloc.dart';
import 'package:keep/presentation/layout/view/layout_screen.dart';
import '../../../app/resources/font_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/styles_manager.dart';
import '../../select_member_in_teams/view/select_member_in_teams_screen.dart';

class AddTask extends StatelessWidget {
  AddTask({super.key});
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Container(
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
            Text(
              AppStrings.addTask.tr(),
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
                    hint: AppStrings.jobTitle.tr(),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / AppSize.s18,
                ),
                Expanded(
                  child: SharedWidget.addTaskFormField(
                    textInputType: TextInputType.name,
                    controller: TextEditingController(),
                    hint: AppStrings.phoneNumber.tr(),
                  ),
                )
              ],
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
            SharedWidget.addTaskFormField(
              textInputType: TextInputType.streetAddress,
              controller: TextEditingController(),
              hint: AppStrings.address.tr(),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / AppSize.s100,
            ),
            SharedWidget.addTaskFormField(
              textInputType: TextInputType.streetAddress,
              controller: TextEditingController(),
              hint: AppStrings.location.tr(),
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
                    hint: AppStrings.startTime.tr(),
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
                    textInputType: TextInputType.none,
                    controller: TextEditingController(),
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
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / AppSize.s18,
                ),
                Expanded(
                  child: SharedWidget.addTaskFormField(
                    textInputType: TextInputType.none,
                    controller: TextEditingController(),
                    hint: AppStrings.endTime.tr(),
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
            checkboxItem(
              context: context,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / AppSize.s100,
            ),
            Wrap(
              children: departmentItem(context: context, name: name),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / AppSize.s100,
            ),
            SharedWidget.defaultButton(
              context: context,
              function: () {
                screen = const SelectMemberInTeamsScreen();
                LayoutBloc.get(context).changeBottomNavBar(0);
              },
              text: AppStrings.submit.tr(),
              backgroundColor: ColorManager.white,
              style: getExtraBoldStyle(
                fontSize: FontSizeManager.s24.sp,
                color: ColorManager.primaryColor,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / AppSize.s50,
            ),
            SharedWidget.defaultButton(
              context: context,
              function: () {
                screen = HomeScreen();
                LayoutBloc.get(context).changeBottomNavBar(0);
              },
              text: AppStrings.cancel.tr(),
              backgroundColor: ColorManager.white,
              style: getExtraBoldStyle(
                fontSize: FontSizeManager.s24.sp,
                color: ColorManager.primaryColor,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / AppSize.s18,
            ),
          ],
        ),
      ),
    );
  }

  Widget checkboxItem({
    required BuildContext context,
  }) {
    return Row(
      children: [
        Checkbox(
          value: false,
          onChanged: (value) {},
        ),
        Text(
          AppStrings.shareWithTeam.tr(),
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontSize: FontSizeManager.s16.sp,
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

List<String> name = [
  "sd;vhksd",
  "jdwshn",
  "mkdhc",
  "ww",
  "Wjw",
  "doje",
  "a",
  ";nkjdshu hwejfwbjhgfkush",
  "jdaldkhfnsekjdvhksdfwjedvih",
  "sd;vhksd",
  "jdwshn",
  "mkdhc",
  "ادارة المالية والموارد الشريه",
  "ww",
  "jdaldkhfnsekjdvhksdfwjedvihjdaldk hfnsekjdvhksdfwjedvihjdaldkhfnsekjdvhksdfwjedvihjda ldkhfnsekjdvhksdfwjedvih"
      "Wjw",
  "doje",
  "a",
];
