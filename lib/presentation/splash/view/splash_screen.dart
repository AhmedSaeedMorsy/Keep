import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/app/resources/color_manager.dart';
import '../../../app/resources/assets_manager.dart';
import '../../../app/resources/routes_manager.dart';
import '../../../app/resources/values_manager.dart';
import '../../../app/services/shared_prefrences/cache_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  final dateNow = DateTime.now();

  void _startDelay() {
    _timer = Timer(
      const Duration(
        seconds: AppIntDuration.duration3,
      ),
      _nextScreen,
    );
  }

  @override
  void initState() {
    super.initState();

    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorManager.white,
        child: Center(
          child: ZoomIn(
            duration: const Duration(
              seconds: AppIntDuration.duration2,
            ),
            child: Image(
              width: AppSize.s180.w,
              image: const AssetImage(
                AssetsManager.logo,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _nextScreen() {
    if (CacheHelper.getData(key: SharedKey.token) != null) {
      if (CacheHelper.getData(key: SharedKey.loginDate) != null) {
        final loginDate =
            DateTime.parse(CacheHelper.getData(key: SharedKey.loginDate));
        final difference = dateNow.difference(loginDate).inHours;
        if (difference > 12) {
          CacheHelper.removeData(key: SharedKey.loginDate);
          CacheHelper.removeData(key: SharedKey.token);
          Navigator.pushReplacementNamed(
            context,
            Routes.onBoardingRoute,
          );
        } else {
          Navigator.pushReplacementNamed(
            context,
            Routes.layoutRoute,
          );
        }
      } else {
        Navigator.pushReplacementNamed(
          context,
          Routes.onBoardingRoute,
        );
      }
    } else {
      Navigator.pushReplacementNamed(
        context,
        Routes.onBoardingRoute,
      );
    }
  }
}
