import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toyskart/core/constants/colors.dart';

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
