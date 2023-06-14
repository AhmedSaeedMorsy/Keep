import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep/app/constant/api_constant.dart';
import 'package:keep/app/services/dio_helper/dio_helper.dart';
import 'package:keep/model/login_model.dart';
import 'package:keep/presentation/login/controller/states.dart';

import '../../../app/common/widget.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/routes_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/services/shared_prefrences/cache_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitState());
  static LoginCubit get(context) => BlocProvider.of(context);
  bool isShownPassword = true;
  Icon suffixPassword = const Icon(Icons.visibility_off);

  void changeVisibilityPassword() {
    isShownPassword = !isShownPassword;

    suffixPassword = isShownPassword
        ? const Icon(Icons.visibility_off)
        : const Icon(Icons.visibility);

    emit(ChangeVisibilityPasswordState());
  }

  LoginModel loginModel = LoginModel();
  void loginUser({
    required String email,
    required String password,
    required BuildContext context,

  }) async {
    emit(LoginLoadingState());
    DioHelper.postData(path: ApiConstant.loginPath, data: {
      "email": email,
      "password": password,
      "fcm_token": await FirebaseMessaging.instance.getToken(),
    }).then(
      (value) {
        loginModel = LoginModel.fromJson(value.data);
        getUserData(token: loginModel.accessToken,context: context);

        emit(LoginSucecessState());
      },
    ).catchError(
      (error) {
        emit(LoginErrorState(error.toString()));
      },
    );
  }

  UserModel userModel = UserModel();
  void getUserData({
    required String token,
    required BuildContext context,
  }) {
    emit(UserLoadingState());
    DioHelper.getData(path: ApiConstant.userPath, token: token).then(
      (value) {
        userModel = UserModel.fromJson(value.data);
        emit(UserSucecessState());
      },
    ).catchError(
      (error) {
        if (error is DioError) {
          if (error.response!.statusCode == 402 ||
              error.response!.statusCode == 401) {
            SharedWidget.toast(
              message: AppStrings.logInAgain.tr(),
              backgroundColor: ColorManager.error,
            );
            CacheHelper.removeData(key: SharedKey.token);
            CacheHelper.removeData(key: SharedKey.qr);
            CacheHelper.removeData(key: SharedKey.id);
            CacheHelper.removeData(key: SharedKey.loginDate);
            CacheHelper.removeData(key: SharedKey.bio);
            CacheHelper.removeData(key: SharedKey.email);
            CacheHelper.removeData(key: SharedKey.name);
            CacheHelper.removeData(key: SharedKey.title);
            CacheHelper.removeData(key: SharedKey.phone);
            Navigator.pushReplacementNamed(
              context,
              Routes.loginRoute,
            );
          }
        }
        emit(UserErrorState(error.toString()));
      },
    );
  }

  // void logOutUser({
  //   required String token,
  // }) {
  //   emit(UserLoadingState());
  //   DioHelper.getData(path: ApiConstant.logOutPath, token: token).then(
  //     (value) {
  //       emit(UserSucecessState());
  //     },
  //   ).catchError(
  //     (error) {
  //       emit(UserErrorState(error.toString()));
  //     },
  //   );
  // }
}
