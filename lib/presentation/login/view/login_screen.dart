import 'package:animate_do/animate_do.dart';
import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/app/common/widget.dart';
import 'package:keep/app/resources/assets_manager.dart';
import 'package:keep/app/resources/color_manager.dart';
import 'package:keep/app/resources/font_manager.dart';
import 'package:keep/app/resources/strings_manager.dart';
import 'package:keep/app/resources/values_manager.dart';
import 'package:keep/app/services/shared_prefrences/cache_helper.dart';
import 'package:keep/presentation/login/controller/bloc.dart';
import 'package:keep/presentation/login/controller/states.dart';
import '../../../app/resources/routes_manager.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryColor,
      body: BlocProvider(
          create: (context) => LoginCubit(),
          child: BlocConsumer<LoginCubit, LoginStates>(
            listener: (context, state) {
              if (state is LoginErrorState) {
                SharedWidget.toast(
                  message: AppStrings.emailOrPasswordInCorrect.tr(),
                  backgroundColor: ColorManager.error,
                );
              }
              if (state is UserSucecessState) {
                CacheHelper.setData(
                  key: SharedKey.token,
                  value: LoginCubit.get(context).loginModel.accessToken,
                );
                CacheHelper.setData(
                    key: SharedKey.qr,
                    value: LoginCubit.get(context).userModel.data.qr);

                CacheHelper.setData(
                  key: SharedKey.loginDate,
                  value: DateTime.now().toString(),
                );
                CacheHelper.setData(
                    key: SharedKey.id,
                    value: LoginCubit.get(context).userModel.data.id);
                Navigator.pushReplacementNamed(
                  context,
                  Routes.layoutRoute,
                );
              }
            },
            builder: (context, state) {
              return CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: FadeInDown(
                              duration: const Duration(
                                milliseconds: AppIntDuration.duration500,
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width /
                                          AppPadding.p20,
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(
                                          color: ColorManager.white,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: FadeInUp(
                              duration: const Duration(
                                milliseconds: AppIntDuration.duration500,
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
                                    horizontal:
                                        MediaQuery.of(context).size.width /
                                            AppPadding.p12,
                                    vertical:
                                        MediaQuery.of(context).size.height /
                                            AppPadding.p30,
                                  ),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional.topStart,
                                        child: Text(
                                          AppStrings.login.tr(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              AppSize.s25,
                                          vertical: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              AppSize.s30,
                                        ),
                                        child: Column(
                                          children: [
                                            SharedWidget.defaultTextFormField(
                                              textInputType:
                                                  TextInputType.emailAddress,
                                              controller: emailController,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return AppStrings
                                                      .emailValidation
                                                      .tr();
                                                }
                                                return null;
                                              },
                                              hint: AppStrings.userName.tr(),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  AppSize.s25,
                                            ),
                                            SharedWidget.defaultTextFormField(
                                              textInputType:
                                                  TextInputType.visiblePassword,
                                              controller: passwordController,
                                              suffixIcon: IconButton(
                                                onPressed: () {
                                                  LoginCubit.get(context)
                                                      .changeVisibilityPassword();
                                                },
                                                icon: LoginCubit.get(context)
                                                    .suffixPassword,
                                              ),
                                              obscure: LoginCubit.get(context)
                                                  .isShownPassword,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return AppStrings
                                                      .passwordValidation
                                                      .tr();
                                                }
                                                return null;
                                              },
                                              hint: AppStrings.password.tr(),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                  context,
                                                  Routes.forgetPasswordRoute,
                                                );
                                              },
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Text(
                                                  AppStrings.forgetPassword
                                                      .tr(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayLarge!
                                                      .copyWith(
                                                        fontSize:
                                                            FontSizeManager
                                                                .s14.sp,
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  AppSize.s10,
                                            ),
                                            ConditionalBuilderRec(
                                              builder: (BuildContext context) =>
                                                  const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                              condition:
                                                  state is LoginLoadingState,
                                              fallback: (context) =>
                                                  SharedWidget.defaultButton(
                                                context: context,
                                                function: () {
                                                  if (formKey.currentState!
                                                      .validate()) {
                                                    LoginCubit.get(context)
                                                        .loginUser(
                                                      email:
                                                          emailController.text,
                                                      password:
                                                          passwordController
                                                              .text,
                                                      context: context,
                                                    );
                                                  }
                                                },
                                                text: AppStrings.login.tr(),
                                                backgroundColor:
                                                    ColorManager.lightGrey,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineLarge!
                                                    .copyWith(
                                                      fontSize: FontSizeManager
                                                          .s18.sp,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          )),
    );
  }
}
