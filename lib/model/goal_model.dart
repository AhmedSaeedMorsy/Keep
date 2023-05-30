class GoalModel {
  late Data data;
  GoalModel();
  GoalModel.fromJson(Map<String, dynamic> json) {
    data = Data.fromJson(json["data"]);
  }
}

class Data {
  late int precentage;
  Data();
  Data.fromJson(Map<String, dynamic> json) {
    precentage = json["percentage"];
  }
}
