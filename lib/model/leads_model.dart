class LeadsModel {
  List<DataLeadMedel> data = [];
  LeadsModel();
  LeadsModel.fromJson(Map<String, dynamic> json) {
    json["data"].forEach((element) {
      data.add(DataLeadMedel.fromJson(element));
    });
  }
}

class DataLeadMedel {
  late int id;
  String? gender;
  String? name;
  String? email;
  String? phone;
  String? companyName;
  String? position;
  String? industry;
  String? note;
  String? meetingSummary;
  String? custom;
  late String ip;
  String? country;
  String ? city;
  String ? region;
  String? organisation;
  late String latitude;
  late String longitude;
  late String createdAt;
  String? updatedAt;
  DataLeadMedel();
  DataLeadMedel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    gender = json["gender"];
    name = json["name"];
    email = json["email"];
    phone = json["phone"];
    companyName = json["company_name"];
    position = json["position"];
    industry = json["industry"];
    note = json["note"];
    custom = json["custom"];
    meetingSummary = json["meeting_summary"];
    ip = json["ip"];
    country = json["country"];
    city = json["city"];
    region = json["region"];
    organisation = json["organisation"];
    latitude = json["latitude"];
    longitude = json["longitude"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }
}
