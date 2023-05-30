// ignore_for_file: must_be_immutable, unnecessary_null_comparison, library_prefixes

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/app/constant/enums_extentions.dart';
import 'package:keep/presentation/un_assign_lead/controller/bloc.dart';
import 'package:keep/presentation/un_assign_lead/controller/states.dart';

import '../../../app/common/widget.dart';
import '../../../app/resources/assets_manager.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/font_manager.dart';
import '../../../app/resources/language_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/values_manager.dart';
import '../../../app/services/shared_prefrences/cache_helper.dart';
import 'dart:ui' as UI;

class CreateLeadScreen extends StatelessWidget {
  CreateLeadScreen(
      {super.key, required this.name, required this.form, required this.id});
  UI.TextDirection direction = UI.TextDirection.ltr;
  late int id;
  final String name;
  String? genderValue;
  final formKey = GlobalKey<FormState>();
  List<Map<String, TextEditingController>> myControllerList = [];
  List form = [];
  List<String> gender = ["Male", "Female"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height / AppSize.s100,
            horizontal: MediaQuery.of(context).size.width / AppSize.s20,
          ),
          child: BlocProvider(
              create: (context) => UnAssignLeadBloc(),
              child: BlocConsumer<UnAssignLeadBloc, UnAssignLeadStates>(
                listener: (context, state) {
                  if (state is UnAssignLeadSuccessState) {
                    SharedWidget.toast(
                      message: AppStrings.done.tr(),
                      backgroundColor: ColorManager.agree,
                    );
                    Navigator.pop(context);
                  }
                },
                builder: (context, state) {
                  for (var element in form) {
                    myControllerList.add(
                      {
                        element["name"]: TextEditingController(),
                      },
                    );
                  }
                  return Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height /
                                AppPadding.p60,
                            left: MediaQuery.of(context).size.width /
                                AppPadding.p20,
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
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.height / AppSize.s20,
                        ),
                        Expanded(
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) =>
                                form[index]["type"] != "checkbox"
                                    ? formTextField(
                                        controller: myControllerList[index]
                                            [form[index]["name"]]!,
                                        hintText: form[index]["name"]
                                            .toString()
                                            .toTitleCase()
                                            .replaceAll("_", " "),
                                        context: context)
                                    : dropDownItem(
                                        context: context,
                                        label: form[index]["name"]
                                            .toString()
                                            .toTitleCase(),
                                      ),
                            separatorBuilder: (context, index) => SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  AppSize.s30,
                            ),
                            itemCount: form.length,
                          ),
                        ),
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.height / AppSize.s30,
                        ),
                        state is UnAssignLeadLoadingState
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : SharedWidget.defaultButton(
                                context: context,
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    UnAssignLeadBloc.get(context)
                                        .createAssignedLead(context: context,
                                      id: id,
                                      name: controllerText("name")!,
                                      email: controllerText("email")!,
                                      phone: controllerText("phone")!,
                                      companyName:
                                          controllerText("company_name")!,
                                      position: controllerText("position")!,
                                      industry: controllerText("industry")!,
                                      note: controllerText("note")!,
                                      custom: getCustomList(context),
                                      gender: UnAssignLeadBloc.get(context)
                                          .selectedValue,
                                    );
                                  }
                                },
                                text: AppStrings.share.tr(),
                                backgroundColor: ColorManager.primaryColor,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                      color: ColorManager.white,
                                    ),
                              ),
                      ],
                    ),
                  );
                },
              )),
        ),
      ),
    );
  }

  String? controllerText(String name) {
    String? text;
    for (var element in myControllerList) {
      if (element.keys.first == name) {
        text = element[name]?.text;
        return text!;
      }
    }
    return null;
  }

  List customList = [];

  void setValuesForCustom(
    String name,
  ) {
    for (var element in customList) {
      if (element["name"] == name) {
        element.addAll({"value": controllerText(name)});
      }
    }
  }

  List getCustomList(context) {
    customList = form;
    for (var item in myControllerList) {
      for (var element in item.keys.toList()) {
        setValuesForCustom(
          element,
        );
      }
    }
    return customList;
  }

  Widget formTextField({
    required TextEditingController controller,
    required String hintText,
    required BuildContext context,
  }) =>
      TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return AppStrings.thisIsRequired.tr();
          }
          return null;
        },
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              AppSize.s8.w,
            ),
            borderSide: BorderSide(
              color: ColorManager.primaryColor,
              width: AppSize.s1.w,
            ),
          ),
          hintText: hintText,
        ),
        style: Theme.of(context).textTheme.displayMedium,
      );

  Widget dropDownItem({required BuildContext context, required String label}) {
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
                label,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: ColorManager.darkGrey,
                      fontSize: FontSizeManager.s16.sp,
                    ),
              ),
            ),
          ],
        ),
        items: gender
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: Theme.of(context).textTheme.headlineSmall!,
                ),
              ),
            )
            .toList(),
        value: UnAssignLeadBloc.get(context).selectedValue,
        onChanged: (value) {
          UnAssignLeadBloc.get(context).changeDropDownItem(value: value!);
        },
        icon: Image(
          image: const AssetImage(
            AssetsManager.arrowDown,
          ),
          width: AppSize.s16.w,
          height: AppSize.s16.h,
        ),
        buttonHeight: AppSize.s40.h,
        buttonWidth: AppSize.s220.w,
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AppSize.s55.w,
          ),
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
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(
              AppSize.s20.w,
            ),
            bottomRight: Radius.circular(
              AppSize.s20.w,
            ),
          ),
          color: ColorManager.white,
        ),
        scrollbarThickness: AppSize.s8.w,
        offset: CacheHelper.getData(key: SharedKey.Language) ==
                    LanguageType.ENGLISH.getValue() ||
                CacheHelper.getData(key: SharedKey.Language) == null
            ? Offset(AppSize.s20.w, 0)
            : Offset(-AppSize.s20.w, 0),
      ),
    );
  }
}
