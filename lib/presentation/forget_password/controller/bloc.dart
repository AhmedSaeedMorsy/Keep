import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep/app/constant/api_constant.dart';
import 'package:keep/app/services/dio_helper/dio_helper.dart';

import 'states.dart';

class ForgetPasswordBloc extends Cubit<ForgetPasswordStates> {
  ForgetPasswordBloc() : super(ForgetPasswordInitState());
  static ForgetPasswordBloc get(context) => BlocProvider.of(context);

  void resetPassword({
    required String email,
  }) {
    emit(ForgetPasswordLoadingState());
    DioHelper.postData(path: ApiConstant.resetPasswordPath, data: {
      "email": email,
    }).then((value) {
      emit(ForgetPasswordSuccessState());
    }).catchError((error) {
      emit(ForgetPasswordErrorState());
    });
  }
}
