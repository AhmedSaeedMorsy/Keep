import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep/app/constant/api_constant.dart';
import 'package:keep/app/services/dio_helper/dio_helper.dart';
import 'package:keep/app/services/shared_prefrences/cache_helper.dart';
import 'package:keep/model/notification_model.dart';
import 'package:keep/presentation/notification/controller/states.dart';

import '../../../app/common/widget.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/routes_manager.dart';
import '../../../app/resources/strings_manager.dart';

class NotificationBloc extends Cubit<NotificationStates> {
  NotificationBloc() : super(NotificationInitState());
  static NotificationBloc get(context) => BlocProvider.of(context);
  NotificationModel notificationModel = NotificationModel();
  void getNotification({required BuildContext context}) {
    emit(NotificationLoadingState());
    DioHelper.getData(
            path: ApiConstant.notificationPath,
            token: CacheHelper.getData(key: SharedKey.token))
        .then((value) {
      notificationModel = NotificationModel.fromJson(value.data);
      emit(NotificationSuccessState());
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
      emit(NotificationErrorState());
    });
  }
}
