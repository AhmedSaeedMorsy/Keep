import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_states.dart';

class HomeBloc extends Cubit<HomeStates> {
  HomeBloc() : super(HomeInitState());
  static HomeBloc get(context) => BlocProvider.of(context);
  String dateTime = DateFormat.yMMMd().format(DateTime.now());
  void incressDate() {
    emit(IncressDateState());
  }

  void decressDate() {
    emit(DecressDateState());
  }
}
