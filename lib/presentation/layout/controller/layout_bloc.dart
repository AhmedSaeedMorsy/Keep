import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep/presentation/layout/controller/layout_states.dart';

class LayoutBloc extends Cubit<LayoutStates> {
  LayoutBloc() : super(LayoutInitState());
  static LayoutBloc get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  void changeBottomNavBar(index) {
    currentIndex = index;
    emit(ChangeBottomNavBarState());
  }
}
