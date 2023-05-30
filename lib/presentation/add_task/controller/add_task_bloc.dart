import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep/app/common/widget.dart';
import 'package:keep/app/constant/api_constant.dart';
import 'package:keep/app/services/dio_helper/dio_helper.dart';
import 'package:keep/model/add_task_model.dart';
import 'package:keep/presentation/add_task/controller/add_task_states.dart';

import '../../../app/resources/color_manager.dart';
import '../../../app/resources/routes_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/services/shared_prefrences/cache_helper.dart';

class AddTaskBloc extends Cubit<AddTaskStates> {
  AddTaskBloc() : super(AddTaskInitState());
  static AddTaskBloc get(context) => BlocProvider.of(context);

  bool checkBoxValue = false;
  void changeCheckBoxstate(bool value) {
    checkBoxValue = value;
    emit(ChangeCheckBoxstate());
  }

  AddTaskModel addTaskModel = AddTaskModel();
  void addTask({
    required String startDate,
    required String endDate,
    required String title,
    required String label,
    required String desc,
    required String clientName,
    required String clientMail,
    required String clientTitle,
    required String clientPhone,
    required String clientAddress,
    required String clientLocation,
    required String companyName,
    required String token,
    required BuildContext context,
  }) {
    emit(AddTaskLoadingState());
    DioHelper.postData(
      path: ApiConstant.addTaskPath,
      token: token,
      data: {
        "start_date": startDate,
        "end_date": endDate,
        "title": title,
        "label": label,
        "desc": desc,
        "client_name": clientName,
        "client_mail": clientMail,
        "client_title": clientTitle,
        "client_phone": clientPhone,
        "client_address": clientAddress,
        "client_location": clientLocation,
        "company_name": companyName,
      },
    ).then((value) {
      addTaskModel = AddTaskModel.fromJson(value.data);
      emit(AddTaskSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        if (error.response!.statusCode == 401) {
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
      emit(AddTaskErrorState(error.toString()));
    });
  }

  void addTaskFromProfile({
    required String startDate,
    required String endDate,
    required String title,
    required String label,
    required String desc,
    required String clientName,
    required String clientMail,
    required String clientTitle,
    required String clientPhone,
    required String clientAddress,
    required String clientLocation,
    required String companyName,
    required int id,
    required BuildContext context,
  }) {
    emit(AddTaskLoadingState());
    DioHelper.postData(
      path: ApiConstant.addTaskInProfilePath(id: id),
      data: {
        "start_date": startDate,
        "end_date": endDate,
        "title": title,
        "label": label,
        "desc": desc,
        "client_name": clientName,
        "client_mail": clientMail,
        "client_title": clientTitle,
        "client_phone": clientPhone,
        "client_address": clientAddress,
        "client_location": clientLocation,
        "company_name": companyName,
      },
    ).then((value) {
      addTaskModel = AddTaskModel.fromJson(value.data);
      emit(AddTaskSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        if (error.response!.statusCode == 401) {
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
      emit(AddTaskErrorState(error.toString()));
    });
  }
}
