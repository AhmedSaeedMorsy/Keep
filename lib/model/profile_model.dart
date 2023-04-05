class ProfileModel {
  late UserData user;
  List<SocialDate> social = [];
  ProfileModel();
  ProfileModel.fromJson(Map<String, dynamic> json) {
    user = UserData.fromJson(json["user"]);
    json["social"].forEach((element) {
      social.add(SocialDate.fromJson(element));
    });
  }
}

class UserData {
  late int id;
  late String name;
  late String email;
  String? title;
  String? phone;
  late String qr;
  String? profile;
  String? cover;
  late int companyId;
  UserData();
  UserData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    email = json["email"];
    title = json["title"];
    phone = json["phone"];
    profile = json["profile"];
    cover = json["cover"];
    qr = json["qr"];
    companyId = json["company_id"];
  }
}

class SocialDate {
  late int id;
  late String name;
  late String link;
  SocialDate();
  SocialDate.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    link = json["link"];
  }
}
