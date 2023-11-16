import 'package:flutter/material.dart';

class AppSearchButton extends StatelessWidget {
  const AppSearchButton({super.key, this.onPressed});
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    // if (!Navigator.of(context).canPop() && onPressed == null) {
    //   return const SizedBox.shrink();
    // }
    return IconButton(
      padding: EdgeInsets.zero,
      icon: const Icon(
        Icons.search,
        size: 30,
        color: Colors.white,
      ),
      onPressed: onPressed,
    );
  }
}
