import 'package:app_links/app_links.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:go_router/go_router.dart';
import 'package:keep/app/services/dio_helper/dio_helper.dart';
import 'app/my_app.dart';
import 'app/resources/language_manager.dart';
import 'app/services/shared_prefrences/cache_helper.dart';
import 'presentation/profile/view/profile_screen.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  FirebaseMessaging.onMessage.listen((event) {});
  FirebaseMessaging.onMessageOpenedApp.listen((event) {});
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  DioHelper.init();
  // Listen for incoming links
  final appLinks = AppLinks();
  appLinks.getLatestAppLink().then((value) {
    handleLink(value!);
  });
  appLinks.getInitialAppLink().then((value) {
    handleLink(value!);
  });
  appLinks.allUriLinkStream.listen(
    (Uri? uri) {
      // Handle the incoming link
      handleLink(uri!);
    },
    onError: (err) {
      // Handle errors
    },
  );

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

void handleLink(Uri uri) {
  String yourDomain = 'dash.keepbi.com';
  // Check if the domain of the URL belongs to your domain
  if (uri.host == yourDomain) {
    // Open the link in your app
    GoRoute(
      path: "apps/profile",
      builder: (_, __) => ProfileScreen(
        id: int.parse(
          uri.queryParameters.values.first,
        ),
      ),
    );
  }
}
