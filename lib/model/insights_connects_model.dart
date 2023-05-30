class InsightsConnectsModel {
int data =0;
  InsightsConnectsModel();
  InsightsConnectsModel.formJson(Map<String, dynamic> json) {
    data = json["data"];
  }
}
