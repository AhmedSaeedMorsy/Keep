import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep/app/constant/api_constant.dart';
import 'package:keep/app/services/dio_helper/dio_helper.dart';
import 'package:keep/app/services/shared_prefrences/cache_helper.dart';
import 'package:keep/presentation/lead_layout/controller/states.dart';
import '../../../app/common/widget.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/routes_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../model/leads_model.dart';

class LeadsBloc extends Cubit<LeadsStates> {
  LeadsBloc() : super(LeadsInitState());
  static LeadsBloc get(context) => BlocProvider.of(context);
  LeadsModel leadsModel = LeadsModel();
  List<DataLeadMedel> allAsignedLeads = [];
  List<DataLeadMedel> todayLeads = [];
  List<DataLeadMedel> notAsignedLeads = [];
  List<DataLeadMedel> yasterdayLeads = [];
  List<DataLeadMedel> thisWeekLeads = [];
  List<DataLeadMedel> thisMonthLeads = [];

  void getLeads({required BuildContext context}) {
    emit(LeadsLoadingState());
    DioHelper.getData(
      path: ApiConstant.getLeads,
      token: CacheHelper.getData(
        key: SharedKey.token,
      ),
    ).then((value) {
      leadsModel = LeadsModel.fromJson(value.data);
      for (var element in leadsModel.data) {
        if (element.name == null) {
          notAsignedLeads.add(element);
        } else {
          allAsignedLeads.add(element);
          if (DateTime.parse(element.createdAt)
                  .difference(DateTime.now())
                  .inDays ==
              0) {
            todayLeads.add(element);
          }

          if (DateTime.parse(element.createdAt)
                  .difference(DateTime.now())
                  .inDays ==
              1) {
                
            yasterdayLeads.add(element);
          }
          if (DateTime.parse(element.createdAt)
                  .difference(DateTime.now())
                  .inDays <
              7) {
            thisWeekLeads.add(element);
          }
          if (DateTime.parse(element.createdAt)
                  .difference(DateTime.now())
                  .inDays <
              30) {
            thisMonthLeads.add(element);
          }
        }
      }
      emit(LeadsSuccessState());
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
      emit(LeadsErrorState());
    });
  }
}
