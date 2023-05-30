import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/app/constant/enums_extentions.dart';
import 'package:keep/presentation/edit_lead/controller/states.dart';
import 'package:keep/presentation/home/view/home_screen.dart';
import 'package:keep/presentation/lead_layout/controller/bloc.dart';
import '../../../app/common/widget.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/font_manager.dart';
import '../../../app/resources/routes_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/styles_manager.dart';
import '../../../app/resources/values_manager.dart';
import '../../../model/leads_model.dart';
import '../../layout/controller/layout_bloc.dart';
import '../../layout/view/layout_screen.dart';
import '../controller/bloc.dart';

class EditLeadScreen extends StatelessWidget {
  EditLeadScreen({super.key, required this.model});
  final DataLeadMedel model;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final industryController = TextEditingController();
  final genderController = TextEditingController();
  final jobController = TextEditingController();
  final companyController = TextEditingController();
  final addressController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    nameController.text = model.name ?? "";
    emailController.text = model.email ?? "";
    phoneController.text = model.phone ?? "";
    industryController.text = model.industry ?? "".toTitleCase();
    genderController.text = model.gender ?? "".toTitleCase();
    jobController.text = model.position ?? "".toTitleCase();
    companyController.text = model.companyName ?? "".toTitleCase();
    addressController.text =
        "${model.country??"".toTitleCase()} , ${model.city??"".toTitleCase()}";
    noteController.text = model.note ?? "";
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => EditLeadBloc(),
          ),
          BlocProvider(create: (context) => LeadsBloc())
        ],
        child: BlocConsumer<EditLeadBloc, EditLeadsStates>(
          listener: (context, state) {
            if (state is EditLeadSuccessState) {
              screen = HomeScreen();
              LayoutBloc.get(context).changeBottomNavBar(0);
              Navigator.pushNamed(context, Routes.layoutRoute);
            }
          },
          builder: (context, state) {
            return Scaffold(
              body: FadeInDown(
                duration: const Duration(
                  milliseconds: AppIntDuration.duration500,
                ),
                child: Form(
                  key: formKey,
                  child: Container(
                    color: ColorManager.white,
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          MediaQuery.of(context).size.width / AppSize.s16,
                      vertical:
                          MediaQuery.of(context).size.height / AppSize.s12,
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
                            AppStrings.editLead.tr(),
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height /
                                AppSize.s50,
                          ),
                          SharedWidget.addTaskFormField(
                            textInputType: TextInputType.name,
                            controller: nameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppStrings.thisIsRequired.tr();
                              }
                              return null;
                            },
                            hint: AppStrings.name.tr(),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height /
                                AppSize.s100,
                          ),
                          SharedWidget.addTaskFormField(
                            textInputType: TextInputType.emailAddress,
                            controller: emailController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppStrings.thisIsRequired.tr();
                              }
                              return null;
                            },
                            hint: AppStrings.email.tr(),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height /
                                AppSize.s100,
                          ),
                          SharedWidget.addTaskFormField(
                            textInputType: TextInputType.phone,
                            controller: phoneController,
                            hint: AppStrings.phoneNumber.tr(),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppStrings.thisIsRequired.tr();
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height /
                                AppSize.s100,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: SharedWidget.addTaskFormField(
                                  textInputType: TextInputType.none,
                                  controller: industryController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppStrings.thisIsRequired.tr();
                                    }
                                    return null;
                                  },
                                  hint: AppStrings.industry.tr(),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width /
                                    AppSize.s18,
                              ),
                              Expanded(
                                child: SharedWidget.addTaskFormField(
                                  textInputType: TextInputType.text,
                                  controller: genderController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppStrings.thisIsRequired.tr();
                                    }
                                    return null;
                                  },
                                  hint: AppStrings.gender.tr(),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height /
                                AppSize.s100,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: SharedWidget.addTaskFormField(
                                  textInputType: TextInputType.name,
                                  controller: jobController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppStrings.thisIsRequired.tr();
                                    }
                                    return null;
                                  },
                                  hint: AppStrings.jobTitle.tr(),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width /
                                    AppSize.s18,
                              ),
                              Expanded(
                                child: SharedWidget.addTaskFormField(
                                  textInputType: TextInputType.name,
                                  controller: companyController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppStrings.thisIsRequired.tr();
                                    }
                                    return null;
                                  },
                                  hint: AppStrings.companyName.tr(),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height /
                                AppSize.s100,
                          ),
                          SharedWidget.addTaskFormField(
                            textInputType: TextInputType.streetAddress,
                            controller: addressController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppStrings.thisIsRequired.tr();
                              }
                              return null;
                            },
                            hint: AppStrings.address.tr(),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height /
                                AppSize.s100,
                          ),
                          SizedBox(
                            height: AppSize.s120.h,
                            child: SharedWidget.addTaskFormField(
                              textInputType: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return AppStrings.thisIsRequired.tr();
                                }
                                return null;
                              },
                              controller: noteController,
                              hint: AppStrings.meetingSummary.tr(),
                              maxLines: 20,
                              minLines: 20,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height /
                                AppSize.s18,
                          ),
                          state is EditLeadLoadingState
                              ? const Center(child: CircularProgressIndicator())
                              : SharedWidget.defaultButton(
                                  context: context,
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      EditLeadBloc.get(context).editLead(
                                        context: context,
                                        id: model.id,
                                        name: nameController.text,
                                        email: emailController.text,
                                        phone: phoneController.text,
                                        companyName: companyController.text,
                                        position: jobController.text,
                                        industry: industryController.text,
                                        note: noteController.text,
                                        custom: model.custom!,
                                        type: "app",
                                        gender: genderController.text,
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
                            height: MediaQuery.of(context).size.height /
                                AppSize.s100,
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
          },
        ));
  }
}
