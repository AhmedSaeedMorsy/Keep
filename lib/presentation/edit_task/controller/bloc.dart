import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep/app/constant/api_constant.dart';
import 'package:keep/app/services/dio_helper/dio_helper.dart';
import 'package:keep/app/services/shared_prefrences/cache_helper.dart';
import 'package:keep/presentation/edit_task/controller/states.dart';

import '../../../app/common/widget.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/routes_manager.dart';
import '../../../app/resources/strings_manager.dart';


class EditTaskBloc extends Cubit<EditTaskStates> {
  EditTaskBloc() : super(EditTaskInitState());
  static EditTaskBloc get(context) => BlocProvider.of(context);
  void editTask({
    required int id,
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
    required BuildContext context,
  }) {
    emit(EditTaskLoadingState());
    DioHelper.postData(
      path: ApiConstant.editTask(
        id: id,
      ),
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
      token: CacheHelper.getData(
        key: SharedKey.token,
      ),
    ).then(
      (value) {
        
        emit(EditTaskSuccessState());
      },
    ).catchError(
      (error) {
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
        emit(EditTaskErrorState());
      },
    );
  }

 
}
