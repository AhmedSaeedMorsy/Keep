class NotificationModel {
  List<NotificationData> data = [];
  NotificationModel();
  NotificationModel.fromJson(Map<String, dynamic> json) {
    json["data"].forEach((element) {
      data.add(
        NotificationData.fromJson(
          element,
        ),
      );
    });
  }
}

class NotificationData {
  late int id;
  late String title;
  late String body;
  late String createdAt;
  NotificationData();
  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    body = json["body"];
    createdAt = json["created_at"];
  }
}
