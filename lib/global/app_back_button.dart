import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({Key? key, this.onPressed}) : super(key: key);
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    // if (!Navigator.of(context).canPop() && onPressed == null) {
    //   return const SizedBox.shrink();
    // }
    return IconButton(
      padding: EdgeInsets.zero,
      icon: const Icon(
        Icons.chevron_left,
        size: 30,
        color: Colors.white,
      ),
      onPressed: onPressed ?? Get.back,
    );
  }
}
