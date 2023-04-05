class TeamsModel {
  List<TeamData> data = [];
  TeamsModel();
  TeamsModel.fromJson(Map<String, dynamic> json) {
    json["data"].forEach((element) {
      data.add(TeamData.fromJson(element));
    });
  }
}

class TeamData {
  late int id;
  late String name;
  late int companyId;
  TeamData();
  TeamData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    companyId = json["company_id"];
  }
}
