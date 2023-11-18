import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:toyskart/core/constants/colors.dart';
import 'package:toyskart/core/constants/routes.dart';
import 'package:toyskart/core/routes/app_routes.dart';
import 'package:toyskart/core/theme/app_theme.dart';
import 'package:toyskart/firebase_options.dart';
import 'package:toyskart/global/app_service.dart';

Future<void> backroundHandler(RemoteMessage message) async {
  print(" This is message from background");
  print(message.notification!.title);
  print(message.notification!.body);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: ColorConst.primary,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: ColorConst.primary,
  ));
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(backroundHandler);
  // FirebaseMessaging.onMessage(backroundHandler);
  // FirebaseMessaging.onMessageOpenedApp(backroundHandler);
  Get.put(AppService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AppTheme appTheme = AppTheme(context);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mercury Toys ',
      builder: BotToastInit(),
      navigatorObservers: [
        BotToastNavigatorObserver(),
      ],
      theme: appTheme.light,
      initialRoute: RouteConst.initial,
      getPages: appPages(),
      unknownRoute: unknownRoute(),
    );
  }
}
