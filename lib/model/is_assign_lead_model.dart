class IsAssignedModel {
  IsAssignedDataModel ? data;
  IsAssignedModel();
  IsAssignedModel.fromJson(Map<String, dynamic> json) {
    data = IsAssignedDataModel.fromJson(json["data"]);
  }
}

class IsAssignedDataModel {
  late int id;
  IsAssignedDataModel();
  IsAssignedDataModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
  }
}
