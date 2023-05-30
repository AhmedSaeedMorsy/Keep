import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/app/common/widget.dart';
import 'package:keep/app/resources/strings_manager.dart';
import 'package:keep/app/resources/values_manager.dart';
import 'package:keep/presentation/forget_password/controller/bloc.dart';
import 'package:keep/presentation/forget_password/controller/states.dart';

import '../../../app/resources/color_manager.dart';
import '../../../app/resources/font_manager.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordBloc(),
      child: BlocConsumer<ForgetPasswordBloc, ForgetPasswordStates>(
        listener: (context, state) {
          if (state is ForgetPasswordSuccessState) {
            SharedWidget.toast(
              message: AppStrings.checkYourInboxMail.tr(),
              backgroundColor: ColorManager.agree,
            );
            Navigator.pop(context);
          } else if (state is ForgetPasswordErrorState) {
            SharedWidget.toast(
              message:
                  AppStrings.emailIsIncorrectPleaseEnterYourEmailAgain.tr(),
              backgroundColor: ColorManager.error,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                AppStrings.resetPassword.tr(),
              ),
              elevation: AppSize.s0,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height / AppSize.s60,
                horizontal: MediaQuery.of(context).size.width / AppSize.s20,
              ),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s10,
                      ),
                      SharedWidget.defaultTextFormField(
                        controller: emailController,
                        textInputType: TextInputType.emailAddress,
                        hint: AppStrings.email.tr(),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return AppStrings.emailValidation.tr();
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s50,
                      ),
                      state is ForgetPasswordLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : SharedWidget.defaultButton(
                              context: context,
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  ForgetPasswordBloc.get(context).resetPassword(
                                    email: emailController.text,
                                  );
                                }
                              },
                              text: AppStrings.send.tr(),
                              backgroundColor: ColorManager.lightGrey,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(
                                    fontSize: FontSizeManager.s18.sp,
                                  ),
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
}
