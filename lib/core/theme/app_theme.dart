import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/colors.dart';

class AppTheme {
  final BuildContext ctx;
  AppTheme(this.ctx);

  static const String fontFamily = 'Qanelas_Soft';

  ThemeData get light {
    return ThemeData.light().copyWith(
        primaryColor: ColorConst.primary,
        scaffoldBackgroundColor: ColorConst.background,
        primaryTextTheme: Theme.of(ctx).primaryTextTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
              decorationColor: Colors.white,
              fontFamily: fontFamily,
            ),
        textTheme: Theme.of(ctx).textTheme.apply(
              bodyColor: Colors.black,
              displayColor: Colors.black,
              decorationColor: Colors.black,
              fontFamily: fontFamily,
            ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: ColorConst.background,
            circularTrackColor: Colors.transparent,
            linearTrackColor: ColorConst.primary),
        drawerTheme: const DrawerThemeData(
          backgroundColor: ColorConst.background,
        ),
        appBarTheme: const AppBarTheme(
          titleSpacing: 2,
          centerTitle: true,
          color: ColorConst.background,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorConst.primary,
          ),
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: fontFamily,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: ColorConst.primary,
            minimumSize: const Size(0, 0),
            maximumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            foregroundColor: ColorConst.background2,
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: ColorConst.background2,
              fontFamily: fontFamily,
            ),
          ),
        ),
        dialogBackgroundColor: ColorConst.background,
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            elevation: 0,
            minimumSize: const Size(0, 0),
            maximumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            side: const BorderSide(color: ColorConst.primary),
            textStyle: const TextStyle(fontSize: 20, fontFamily: fontFamily),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        primaryIconTheme: const IconThemeData(color: Colors.white),
        inputDecorationTheme: const InputDecorationTheme(),
        checkboxTheme: const CheckboxThemeData(), colorScheme: const ColorScheme.light(
          primary: ColorConst.primary,
          onPrimary: Colors.white,
        ).copyWith(background: ColorConst.background));
  }
}
