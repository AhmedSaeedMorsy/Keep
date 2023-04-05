class KitsModel {
  List<KitData> data = [];
  KitsModel();
  KitsModel.fromJson(Map<String, dynamic> json) {
    json["data"].forEach((element) {
      data.add(KitData.fromJson(element));
    });
  }
}

class KitData {
  late int id;
  late String name;
  late String desc;
  late String path;
  late int companyId;
  KitData();
  KitData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    desc = json["desc"];
    path = json["path"];
    companyId = json["company_id"];
  }
}
