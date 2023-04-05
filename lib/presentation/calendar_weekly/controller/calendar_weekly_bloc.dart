import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/constant/api_constant.dart';
import '../../../app/services/dio_helper/dio_helper.dart';
import '../../../model/task_model.dart';
import 'calendar_weekly_states.dart';

class CalendarWeeklyBloc extends Cubit<CalendarWeeklyStates> {
  CalendarWeeklyBloc() : super(CalendarWeeklyInitState());
  static CalendarWeeklyBloc get(context) => BlocProvider.of(context);

  TaskModel taskModel = TaskModel();

  void getTask({
    required String token,
  }) {
    emit(GetTaskLoadingState());
    DioHelper.getData(path: ApiConstant.getTaskPath, token: token)
        .then((value) {
      taskModel = TaskModel.fromJson(
        value.data,
      );
      emit(GetTaskSuccessState());
    }).catchError((error) {
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
