import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep/app/services/dio_helper/dio_helper.dart';
import 'package:keep/presentation/edit_lead/controller/states.dart';
import '../../../app/common/widget.dart';
import '../../../app/constant/api_constant.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/routes_manager.dart';
import '../../../app/resources/strings_manager.dart';
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
    required BuildContext context
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
       if (error is DioError) {
        if (error.response!.statusCode == 401) {
          SharedWidget.toast(
            message: AppStrings.logInAgain.tr(),
            backgroundColor: ColorManager.error,
          );
          CacheHelper.removeData(key: SharedKey.token);
          CacheHelper.removeData(key: SharedKey.qr);
          CacheHelper.removeData(key: SharedKey.id);
          CacheHelper.removeData(key: SharedKey.loginDate);
          CacheHelper.removeData(key: SharedKey.bio);
          CacheHelper.removeData(key: SharedKey.email);
          CacheHelper.removeData(key: SharedKey.name);
          CacheHelper.removeData(key: SharedKey.title);
          CacheHelper.removeData(key: SharedKey.phone);
          Navigator.pushReplacementNamed(
            context,
            Routes.loginRoute,
          );
        }
      }
      emit(EditLeadErrorState());
    });
  }
}
