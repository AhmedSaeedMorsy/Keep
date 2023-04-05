import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep/app/services/dio_helper/dio_helper.dart';
import 'package:keep/presentation/edit_lead/controller/states.dart';
import '../../../app/constant/api_constant.dart';
import '../../../app/services/shared_prefrences/cache_helper.dart';

class EditLeadBloc extends Cubit<EditLeadsStates> {
  EditLeadBloc() : super(EditLeadInitState());
  static EditLeadBloc get(context) => BlocProvider.of(context);
  void editLead({
    required int id,
    required String name,
    required String email,
    required String phone,
    required String companyName,
    required String position,
    required String industry,
    required String note,
    required String custom,
    required String type,
    required String gender,
  }) {
    emit(EditLeadLoadingState());
    DioHelper.postData(
        path: ApiConstant.editLeads(id: id),
        token: CacheHelper.getData(key: SharedKey.token),
        data: {
          "name": name,
          "email": email,
          "phone": phone,
          "company_name": companyName,
          "position": position,
          "industry": industry,
          "note": note,
          "custom": custom,
          "type": type,
          "gender": gender
        }).then((value) {
      emit(EditLeadSuccessState());
    }).catchError((error) {
      emit(EditLeadErrorState());
    });
  }
}
