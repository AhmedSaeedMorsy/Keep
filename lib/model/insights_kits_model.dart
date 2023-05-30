// ignore_for_file: prefer_typing_uninitialized_variables

class InsightsKitsModel {
 DataModel data = DataModel();
  InsightsKitsModel();
  InsightsKitsModel.formJson(Map<String, dynamic> json) {
    data = DataModel.fromJson(json["data"]);
  }
}

class DataModel {
  var count;
  DataModel();
  DataModel.fromJson(Map<String, dynamic> json) {
    count = json["count"];
  }
}
