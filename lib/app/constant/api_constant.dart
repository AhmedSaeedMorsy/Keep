class ApiConstant {
  static const String loginPath = "user/auth/login";
  static const String userPath = "user/auth/me";
  static const String logOutPath = "user/auth/logout";
  static const String getTaskPath = "task/all";
  static const String addTaskPath = "task/add";
  static String editTask({required int id}) => "task/edit/$id";
  static String approveTask({required int id}) => "task/approve/$id";
  static String rejectTask({required int id}) => "task/approve/$id";
  static String changeTaskStatus({required int id}) => "task/status/$id";
  static const String getLeads = "lead";
  static String editLeads({required int id}) => "lead/$id";
  static const String getTeams = "team";
  static String getProfilePath({required id}) => "profile/$id";
  static String getUsersByTeamPath({required id}) => "team/retrieve/$id";
  static String shareLeadsPath({required id, required usersIds}) =>
      "lead/$id/$usersIds";
        static String shareKitsPath({required id, required usersIds}) =>
      "kits/$id/$usersIds";
  static const String kitsPath = "kits";
        static String shareMeetingPath({required id, required usersIds}) =>
      "task/reassign/$id/$usersIds";
}
