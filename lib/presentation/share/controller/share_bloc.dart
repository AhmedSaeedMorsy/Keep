// ignore_for_file: unused_local_variable

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep/app/constant/api_constant.dart';
import 'package:keep/app/services/dio_helper/dio_helper.dart';
import 'package:keep/app/services/shared_prefrences/cache_helper.dart';
import 'package:keep/model/teams_model.dart';
import 'package:keep/presentation/share/controller/share_states.dart';

import '../../../app/common/widget.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/routes_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../model/users_model.dart';

class ShareBloc extends Cubit<ShareStates> {
  ShareBloc() : super(ShareInitState());
  static ShareBloc get(context) => BlocProvider.of(context);
  bool isOpen = false;

  void changeDropDownIcon() {
    isOpen = !isOpen;
    emit(ChangeDropDownIconState());
  }

  TeamsModel teamsModel = TeamsModel();
  List<String> teamsNameList = [];
  void getTeams({required BuildContext context}) {
    emit(TeamsLoadingState());
    DioHelper.getData(
            path: ApiConstant.getTeams,
            token: CacheHelper.getData(key: SharedKey.token))
        .then((value) {
      teamsModel = TeamsModel.fromJson(value.data);
      for (var element in teamsModel.data) {
        teamsNameList.add(element.name);
      }
      emit(TeamsSuccessState());
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
      emit(TeamsErrorState());
    });
  }

  String? selectedValue;
  void changeDropDownItem({required String value}) {
    selectedValue = value;
    getUsersByTeam(
      id: getIdTeam()!,
    );
    emit(ChangeDropDownValueState());
  }

  int? getIdTeam() {
    for (var element in teamsModel.data) {
      if (element.name == selectedValue) {
        return element.id;
      }
    }
    return null;
  }

  UsersModel usersModel = UsersModel();
  void getUsersByTeam({
    required int id,
  }) {
    emit(UsersByTeamLoadingState());
    DioHelper.getData(
            path: ApiConstant.getUsersByTeamPath(id: id),
            token: CacheHelper.getData(key: SharedKey.token))
        .then((value) {
      usersModel = UsersModel.fromJson(value.data);
      emit(UsersByTeamSuccessState());
    }).catchError((error) {
      emit(UsersByTeamErrorState());
    });
  }

  bool checkBoxValue = false;
  void changeCheckBoxState({required bool value, required index}) {
    checkBoxValue = value;
    if (value) {
      addToSelected(
        index,
      );
    } else {
      removeFromSelected(index);
    }

    emit(ChangeCheckBoxState());
  }

  List<int> selectedUsers = [];
  void addToSelected(int index) {
    selectedUsers.add(index);
    emit(ChangeSelectedUsersState());
  }

  void removeFromSelected(int index) {
    selectedUsers.remove(index);
    emit(ChangeSelectedUsersState());
  }

  void shareLead({
    required int id,
    required BuildContext context,
  }) {
    emit(ShareLeadsLoadingState());
    DioHelper.getData(
      path:
          ApiConstant.shareLeadsPath(id: id, usersIds: selectedUsers.join(",")),
      token: CacheHelper.getData(
        key: SharedKey.token,
      ),
    ).then((value) {
      emit(ShareLeadsSuccessState());
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
      emit(ShareLeadsErrorState());
    });
  }

  void shareKit({
    required int id,
    required BuildContext context,
  }) {
    emit(ShareKitsLoadingState());
    DioHelper.getData(
      path:
          ApiConstant.shareKitsPath(id: id, usersIds: selectedUsers.join(",")),
      token: CacheHelper.getData(
        key: SharedKey.token,
      ),
    ).then((value) {
      emit(ShareKitsSuccessState());
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
      emit(ShareKitsErrorState());
    });
  }

  void shareMeeting({
    required int id,
    required BuildContext context,
  }) {
    emit(ShareMeetingLoadingState());
    DioHelper.getData(
      path: ApiConstant.shareMeetingPath(
          id: id, usersIds: selectedUsers.join(",")),
      token: CacheHelper.getData(
        key: SharedKey.token,
      ),
    ).then((value) {
      emit(ShareMeetingSuccessState());
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
      emit(ShareMeetingErrorState());
    });
  }
}
