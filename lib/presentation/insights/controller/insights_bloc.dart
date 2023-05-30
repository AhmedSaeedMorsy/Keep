import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep/app/constant/api_constant.dart';
import 'package:keep/app/services/dio_helper/dio_helper.dart';
import 'package:keep/app/services/shared_prefrences/cache_helper.dart';
import '../../../app/common/widget.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/routes_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../model/goal_model.dart';
import '../../../model/insights_connects_model.dart';
import '../../../model/insights_kits_model.dart';
import '../../../model/insights_visits_model.dart';
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

  double goalValue = 0;
  Color getSleekSliderColor(double value) {
    if (value < 0.25) {
      return ColorManager.error;
    } else if (value >= 0.25 && value < 0.75) {
      return ColorManager.orange;
    } else if (value >= 0.75) {
      return ColorManager.agree;
    }
    return ColorManager.primaryColor;
  }

  InsightsConnectsModel insightsConnectsModel = InsightsConnectsModel();
  void getInsightsConnects({required BuildContext context}) {
    emit(InsightsConnectsLoadingState());
    DioHelper.getData(
      path: ApiConstant.insightsConnectsPath,
      token: CacheHelper.getData(
        key: SharedKey.token,
      ),
    ).then((value) {
      insightsConnectsModel = InsightsConnectsModel.formJson(value.data);
      emit(InsightsConnectsSuccessState());
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
      emit(InsightsConnectsErrorState());
    });
  }

  InsightsVisitsModel insightsVisitsModel = InsightsVisitsModel();
  void getInsightsVisits({required BuildContext context}) {
    emit(InsightsVisitsLoadingState());
    DioHelper.getData(
      path: ApiConstant.insightsVisitsPath,
      token: CacheHelper.getData(
        key: SharedKey.token,
      ),
    ).then((value) {
      insightsVisitsModel = InsightsVisitsModel.formJson(value.data);
      emit(InsightsVisitsSuccessState());
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
      emit(InsightsVisitsErrorState());
    });
  }

  InsightsKitsModel insightsKitsModel = InsightsKitsModel();
  void getInsightsKits({required BuildContext context}) {
    emit(InsightsKitsLoadingState());
    DioHelper.getData(
      path: ApiConstant.insightsKitsPath,
      token: CacheHelper.getData(
        key: SharedKey.token,
      ),
    ).then((value) {
      insightsKitsModel = InsightsKitsModel.formJson(value.data);

      emit(InsightsKitsSuccessState());
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
      emit(InsightsKitsErrorState());
    });
  }

  GoalModel goalModel = GoalModel();
  void getGoal({required BuildContext context}) {
    emit(GoalLoadingState());
    DioHelper.getData(
        path: ApiConstant.goalPath,
        token: CacheHelper.getData(
          key: SharedKey.token,
        )).then((value) {
      goalModel = GoalModel.fromJson(value.data);
      goalValue = goalModel.data.precentage / 100;
      emit(GoalSuccessState());
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
      emit(GoalErrorState());
    });
  }
}
