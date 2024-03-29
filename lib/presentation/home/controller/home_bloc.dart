import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep/app/constant/api_constant.dart';
import 'package:keep/app/services/dio_helper/dio_helper.dart';
import 'package:keep/app/services/shared_prefrences/cache_helper.dart';
import 'package:keep/model/task_model.dart';
import '../../../app/common/widget.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/routes_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/services/calender_helper/calender_helper.dart';
import 'home_states.dart';

class HomeBloc extends Cubit<HomeStates> {
  HomeBloc() : super(HomeInitState());
  static HomeBloc get(context) => BlocProvider.of(context);
  DateTime dateTime = DateTime.now();

  void incressDate() {
    dateTime = dateTime.add(const Duration(days: 1));
    emit(IncressDateState());
  }

  void decressDate() {
    dateTime = dateTime.subtract(const Duration(days: 1));
    emit(DecressDateState());
  }

  Map<int, String> taskState = {};
  void addToDecline(int index) {
    taskState.addAll({index: "decline"});
    emit(ChangeTaskItemState());
  }

  void addToAgree(int index) {
    taskState.addAll({index: "agree"});

    emit(ChangeTaskItemState());
  }

  bool isBottomSheetShown = false;

  void changeBottomSheet({
    required bool isShow,
  }) {
    isBottomSheetShown = isShow;

    emit(ChangeBottomSheetState());
  }

  TaskModel taskModel = TaskModel();
  List<TaskData> taskList = [];
  List<Meeting> meetings = <Meeting>[];
  List<TaskData> notApproveTask = [];
  void getTask({required BuildContext context}) {
    emit(GetTaskLoadingState());
    DioHelper.getData(
        path: ApiConstant.getTaskPath,
        token: CacheHelper.getData(
          key: SharedKey.token,
        )).then(
      (value) {
        taskModel = TaskModel.fromJson(
          value.data,
        );
        taskList = [];
        meetings = [];
        notApproveTask = [];
        for (var element in taskModel.data) {
          if (element.user[0].pivot.status == "approved") {
            if (DateFormat("yyyy-MM-dd")
                    .format(DateTime.parse(element.startDate)) ==
                DateFormat("yyyy-MM-dd").format(dateTime)) {
              taskList.add(element);
            } else if (DateTime.parse(DateFormat("yyyy-MM-dd")
                        .format(DateTime.parse(element.endDate)))
                    .isAfter(DateTime.parse(
                        DateFormat("yyyy-MM-dd").format(dateTime))) &&
                DateTime.parse(DateFormat("yyyy-MM-dd")
                        .format(DateTime.parse(element.startDate)))
                    .isBefore(DateTime.parse(
                        DateFormat("yyyy-MM-dd").format(dateTime)))) {
              taskList = [];
              taskList.add(element);
            }
            meetings.add(Meeting(
                element.title!,
                DateTime.parse(element.startDate),
                DateTime.parse(element.endDate),
                ColorManager.darkGrey,
                false));
          } else if (element.user[0].pivot.status == "not approved") {
            notApproveTask.add(element);
          }
        }
        emit(GetTaskSuccessState());
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
        emit(
          GetTaskErrorState(error.toString()),
        );
      },
    );
  }

  void changeTaskStatus(
      {required int id, required String status, required String summary,required BuildContext context}) {
    emit(ChangeTaskLoadingStatus());
    DioHelper.postData(
      path: ApiConstant.changeTaskStatus(id: id),
      data: {
        "status": status,
        "summary": summary,
      },
      token: CacheHelper.getData(
        key: SharedKey.token,
      ),
    ).then((value) {
      emit(ChangeTaskSuccessStatus());
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
      emit(ChangeTaskErrorState());
    });
  }
}
