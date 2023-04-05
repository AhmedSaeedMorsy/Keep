class AddTaskModel {
  late AddTaskData data;
  AddTaskModel();
  AddTaskModel.fromJson(Map<String, dynamic> json) {
    data = AddTaskData.fromJson(json["data"]);
  }
}

class AddTaskData {
  late int id;
  AddTaskData();
  AddTaskData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
  }
}
