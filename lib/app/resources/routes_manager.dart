import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:keep/presentation/calendar_daily/view/calendar_daily_screen.dart';
import 'package:keep/presentation/map_screen/view/map_screen.dart';
import 'package:keep/presentation/calendar_hourly/view/calendar_hourly.dart';
import 'package:keep/presentation/calendar_monthly/view/calendar_monthly_screen.dart';
import 'package:keep/presentation/layout/view/layout_screen.dart';
import 'package:keep/presentation/login/view/login_screen.dart';
import 'package:keep/presentation/notification/view/notification_view.dart';
import 'package:keep/presentation/on_boarding/view/on_boarding_screen.dart';
import 'package:keep/presentation/share/view/share_screen.dart';
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
  static const String shareRoute = "/shareRoute";
  static const String mapRoute = "/mapRoute";
  static const String addTaskRoute = "/addTaskRoute";

}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
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
          builder: (_) =>  CalendarHorlyScreen(),
        );
      case Routes.calendarMonthlyRoute:
        return MaterialPageRoute(
          builder: (_) =>  CalendarMonthlyScreen(),
        );
      case Routes.shareRoute:
        return MaterialPageRoute(
          builder: (_) => ShareScreen(),
        );
      case Routes.mapRoute:
        return MaterialPageRoute(
          builder: (_) =>  MapScreen(),
        );
          case Routes.calendarDailyRoute:
        return MaterialPageRoute(
          builder: (_) =>  CalendarDailyScreen(),
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
