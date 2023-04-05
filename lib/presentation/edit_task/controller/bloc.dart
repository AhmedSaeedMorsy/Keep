import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep/app/constant/api_constant.dart';
import 'package:keep/app/services/dio_helper/dio_helper.dart';
import 'package:keep/app/services/shared_prefrences/cache_helper.dart';
import 'package:keep/presentation/edit_task/controller/states.dart';


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
         
        }
        emit(EditTaskErrorState());
      },
    );
  }

 
}
