import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/app/common/widget.dart';
import 'package:keep/app/resources/assets_manager.dart';
import 'package:keep/app/resources/color_manager.dart';
import 'package:keep/app/resources/font_manager.dart';
import 'package:keep/app/resources/strings_manager.dart';
import 'package:keep/app/resources/values_manager.dart';

import '../../../app/resources/routes_manager.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: FadeInDown(
                      duration: const Duration(
                        seconds: AppIntDuration.s1,
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width /
                              AppPadding.p12,
                          vertical: MediaQuery.of(context).size.height /
                              AppPadding.p30,
                        ),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              AssetsManager.loginBackground,
                            ),
                          ),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional.bottomStart,
                          child: Text(
                            AppStrings.welcome.tr(),
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: FadeInUp(
                      duration: const Duration(
                        seconds: AppIntDuration.s1,
                      ),
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
                            )),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width /
                                AppPadding.p12,
                            vertical: MediaQuery.of(context).size.height /
                                AppPadding.p30,
                          ),
                          child: Column(
                            children: [
                              Align(
                                alignment: AlignmentDirectional.topStart,
                                child: Text(
                                  AppStrings.login.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width /
                                          AppSize.s25,
                                  vertical: MediaQuery.of(context).size.height /
                                      AppSize.s30,
                                ),
                                child: Column(
                                  children: [
                                    SharedWidget.defaultTextFormField(
                                      textInputType: TextInputType.emailAddress,
                                      controller: emailController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return AppStrings.emailValidation;
                                        }
                                        return null;
                                      },
                                      hint: AppStrings.userName.tr(),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              AppSize.s25,
                                    ),
                                    SharedWidget.defaultTextFormField(
                                      textInputType:
                                          TextInputType.visiblePassword,
                                      controller: passwordController,
                                      suffixIcon: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.visibility_off_outlined,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return AppStrings.passwordValidation;
                                        }
                                        return null;
                                      },
                                      hint: AppStrings.password.tr(),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              AppSize.s50,
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                          AppStrings.forgetPassword.tr(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayLarge!
                                              .copyWith(
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              AppSize.s10,
                                    ),
                                    SharedWidget.defaultButton(
                                      context: context,
                                      function: () {
                                        Navigator.pushNamed(
                                          context,
                                          Routes.layoutRoute,
                                        );
                                      },
                                      text: AppStrings.login.tr(),
                                      backgroundColor:
                                          ColorManager.primaryColor,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge!
                                          .copyWith(
                                            fontSize: FontSizeManager.s22,
                                          ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
