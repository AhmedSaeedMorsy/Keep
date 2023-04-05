abstract class HomeStates {}

class HomeInitState extends HomeStates {}

class IncressDateState extends HomeStates {}

class DecressDateState extends HomeStates {}

class ChangeTaskItemState extends HomeStates {}

class ChangeBottomSheetState extends HomeStates {}

class GetTaskLoadingState extends HomeStates {}

class GetTaskSuccessState extends HomeStates {}

class GetTaskErrorState extends HomeStates {
  final String error;
  GetTaskErrorState(
    this.error,
  );
}

class ChangeTaskLoadingStatus extends HomeStates {}

class ChangeTaskSuccessStatus extends HomeStates {}

class ChangeTaskErrorState extends HomeStates {}
