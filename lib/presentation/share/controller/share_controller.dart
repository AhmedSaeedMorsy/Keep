import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep/presentation/share/controller/share_states.dart';

class ShareBloc extends Cubit<ShareStates> {
  ShareBloc() : super(ShareInitState());
  static ShareBloc get(context) => BlocProvider.of(context);
  bool isOpen = false;

  void changeDropDownIcon() {
    isOpen = !isOpen;
    emit(ChangeDropDownIconState());
  }
}
