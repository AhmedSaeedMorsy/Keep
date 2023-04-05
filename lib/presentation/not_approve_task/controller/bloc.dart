import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep/app/constant/api_constant.dart';
import 'package:keep/app/services/dio_helper/dio_helper.dart';
import 'package:keep/app/services/shared_prefrences/cache_helper.dart';
import 'package:keep/presentation/not_approve_task/controller/states.dart';

class NotApproveTaskBloc extends Cubit<NotApproveTaskStates> {
  NotApproveTaskBloc() : super(NotApproveTaskInitState());
  static NotApproveTaskBloc get(context) => BlocProvider.of(context);
  void approveTask({required int id}) {
    emit(ApproveTaskLoadingstate());
    DioHelper.getData(
            path: ApiConstant.approveTask(
              id: id,
            ),
            token: CacheHelper.getData(key: SharedKey.token))
        .then((value) {
      emit(ApproveTaskSuccessstate());
    }).catchError((error) {
      emit(ApproveTaskErrorstate());
    });
  }

  void rejectTask({required int id}) {
    emit(RejectTaskLoadingstate());
    DioHelper.getData(
            path: ApiConstant.rejectTask(id: id),
            token: CacheHelper.getData(key: SharedKey.token))
        .then((value) {
      emit(RejectTaskSuccessstate());
    }).catchError((error) {
      emit(RejectTaskErrorstate());
    });
  }
}
