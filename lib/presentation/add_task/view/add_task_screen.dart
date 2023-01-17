// ignore_for_file: must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/app/common/widget.dart';
import 'package:keep/app/resources/color_manager.dart';
import 'package:keep/app/resources/values_manager.dart';
import 'package:keep/presentation/home/view/home_screen.dart';
import 'package:keep/presentation/layout/controller/layout_bloc.dart';
import 'package:keep/presentation/layout/view/layout_screen.dart';
import '../../../app/resources/assets_manager.dart';
import '../../../app/resources/font_manager.dart';
import '../../../app/resources/language_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/styles_manager.dart';
import '../../../app/services/shared_prefrences/cache_helper.dart';

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
    return FadeInDown(
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
              dropDownItem(
                context: context,
                title: AppStrings.department.tr(),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / AppSize.s30,
              ),
              dropDownItem(
                context: context,
                title: AppStrings.team.tr(),
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
                  fontSize: FontSizeManager.s26.sp,
                  color: ColorManager.white,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / AppSize.s18,
              ),
              SharedWidget.defaultButton(
                context: context,
                function: () {
                  screen = HomeScreen();
                  LayoutBloc.get(context).changeBottomNavBar(0);
                },
                text: AppStrings.cancel.tr(),
                backgroundColor: ColorManager.primaryColor,
                style: getExtraBoldStyle(
                  fontSize: FontSizeManager.s26.sp,
                  color: ColorManager.white,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / AppSize.s18,
              ),
            ],
          ),
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
                fontSize: FontSizeManager.s18.sp,
                color: ColorManager.grey,
              ),
        )
      ],
    );
  }

  Widget dropDownItem({
    required BuildContext context,
    required String title,
  }) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        iconOnClick: Image(
          image: const AssetImage(
            AssetsManager.arrowUp,
          ),
          width: AppSize.s16.w,
          height: AppSize.s16.h,
        ),
        isExpanded: true,
        hint: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: ColorManager.primaryColor,
                      fontSize: FontSizeManager.s22.sp,
                    ),
              ),
            ),
          ],
        ),
        items: items
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            )
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          // setState(() {
          //   selectedValue = value as String;
          // });
        },
        icon: Image(
          image: const AssetImage(
            AssetsManager.arrowDown,
          ),
          width: AppSize.s16.w,
          height: AppSize.s16.h,
        ),
        buttonHeight: AppSize.s40.h,
        buttonWidth: double.infinity,
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AppSize.s55.w,
          ),
          border: Border.all(),
          color: ColorManager.grey,
        ),
        buttonPadding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / AppSize.s22,
        ),
        itemHeight: AppSize.s30.h,
        dropdownMaxHeight: AppSize.s150.h,
        dropdownWidth: MediaQuery.of(context).size.width / AppSize.s1_3,
        scrollbarRadius: Radius.circular(
          AppSize.s10.w,
        ),
        dropdownDecoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(
              AppSize.s20.w,
            ),
            bottomRight: Radius.circular(
              AppSize.s20.w,
            ),
          ),
          color: ColorManager.white,
          boxShadow: const [],
        ),
        scrollbarThickness: AppSize.s8.w,
        offset: CacheHelper.getData(key: SharedKey.Language) ==
                LanguageType.ENGLISH.getValue()
            ? Offset(AppSize.s20.h, 0)
            : Offset(-AppSize.s20.w, 0),
      ),
    );
  }
}
