import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/common/widget.dart';
import '../../../app/constant/api_constant.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/routes_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/services/dio_helper/dio_helper.dart';
import '../../../app/services/shared_prefrences/cache_helper.dart';
import '../../../model/task_model.dart';
import 'calendar_weekly_states.dart';

class CalendarWeeklyBloc extends Cubit<CalendarWeeklyStates> {
  CalendarWeeklyBloc() : super(CalendarWeeklyInitState());
  static CalendarWeeklyBloc get(context) => BlocProvider.of(context);

  TaskModel taskModel = TaskModel();

  void getTask({
    required String token,required BuildContext context
  }) {
    emit(GetTaskLoadingState());
    DioHelper.getData(path: ApiConstant.getTaskPath, token: token)
        .then((value) {
      taskModel = TaskModel.fromJson(
        value.data,
      );
      emit(GetTaskSuccessState());
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
      emit(
        GetTaskErrorState(error.toString()),
      );
    });
  }

  List<TaskData> getTaskPerDate({required DateTime dateTime}) {
    List<TaskData> listTask = [];
    for (var element in taskModel.data) {
      if (DateFormat("yyyy-MM-dd").format(DateTime.parse(element.startDate)) ==
          DateFormat("yyyy-MM-dd").format(dateTime)) {
        listTask.add(element);
      }
    }
    return listTask;
  }
}
