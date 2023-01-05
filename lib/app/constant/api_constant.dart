// class ApiConstant {
//   static const String authorization = "Authorization";
//   static const String authorizationBody =
//       "Basic bWFocmFuLmFkdjJAZ21haWwuY29tOkFkbWluIUAjMTIz";
//   static const String viewOutletPath =
//       "https://zeitco-me.com/crm/api/index.php";
//   static String searchOutletPath(String outletName) =>
//       "https://zeitco-me.com/crm/api/index.php?outletName=$outletName";

//   static String searchAgreedPath(String outletName) =>
//       "https://zeitco-me.com/crm/api/index.php?outletName=$outletName&status=APPROVED";
//   static String searchActivePath(String outletName) =>
//       "https://zeitco-me.com/crm/api/index.php?outletName=$outletName&status=active";
//   static String searchInActivePath(String outletName) =>
//       "https://zeitco-me.com/crm/api/index.php?outletName=$outletName&status=inactive";
//   static String searchNotAgreedPath(String outletName) =>
//       "https://zeitco-me.com/crm/api/index.php?outletName=$outletName&status=PROCEED";
//   static String surveyrdOutletPath =
//       "https://zeitco-me.com/crm/api/surveyed.php";
//   static String searchSurveyedPath(String outletName) =>
//       "https://zeitco-me.com/crm/api/surveyed.php?outletName=$outletName";
//   static String approveSurveyedPath =
//       "https://zeitco-me.com/crm/api/surveyed.php/approve";
//   static String editSurveyedPath =
//       "https://zeitco-me.com/crm/api/surveyed.php/update";
//   static String declinedSurveyedPath =
//       "https://zeitco-me.com/crm/api/surveyed.php/decline";
//   static String verifiedOutletPath =
//       "https://zeitco-me.com/crm/api/verify.php";
//   static String searchVerifiedPath(String outletName) =>
//       "https://zeitco-me.com/crm/api/verify.php?outletName=$outletName";

//   static String declinedVerifiedPath =
//       "https://zeitco-me.com/crm/api/verify.php/decline";
//   static String editVerifiedPath =
//       "https://zeitco-me.com/crm/api/verify.php/update";
//   static String purchasingTeamPath =
//       "https://zeitco-me.com/crm/api/members.php";
//   static String assignPurchaserPath =
//       "https://zeitco-me.com/crm/api/verify.php/addAssign";
//   static String addOutletPath =
//       "http://zeitco.linemedia.live/api/surveyed.php/addsurveyed";
//   static String getCityPath = "https://zeitco-me.com/crm/api/gov.php";
//   static String getAreaPath(String city) =>
//       "https://zeitco-me.com/crm/api/city.php?govName=$city";
//   static String getPurchsingPath =
//       "https://zeitco-me.com/crm/api/purchasing.php";
//   static String searchPurchesingPath(String outletName) =>
//       "https://zeitco-me.com/crm/api/purchasing.php?outletName=$outletName";
//   static String getReAssignPurchasingTeamPath(String outletId) =>
//       "https://zeitco-me.com/crm/api/members.php?outletId=$outletId";
//   static String reAssignPurchasingTeam =
//       "https://zeitco-me.com/crm/api/purchasing.php/reAssign";
//   static String approvePurchasingpath =
//       "https://zeitco-me.com/crm/api/purchasing.php/approve";
//   static String declinedPurchasingPath =
//       "https://zeitco-me.com/crm/api/purchasing.php/decline";
//   static String editPurchasingPath =
//       "https://zeitco-me.com/crm/api/purchasing.php/update";
//   static String getPurchasedPath =
//       "https://zeitco-me.com/crm/api/approve.php";
//   static String searchPurchasedPath(String outletName) =>
//       "https://zeitco-me.com/crm/api/approve.php?outletName=$outletName";
//   static String notAgreedPurchasedPath =
//       "https://zeitco-me.com/crm/api/approve.php/notAgreed";
//   static String declinedPurchasedPath =
//       "https://zeitco-me.com/crm/api/approve.php/decline";
//   static String approvePurchasedPath =
//       "https://zeitco-me.com/crm/api/approve.php/approve";
//   static String getNewOrdersPath =
//       "https://zeitco-me.com/crm/api/orders.php/selectNewOrder";
//   static String deleteAssignedOrderPath =
//       "https://zeitco-me.com/crm/api/orders.php/deleteAssignedOrder";
//   static String getAssignedOrdersPath =
//       "https://zeitco-me.com/crm/api/orders.php/AssignedOrders";
//   static String deleteNewOrderPath =
//       "https://zeitco-me.com/crm/api/orders.php/deleteNewOrder";
//   static String getOnProgressOrdersPath =
//       "https://zeitco-me.com/crm/api/orders.php/onProgressOrders";
//   static String getIssuedOrdersPath =
//       "https://zeitco-me.com/crm/api/orders.php/IssuedOrders";
//   static String getCollectedOrdersPath =
//       "https://zeitco-me.com/crm/api/orders.php";
//   static String getOutletPrice =
//       "https://zeitco-me.com/crm/api/special.php/outletName";
//   static String addOrderPath =
//       "https://zeitco-me.com/crm/api/orders.php/addNewOrders";
//   static String getDriverTeamPath =
//       "https://zeitco-me.com/crm/api/members.php";
//   static String getReAssignDriverTeamPath(String orderId) =>
//       "https://zeitco-me.com/crm/api/members.php?orderId=$orderId";
//   static String assignDriverPath =
//       "https://zeitco-me.com/crm/api/orders.php/assignNewOrder";
//   static String confirmAssignDriverPath =
//       "https://zeitco-me.com/crm/api/orders.php/confirmAssign";
//   static String editOrderPath =
//       "https://zeitco-me.com/crm/api/orders.php/updateNewOrder";
//   static String editAssignedOrderPath =
//       "https://zeitco-me.com/crm/api/orders.php/updateAssignedOrder";
//   static String reAssignDriverPath =
//       "https://zeitco-me.com/crm/api/orders.php/reAssignAssignedOrder";
//   static String onProgressOrderPath =
//       "https://zeitco-me.com/crm/api/driverApp.php/onProgressOrders";
//   static String orderPath =
//       "https://zeitco-me.com/crm/api/driverApp.php/assignedOrders";
//   static String orderToOnProgressPath =
//       "https://zeitco-me.com/crm/api/driverApp.php/toProgress";
//   static String completedorderPath =
//       "https://zeitco-me.com/crm/api/driverApp.php/completedOrders";
//   static String collectionOrderPath =
//       "https://zeitco-me.com/crm/api/driverApp.php/toCompleted";
//   static String getIssuesPath =
//       "https://zeitco-me.com/crm/api/orders.php/issue";
//   static String issuesOrderPath =
//       "https://zeitco-me.com/crm/api/driverApp.php/IssueOrder";
//   static String loginUserPath =
//       "https://zeitco-me.com/crm/api/driverApp.php/login";
//   static String checkInPath =
//       "https://zeitco-me.com/crm/api/driverApp.php/checkIn";
//   static String checkOutPath =
//       "https://zeitco-me.com/crm/api/driverApp.php/checkOut";
//   static String getDeclinedPath =
//       "https://zeitco-me.com/crm/api/outlet.php/decline";
//   static String getOutletsPath =
//       "https://zeitco-me.com/crm/api/special.php/list";
//   static String getRoles =
//       "https://zeitco-me.com/crm/api/special.php/userId";
// }
