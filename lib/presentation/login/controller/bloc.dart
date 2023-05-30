import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep/app/constant/api_constant.dart';
import 'package:keep/app/services/dio_helper/dio_helper.dart';
import 'package:keep/model/login_model.dart';
import 'package:keep/presentation/login/controller/states.dart';

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
  }) async {
    emit(LoginLoadingState());
    DioHelper.postData(path: ApiConstant.loginPath, data: {
      "email": email,
      "password": password,
      "fcm_token": await FirebaseMessaging.instance.getToken(),
    }).then(
      (value) {
        loginModel = LoginModel.fromJson(value.data);
        getUserData(token: loginModel.accessToken);

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
  }) {
    emit(UserLoadingState());
    DioHelper.getData(path: ApiConstant.userPath, token: token).then(
      (value) {
        userModel = UserModel.fromJson(value.data);
        emit(UserSucecessState());
      },
    ).catchError(
      (error) {
        emit(UserErrorState(error.toString()));
      },
    );
  }

  void logOutUser({
    required String token,
  }) {
    emit(UserLoadingState());
    DioHelper.getData(path: ApiConstant.logOutPath, token: token).then(
      (value) {
        emit(UserSucecessState());
      },
    ).catchError(
      (error) {
        emit(UserErrorState(error.toString()));
      },
    );
  }
}
