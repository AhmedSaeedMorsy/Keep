import 'package:flutter_bloc/flutter_bloc.dart';
import 'insights_states.dart';

class InsightsBloc extends Cubit<InsightsStates> {
  InsightsBloc() : super(InsightsInitState());
  static InsightsBloc get(context) => BlocProvider.of(context);

  bool isBottomSheetShown = false;

  void changeBottomSheet({
    required bool isShow,
  }) {
    isBottomSheetShown = isShow;

    emit(ChangeBottomSheetState());
  }
}
