import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep/app/constant/api_constant.dart';
import 'package:keep/app/services/dio_helper/dio_helper.dart';
import 'package:keep/model/task_model.dart';
import '../../../app/resources/color_manager.dart';
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

  double goalValue = 0.249;
  Color getSleekSliderColor(double value) {
    if (value < 0.25) {
      return ColorManager.error;
    } else if (value >= 0.25 && value < 0.75) {
      return ColorManager.orange;
    } else if (value >= 0.75) {
      return ColorManager.agree;
    }
    return ColorManager.primaryColor;
  }

  TaskModel taskModel = TaskModel();
  List<TaskData> taskList = [];

  List<TaskData> taskDaily = [];
  void getTask({
    required String token,
  }) {
    emit(GetTaskLoadingState());
    DioHelper.postData(path: ApiConstant.getTaskPath, token: token)
        .then((value) {
      taskModel = TaskModel.fromJson(
        value.data,
      );
      taskList = [];
      for (var element in taskModel.data) {
        if (DateFormat("yyyy-MM-dd")
                .format(DateTime.parse(element.startDate)) ==
            DateFormat("yyyy-MM-dd").format(dateTime)) {
          taskList.add(element);
        }
      }

      emit(GetTaskSuccessState());
    }).catchError((error) {
      emit(
        GetTaskErrorState(error.toString()),
      );
    });
  }

  // List<TaskData> taskesPerDate({
  //   required DateTime date,
  //   required List<TaskData> list,
  // }) {
  //   List<TaskData> taskList = [];
  //   for (var element in list) {
  //     if (DateTime.parse(element.startDate) == date) {
  //       taskList.add(element);
  //     }
  //   }
  //   print(list);
  //   print(taskList);
  //   return taskList;
  // }
}
