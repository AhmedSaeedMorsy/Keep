import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:keep/presentation/add_task/view/add_task_screen_from_filter.dart';
import 'package:keep/presentation/calendar_daily/view/calendar_daily_screen.dart';
import 'package:keep/presentation/forget_password/view/forget_password_screen.dart';
import 'package:keep/presentation/un_assign_lead/view/un_assign_lead.dart';
import 'package:keep/presentation/calendar_hourly/view/calendar_hourly.dart';
import 'package:keep/presentation/calendar_monthly/view/calendar_monthly_screen.dart';
import 'package:keep/presentation/layout/view/layout_screen.dart';
import 'package:keep/presentation/login/view/login_screen.dart';
import 'package:keep/presentation/notification/view/notification_view.dart';
import 'package:keep/presentation/on_boarding/view/on_boarding_screen.dart';
import 'package:keep/presentation/scanner/view/scanner_screen.dart';
import 'package:keep/presentation/splash/view/splash_screen.dart';
import '../../presentation/calendar_weekly/view/calendar_weekly_screen.dart';
import '../../presentation/profile/view/profile_screen.dart';
import 'strings_manager.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoardingRoute";
  static const String loginRoute = "/loginRoute";
  static const String layoutRoute = "/layoutRoute";
  static const String notificationRoute = "/notificationRoute";
  static const String calendarHourlyRoute = "/calendarHourlyRoute";
  static const String calendarMonthlyRoute = "/calendarMonthlyRoute";
  static const String calendarDailyRoute = "/calendarDailyRoute";
  static const String calendarWeeklyRoute = "/calendarWeeklyRoute";
  static const String mapRoute = "/mapRoute";
  static const String addTaskRoute = "/addTaskRoute";
  static const String scannerRoute = "/scannerRoute";
  static const String notApproveTaskRoute = "/notApproveTaskRoute";
  static const String addTaskFromFilter = "/addTaskFromFilter";
  static const String forgetPasswordRoute = "/forgetPasswordRoute";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    if (settings.name!.contains("apps/profile")) {
      return MaterialPageRoute(
        builder: (context) => ProfileScreen(
          id: int.parse(
            settings.name!.split("=").last,
          ),
        ),
      );
    }
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case Routes.onBoardingRoute:
        return MaterialPageRoute(
          builder: (_) => const OnBoardingScreen(),
        );
      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      case Routes.layoutRoute:
        return MaterialPageRoute(
          builder: (_) => const LayoutScreen(),
        );
      case Routes.notificationRoute:
        return MaterialPageRoute(
          builder: (_) => const NotificationScreen(),
        );
      case Routes.calendarHourlyRoute:
        return MaterialPageRoute(
          builder: (_) => CalendarHorlyScreen(),
        );
      case Routes.calendarMonthlyRoute:
        return MaterialPageRoute(
          builder: (_) => CalendarMonthlyScreen(),
        );
      case Routes.addTaskFromFilter:
        return MaterialPageRoute(
          builder: (_) => AddTaskFromFilter(),
        );
      case Routes.mapRoute:
        return MaterialPageRoute(
          builder: (_) => UnAssignLead(),
        );
      case Routes.calendarDailyRoute:
        return MaterialPageRoute(
          builder: (_) => CalendarDailyScreen(),
        );
      case Routes.calendarWeeklyRoute:
        return MaterialPageRoute(
          builder: (_) => CalendarWeeklyScreen(),
        );
      case Routes.scannerRoute:
        return MaterialPageRoute(
          builder: (_) => const ScannerScreen(),
        );
      case Routes.forgetPasswordRoute:
        return MaterialPageRoute(
          builder: (_) => ForgetPasswordScreen(),
        );
      default:
        return unDefiendRoute();
    }
  }

  static Route<dynamic> unDefiendRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.notFound.tr()),
        ),
        body: Center(
          child: Text(
            AppStrings.notFound.tr(),
          ),
        ),
      ),
    );
  }
}
