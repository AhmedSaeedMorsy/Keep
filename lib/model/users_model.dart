import 'package:keep/model/profile_model.dart';

class UsersModel {
  List<UserData> users = [];
  UsersModel();
  UsersModel.fromJson(Map<String, dynamic> json) {
    json["users"].forEach((element) {
      users.add(UserData.fromJson(element));
    });
  }
}
