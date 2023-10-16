import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:toyskart/core/constants/colors.dart';

CancelFunc _loader() {
  // late CancelFunc cancelFunc;
  return BotToast.showCustomLoading(
    toastBuilder: (_) => Card(
      color: Colors.white30,
      elevation: 0,
      child: Container(
        width: 60,
        height: 60,
        padding: const EdgeInsets.all(12),
        child: const CircularProgressIndicator(
          backgroundColor: ColorConst.primary,
        ),
      ),
    ),

    backButtonBehavior: BackButtonBehavior.ignore,

    crossPage: true,
    // backgroundColor: ColorConst.black38,
    ignoreContentClick: true,
  );
}

void showLoader() {
  _loader();
}

void hideLoader() {
  BotToast.closeAllLoading();
}
