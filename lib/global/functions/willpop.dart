import 'package:flutter/material.dart';
import 'package:toyskart/core/constants/colors.dart';

checkBack(BuildContext context, bool flag) {
  Navigator.of(context).pop(flag);

  return flag;
}

Future<bool> backPressed(BuildContext context) async {
  bool value = await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: Colors.white,
      actionsPadding: const EdgeInsets.symmetric(horizontal: 12.0),
      title: Text(
        'Are you sure you want to close this App?',
        style: TextStyle(color: Colors.black.withOpacity(0.7), fontSize: 16),
      ),
      actions: <Widget>[
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                foregroundColor: ColorConst.white,
                padding: const EdgeInsets.all(8),
                textStyle: const TextStyle(fontSize: 12)),
            child: const Text('Exit'),
            onPressed: () async {
              return checkBack(context, true);
            }),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                foregroundColor: ColorConst.white,
                padding: const EdgeInsets.all(8),
                textStyle: const TextStyle(fontSize: 12)),
            child: const Text('Dismiss'),
            onPressed: () async {
              return checkBack(context, false);
            }),
      ],
    ),
  );
  return value;
}
