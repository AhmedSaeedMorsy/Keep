import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep/app/constant/api_constant.dart';
import 'package:keep/app/services/dio_helper/dio_helper.dart';
import 'package:keep/model/add_task_model.dart';
import 'package:keep/presentation/add_task/controller/add_task_states.dart';

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
      print(addTaskModel.data.id);
      emit(AddTaskSuccessState());
    }).catchError((error) {
      emit(AddTaskErrorState(error.toString()));
    });
  }
}
