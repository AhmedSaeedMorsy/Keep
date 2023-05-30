// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep/app/constant/api_constant.dart';
import 'package:keep/app/services/dio_helper/dio_helper.dart';
import 'package:keep/app/services/shared_prefrences/cache_helper.dart';
import 'package:keep/model/kits_model.dart';
import 'package:keep/presentation/knowledge/controller/states.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../../../app/common/widget.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/routes_manager.dart';
import '../../../app/resources/strings_manager.dart';

class KitsBloc extends Cubit<KitsStates> {
  KitsBloc() : super(KitsInitState());
  static KitsBloc get(context) => BlocProvider.of(context);
  KitsModel kitsModel = KitsModel();
  void getKits({required BuildContext context}) {
    emit(KitsLoadingState());
    DioHelper.getData(
        path: ApiConstant.kitsPath,
        token: CacheHelper.getData(
          key: SharedKey.token,
        )).then((value) {
      kitsModel = KitsModel.fromJson(value.data);
      emit(KitsSuccessState());
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
      emit(KitsErrorState());
    });
  }

  Future openFile({
    required String url,
    String? fileName,
  }) async {
    final name = fileName ?? url.split("/").last;
    final file = await downloadFile(
      url,
      name,
    );
    if (file == null) return;
    OpenFile.open(file.path);
  }

  Future<File?> downloadFile(
    String url,
    String name,
  ) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File("${appStorage.path}/$name");
    try {
      final response = await Dio().get(
        url,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            receiveTimeout: 0),
      );
      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      return file;
    } catch (error) {
      return null;
    }
  }
}
