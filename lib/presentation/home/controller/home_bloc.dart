import 'package:flutter/animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  Color getSleekSliderColor(double value) {
    if (value < 25) {
      return ColorManager.error;
    } else if (value >= 25 && value < 75) {
      return ColorManager.orange;
    } else if (value >= 75) {
      return ColorManager.agree;
    }
    return ColorManager.primaryColor;
  }
}
