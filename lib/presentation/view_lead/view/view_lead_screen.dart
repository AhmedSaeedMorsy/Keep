import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/app/constant/enums_extentions.dart';
import '../../../app/common/widget.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/values_manager.dart';
import '../../../model/leads_model.dart';

class ViewLeadScreen extends StatelessWidget {
  ViewLeadScreen({
    super.key,
    required this.model,
  });
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final jobController = TextEditingController();
  final companyController = TextEditingController();
  final addressController = TextEditingController();
  final note = TextEditingController();
  final industryController = TextEditingController();

  final DataLeadMedel model;
  @override
  Widget build(BuildContext context) {
    emailController.text = model.email??"";
    phoneController.text = model.phone??"";
    dateController.text = DateFormat("yyyy-MM-dd")
        .format(DateTime.parse(model.createdAt))
        .toString();
    timeController.text =
        model.createdAt.replaceRange(0, 11, "").replaceRange(8, 16, "");
    jobController.text = model.position??"";
    companyController.text = model.companyName??"";
    addressController.text = "${model.country} , ${model.city}";
    note.text = model.note ?? "";
    industryController.text = model.industry??"";
    return Scaffold(
      body: FadeInDown(
        duration: const Duration(
          milliseconds: AppIntDuration.duration500,
        ),
        child: Container(
          color: ColorManager.white,
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / AppSize.s16,
            vertical: MediaQuery.of(context).size.height / AppSize.s12,
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
                  model.name??"".toTitleCase(),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / AppSize.s50,
                ),
                SharedWidget.addTaskFormField(
                  textInputType: TextInputType.none,
                  controller: emailController,
                  hint: AppStrings.email.tr(),
                  enabled: false,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / AppSize.s100,
                ),
                SharedWidget.addTaskFormField(
                  textInputType: TextInputType.none,
                  controller: phoneController,
                  hint: AppStrings.phoneNumber.tr(),
                  enabled: false,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / AppSize.s100,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SharedWidget.addTaskFormField(
                        textInputType: TextInputType.none,
                        controller: dateController,
                  enabled: false,
                        hint: AppStrings.date.tr(),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / AppSize.s18,
                    ),
                    Expanded(
                      child: SharedWidget.addTaskFormField(
                        textInputType: TextInputType.none,
                        controller: timeController,
                  enabled: false,
                        hint: AppStrings.time.tr(),
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
                        controller: jobController,
                  enabled: false,
                        hint: AppStrings.jobTitle.tr(),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / AppSize.s18,
                    ),
                    Expanded(
                      child: SharedWidget.addTaskFormField(
                        textInputType: TextInputType.none,
                  enabled: false,
                        controller: companyController,
                        hint: AppStrings.companyName.tr(),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / AppSize.s100,
                ),
                SharedWidget.addTaskFormField(
                  textInputType: TextInputType.none,
                  enabled: false,
                  controller: industryController,
                  hint: AppStrings.industry.tr(),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / AppSize.s100,
                ),
                SharedWidget.addTaskFormField(
                  textInputType: TextInputType.none,
                  controller: addressController,
                  enabled: false,
                  hint: AppStrings.address.tr(),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / AppSize.s100,
                ),
                SizedBox(
                  height: AppSize.s120.h,
                  child: SharedWidget.addTaskFormField(
                    textInputType: TextInputType.none,
                    controller: note,
                  enabled: false,
                    hint: AppStrings.meetingSummary.tr(),
                    maxLines: 20,
                    minLines: 20,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / AppSize.s18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
