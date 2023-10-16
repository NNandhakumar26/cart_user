import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

import '../constants/colors.dart';

Future<bool> confirm(String text,
    {String content = '',
    String? ok,
    String? cancel,
    TextAlign? contentAlignment = TextAlign.center,
    bool barrierDismissible = true}) async {
  ok = ok ?? 'Ok';
  cancel = cancel ?? 'Cancel';
  bool? ret = await Get.dialog<bool>(
      AlertDialog(
        backgroundColor: ColorConst.background,
        insetPadding: const EdgeInsets.all(20),
        title: Center(
          child: SizedBox(
            width: Get.width,
            child: Text(
              text,
              style: const TextStyle(color: ColorConst.black),
            ),
          ),
        ),
        content:
            content.isEmpty ? null : Text(content, textAlign: contentAlignment),
        actions: <Widget>[
          TextButton(
            onPressed: Get.back,
            child: Text(
              cancel.toUpperCase(),
              style: const TextStyle(color: ColorConst.primary),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(8),
                textStyle: const TextStyle(fontSize: 14)),
            onPressed: () {
              Get.back(result: true);
            },
            child: Text(ok.toUpperCase()),
          ),
          const SizedBox(width: 10),
        ],
      ),
      barrierDismissible: barrierDismissible);
  return ret ?? false;
}

Future<bool> alert(
  String text, {
  String content = '',
  String? ok,
  Color okColor = ColorConst.black,
  double titleSize = 16,
  double contentSize = 14,
  bool barrierDismissible = false,
}) async {
  ok = ok ?? 'Ok';
  return await Get.dialog<bool>(
        AlertDialog(
          insetPadding: const EdgeInsets.all(20),
          title: text.isEmpty
              ? null
              : Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: titleSize,
                  ),
                ),
          content: content.isEmpty
              ? null
              : Text(content, textAlign: TextAlign.center),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: Get.back,
                  child: Text(
                    ok.toUpperCase(),
                    style: TextStyle(
                      color: okColor,
                      fontSize: contentSize,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
        barrierDismissible: barrierDismissible,
        transitionCurve: Curves.bounceInOut,
      ) ??
      false;
}

void toast(String? msg, [bool long = false]) {
  debugPrint(msg);
  BotToast.showText(
    align: const Alignment(0.0, 0.8),
    text: msg ?? '',
    backButtonBehavior: BackButtonBehavior.close,
    borderRadius: BorderRadius.circular(3),
    contentColor: ColorConst.primary,
    duration: Duration(milliseconds: long ? 3500 : 2500),
    clickClose: false,
    crossPage: true,
    onlyOne: true,
    textStyle: GoogleFonts.varelaRound(fontSize: 18, color: ColorConst.white),
    contentPadding: const EdgeInsets.all(10),
  );
}

void toastNotify(title, subtitle) {
  BotToast.showSimpleNotification(
    title: title,
    closeIcon: const Icon(
      UniconsLine.times,
      color: ColorConst.background,
    ),
    duration: const Duration(seconds: 4),
    backgroundColor: ColorConst.background,
    subTitle: subtitle,
    onlyOne: false,
    titleStyle: const TextStyle(color: ColorConst.background),
    subTitleStyle: const TextStyle(color: ColorConst.background),
  );
}
