
class TaskModel {
  List<TaskData> data = [];
  TaskModel();
  TaskModel.fromJson(Map<String, dynamic> json) {
    json["data"].forEach((element) {
      data.add(TaskData.fromJson(element));
    });
  }
}

class TaskData {
  late int id;
  String? title;
  String? label;
  String? desc;
  late String startDate;
  late String endDate;
  late String clientName;
  late String clientMail;
  late String companyName;
  late String clientLocation;
  late String clientAddress;
  TaskData();
  TaskData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    label = json["label"];
    desc = json["desc"];
    startDate = json["start_date"];
    endDate = json["end_date"];
    clientName = json["client_name"];
    clientMail = json["client_mail"];
    clientAddress = json["client_address"];
    clientLocation = json["client_location"];
    companyName = json["company_name"];
  }
}
