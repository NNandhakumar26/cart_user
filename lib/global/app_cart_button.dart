import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyskart/core/constants/colors.dart';
import 'package:toyskart/core/constants/routes.dart';
import 'package:toyskart/core/utils/alerts.dart';
import 'package:toyskart/global/app_service.dart';
import 'package:unicons/unicons.dart';

class AppCartButton extends StatelessWidget {
  const AppCartButton({super.key, this.onPressed});
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    // if (!Navigator.of(context).canPop() && onPressed == null) {
    //   return const SizedBox.shrink();
    // }
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Obx(
        () => AppService.to.globalCartCount > 0
            ? FloatingActionButton(
                elevation: 0,
                backgroundColor: Colors.transparent,
                heroTag: null,
                mini: true,
                onPressed: () {
                  debugPrint('att');
                  Get.toNamed(RouteConst.checkout, arguments: []);
                },
                child: Badge(
                  label: Text(
                    "${AppService.to.globalCartCount}",
                    style: const TextStyle(
                        color: ColorConst.primary,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                  padding: const EdgeInsets.all(6),
                  backgroundColor: ColorConst.white,
                  child: const Icon(UniconsLine.shopping_bag,
                      color: ColorConst.white),
                ),
              )
            : FloatingActionButton(
                elevation: 0,
                backgroundColor: Colors.transparent,
                heroTag: null,
                mini: true,
                onPressed: () {
                  toast("No Items in Cart");
                },
                child: const Icon(UniconsLine.shopping_bag,
                    color: ColorConst.whiteFade),
              ),
      ),
    );
  }
}
