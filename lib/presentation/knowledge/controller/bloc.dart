// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep/app/constant/api_constant.dart';
import 'package:keep/app/services/dio_helper/dio_helper.dart';
import 'package:keep/app/services/shared_prefrences/cache_helper.dart';
import 'package:keep/model/kits_model.dart';
import 'package:keep/presentation/knowledge/controller/states.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class KitsBloc extends Cubit<KitsStates> {
  KitsBloc() : super(KitsInitState());
  static KitsBloc get(context) => BlocProvider.of(context);
  KitsModel kitsModel = KitsModel();
  void getKits() {
    emit(KitsLoadingState());
    DioHelper.getData(
        path: ApiConstant.kitsPath,
        token: CacheHelper.getData(
          key: SharedKey.token,
        )).then((value) {
      kitsModel = KitsModel.fromJson(value.data);
      emit(KitsSuccessState());
    }).catchError((error) {
      emit(KitsErrorState());
    });
  }

  Future openFile({
    required String url,
  }) async {
    final file = await downloadFile(
      url,
    );
    if (file == null) return;
    OpenFile.open(file.path);
  }

  Future<File?> downloadFile(
    String url,
  ) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File("${appStorage.path}/name");
    try {
      final response = await Dio().get(
        url,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            receiveTimeout: 0),
      );
      final raf = file.openSync(mode: FileMode.write);
      await raf.close();
      return file;
    } catch (error) {
      return null;
    }
  }
}
