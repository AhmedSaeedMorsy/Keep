import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'app/my_app.dart';
import 'app/resources/language_manager.dart';
import 'app/services/shared_prefrences/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await CacheHelper.init();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        ARABIC_LOCAL,
        ENGLISH_LOCAL,
      ],
      path: asstesLocalePath,
      child: Phoenix(
        child: MyApp(),
      ),
    ),
  );
}
