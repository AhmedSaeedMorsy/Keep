import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep/app/services/dio_helper/dio_helper.dart';
import 'package:keep/app/services/shared_prefrences/cache_helper.dart';

import '../../../app/common/widget.dart';
import '../../../app/constant/api_constant.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/routes_manager.dart';
import '../../../app/resources/strings_manager.dart';
import 'states.dart';

class UnAssignLeadBloc extends Cubit<UnAssignLeadStates> {
  UnAssignLeadBloc() : super(UnAssignLeadInitState());
  static UnAssignLeadBloc get(context) => BlocProvider.of(context);

  void createAssignedLead({
    required int id,
    required BuildContext context,
    required String name,
    required String email,
    required String gender,
    required String phone,
    required String companyName,
    required String position,
    required String industry,
    required String note,
    required List custom,
  }) {
    emit(UnAssignLeadLoadingState());
    DioHelper.postData(
      path: ApiConstant.createAssignedLeadFromUnAssignedPath(
        id: id,
      ),
      data: {
        "name": name,
        "email": email,
        "phone": phone,
        "gender": gender,
        "company_name": companyName,
        "position": position,
        "industry": industry,
        "note": note,
        "custom": custom,
        "type": "app"
      },
      token: CacheHelper.getData(
        key: SharedKey.token,
      ),
    ).then((value) {
      emit(UnAssignLeadSuccessState());
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
      emit(UnAssignLeadErrorState());
    });
  }

  bool isOpen = false;

  void changeDropDownIcon() {
    isOpen = !isOpen;
    emit(ChangeDropDownIconState());
  }

  String selectedValue = "Male";
  void changeDropDownItem({required String value}) {
    selectedValue = value;

    emit(ChangeDropDownValueState());
  }
}
