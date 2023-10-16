import 'package:flutter/foundation.dart';

Future<void> delay([int millis = 1000]) async {
  await Future.delayed(Duration(milliseconds: millis));
}

void dPrint(dynamic message, {String title = ''}) {
  if (kDebugMode) {
    print('$title: $message');
  }
}
