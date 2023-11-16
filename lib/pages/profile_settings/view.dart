import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyskart/core/constants/colors.dart';
import 'package:toyskart/core/constants/routes.dart';
import 'package:toyskart/core/utils/alerts.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({super.key});

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  // AppService get app => AppService.to;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ListTile(
            //   leading: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: selfAvatar(dimension: 24),
            //   ),
            //   title: const Text("My Profile"),
            //   onTap: () async {
            //     await Get.offAndToNamed(RouteConst.profile);
            //     if (mounted) {
            //       setState(() {});
            //     }
            //   },
            // ),
            // ListTile(
            //   leading: const Padding(
            //     padding: EdgeInsets.all(8.0),
            //     child: Icon(Icons.shopping_cart, color: ColorConst.background2),
            //   ),
            //   title: const Text('My Cart'),
            //   onTap: () {
            //     toast("Yet to be implemented");
            //   },
            // ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.list_alt, color: Colors.green[900]),
              ),
              title: const Text(
                "My Address",
              ),
              onTap: () {
                Get.back();
                Get.toNamed(
                  RouteConst.address,
                );

                //openThemePicker();
              },
            ),
            // ListTile(
            //   leading: const Padding(
            //     padding: EdgeInsets.all(8.0),
            //     child: Icon(
            //       Icons.favorite,
            //       color: ColorConst.primary,
            //     ),
            //   ),
            //   title: const Text("WishList"),
            //   onTap: () {
            //     toast("Yet to be implemented");
            //   },
            // ),
            ListTile(
              leading: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.account_circle,
                  color: ColorConst.gigavusIndigo,
                ),
              ),
              title: const Text("My Profile"),
              onTap: () {
                toast("Yet to be implemented");
              },
            ),
            ListTile(
              title: const Text(
                'About Us',
              ),
              onTap: () {
                Get.back();
                //openAccountSettings(true);
              },
              leading: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.flutter_dash,
                  color: ColorConst.primary,
                ),
              ),
            ),

            // ListTile(
            //   leading: const Padding(
            //     padding: EdgeInsets.all(8.0),
            //     child: Icon(Icons.policy_rounded),
            //   ),
            //   title: const Text('Privacy Policy'),
            //   onTap: () {
            //     toast("Yet to be implemented");
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
