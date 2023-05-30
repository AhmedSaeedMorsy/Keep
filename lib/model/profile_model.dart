class ProfileModel {
  UserData? user;
  List<SocialDate> social = [];
  List<Forms> form = [];
  List<CompanyModel> company = [];
  ProfileModel();
  ProfileModel.fromJson(Map<String, dynamic> json) {
    user = UserData.fromJson(json["user"]);
    json["social"].forEach((element) {
      social.add(SocialDate.fromJson(element));
    });
    json["form"].forEach((element) {
      form.add(Forms.fromJson(element));
    });
    json["company"].forEach((element) {
      company.add(CompanyModel.fromJson(element));
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
  int? calendar;
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
    calendar = json["calendar"];
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

class Forms {
  late String inputs;
  Forms();
  Forms.fromJson(Map<String, dynamic> json) {
    inputs = json["inputs"];
  }
}

class CompanyModel {
  late int id;
  String? website;
  String? logo;
  CompanyModel();
  CompanyModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    website = json["website"];
    logo = json["logo"];
  }
}
