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
  String? summary;
  late String status;
  late String clientMail;
  late String companyName;
  late String clientLocation;
  late String clientAddress;
  String? clientTitle;
  String? clientPhone;
  List<User> user = [];

  TaskData();
  TaskData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    label = json["label"];
    status = json["status"];
    desc = json["desc"];
    startDate = json["start_date"];
    endDate = json["end_date"];
    clientName = json["client_name"];
    clientMail = json["client_mail"];
    clientAddress = json["client_address"];
    clientLocation = json["client_location"];
    companyName = json["company_name"];
    summary = json["summary"];
    clientTitle = json["client_title"];
    clientPhone = json["client_phone"];
    json["user"].forEach((element) {
      user.add(User.fromJson(element));
    });
  }
}

class User {
  late Pivot pivot;
  User();
  User.fromJson(Map<String, dynamic> json) {
    pivot = Pivot.fromJson(json["pivot"]);
  }
}

class Pivot {
  late String status;
  Pivot();
  Pivot.fromJson(Map<String, dynamic> json) {
    status = json["status"];
  }
}
