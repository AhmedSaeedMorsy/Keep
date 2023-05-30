class UsersModel {
  List<DataModel> data = [];
  UsersModel();
  UsersModel.fromJson(Map<String, dynamic> json) {
    json["data"].forEach((element) {
      data.add(DataModel.fromJson(element));
    });
  }
}

class DataModel {
  List<UserDataModel> user = [];
  DataModel();
  DataModel.fromJson(Map<String, dynamic> json) {
    json["user"].forEach((element) {
      user.add(UserDataModel.fromJson(element));
    });
  }
}

class UserDataModel {
  late int id;
  late String name;
  late String email;
  UserDataModel();
  UserDataModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    email = json["email"];
  }
}
