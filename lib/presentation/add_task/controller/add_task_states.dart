abstract class AddTaskStates {}

class AddTaskInitState extends AddTaskStates {}

class AddTaskLoadingState extends AddTaskStates {}

class AddTaskSuccessState extends AddTaskStates {}

class AddTaskErrorState extends AddTaskStates {
  final String error;
  AddTaskErrorState(this.error);
}
class ChangeCheckBoxstate extends AddTaskStates {}
