// ignore_for_file: deprecated_member_use

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep/app/constant/api_constant.dart';
import 'package:keep/app/services/dio_helper/dio_helper.dart';
import 'package:keep/model/profile_model.dart';
import 'package:keep/presentation/profile/controller/profile_states.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileBloc extends Cubit<ProfileStates> {
  ProfileBloc() : super(ProfileInitState());
  static ProfileBloc get(context) => BlocProvider.of(context);
  ProfileModel profileModel = ProfileModel();
  void getProfile({
    required int id,
  }) {
    emit(ProfileLoadingState());
    DioHelper.getData(path: ApiConstant.getProfilePath(id: id)).then(
      (value) {
        profileModel = ProfileModel.fromJson(value.data);
        emit(ProfileSuccessState());
      },
    ).catchError(
      (error) {
        emit(ProfileErrorState());
      },
    );
  }
   Future<void> openLink({
    required String link,
  }) async {
    String googleUrl =
        link;
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } 
  }
}
