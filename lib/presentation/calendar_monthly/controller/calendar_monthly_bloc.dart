import 'package:flutter_bloc/flutter_bloc.dart';

import 'calendar_monthly_states.dart';

class CalendarMonthlyBloc extends Cubit<CalendarMonthlyStates> {
  CalendarMonthlyBloc() : super(CalendarMonthlyInitState());
  static CalendarMonthlyBloc get(context) => BlocProvider.of(context);

  int dateTimeMonth = DateTime.now().month;

  void incressDate() {
    dateTimeMonth = dateTimeMonth + 1;

    emit(IncressDateState());
  }

  void decressDate() {
    dateTimeMonth = dateTimeMonth - 1;
    emit(DecressDateState());
  }
}
