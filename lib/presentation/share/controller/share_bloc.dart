// ignore_for_file: unused_local_variable

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep/app/constant/api_constant.dart';
import 'package:keep/app/services/dio_helper/dio_helper.dart';
import 'package:keep/app/services/shared_prefrences/cache_helper.dart';
import 'package:keep/model/teams_model.dart';
import 'package:keep/presentation/share/controller/share_states.dart';

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
  void getTeams() {
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
  void getUsersByTeam({required int id}) {
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
      emit(ShareLeadsErrorState());
    });
  }

  void shareKit({
    required int id,
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
      emit(ShareKitsErrorState());
    });
  }
   void shareMeeting({
    required int id,
  }) {
    emit(ShareMeetingLoadingState());
    DioHelper.getData(
      path:
          ApiConstant.shareMeetingPath(id: id, usersIds: selectedUsers.join(",")),
      token: CacheHelper.getData(
        key: SharedKey.token,
      ),
    ).then((value) {
      print(value.data);
      emit(ShareMeetingSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShareMeetingErrorState());
    });
  }
}
