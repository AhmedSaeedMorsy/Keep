class LoginModel {
  late String accessToken;
  LoginModel();
  LoginModel.fromJson(Map<String, dynamic> json) {
    accessToken = json["access_token"];
  }
}

class UserModel {
  late String status;
  UserDataModel data = UserDataModel();
  UserModel();
  UserModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    data = UserDataModel.fromJson(json["data"]);
  }
}

class UserDataModel {
  late int id;
  late String name;
  late String email;
  String ? title;
  String? bio;
  late String phone;
  late String qr;
  String? imageProfile;
  String? imageCover;
  late int companyId;
  String? stripeId;
  String? pmType;
  String? pmLastFour;
  String? trialEndsAt;
  UserDataModel();
  UserDataModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    email = json["email"];
    title = json["title"];
    bio = json["bio"];
    phone = json["phone"];
    qr = json["qr"];
    imageProfile = json["profile"];
    imageCover = json["cover"];
    companyId = json["company_id"];
    stripeId = json["stripe_id"];
    pmType = json["pm_type"];
    pmLastFour = json["pm_last_four"];
    trialEndsAt = json["trial_ends_at"];
  }
}
