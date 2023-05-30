class InsightsVisitsModel {
  List<InsightsVisitsData> data = [];
  InsightsVisitsModel();
  InsightsVisitsModel.formJson(Map<String, dynamic> json) {
    json["data"].forEach((element) {
      data.add(InsightsVisitsData.fromJson(element));
    });
  }
}

class InsightsVisitsData {
  String? visits;
  InsightsVisitsData();
  InsightsVisitsData.fromJson(Map<String, dynamic> json) {
    visits = json["visits"];
  }
}
