abstract class CalendarWeeklyStates {}

class CalendarWeeklyInitState extends CalendarWeeklyStates {}

class GetTaskLoadingState extends CalendarWeeklyStates {}

class GetTaskSuccessState extends CalendarWeeklyStates {}

class GetTaskErrorState extends CalendarWeeklyStates {
  final String error;
  GetTaskErrorState(
    this.error,
  );
}
