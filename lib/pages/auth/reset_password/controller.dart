// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:gigavus_login/core/constants/routes.dart';
// import 'package:gigavus_login/core/utils/alerts.dart';

// class ResetPasswordController extends GetxController {
//   //var oldPassword = "", newPassword = "", confirmNewPassword = "";

//   final oldPassword = TextEditingController();
//   final newPassword = TextEditingController();
//   final confirmNewPassword = TextEditingController();
//   RxBool isChecked = false.obs;
//   RxBool oldIsObscure = false.obs;
//   RxBool newIsObscure = false.obs;
//   RxBool cnewIsObscure = false.obs;
//   GlobalKey<FormState> formkeys = GlobalKey<FormState>();
// // // sign with email and password

// //   toast(msg) {
// //     BotToast.showText(
// //       text: msg,
// //       align: const Alignment(0, -0.68),
// //       textStyle: const TextStyle(fontSize: 16, color: ColorConst.primary),
// //       backgroundColor: Colors.transparent,
// //       contentColor: ColorConst.primary,
// //     );
// //   }

//   UpdatePassword() async {
//     if (formkeys.currentState!.validate()) {
//       try {
//         final User? details = FirebaseAuth.instance.currentUser;

//         var cre = EmailAuthProvider.credential(
//             email: details!.email.toString(), password: oldPassword.text);

//         final UserCredential reAuth = await FirebaseAuth.instance.currentUser!
//             .reauthenticateWithCredential(cre);

//         if (newPassword.text == confirmNewPassword.text) {
//           if (reAuth.user != null) {
//             var rst = details.updatePassword(newPassword.text);

//             oldPassword.clear();
//             newPassword.clear();
//             confirmNewPassword.clear();
//             toast('Your Password Updated Successfully.');
//             Get.offAllNamed(RouteConst.auth);
//           }
//         } else {
//           toast('New Password and Confirm New Password does not match');
//         }
//       } on FirebaseAuthException catch (e) {
//         switch (e.code) {
//           case "wrong-password":
//             toast("Old Password you entered is Invalid/Wrong.");
//             break;

//           default:
//             toast("Oops Something went worng. Please try again.");
//             break;
//         }
//       }
//     }
//   }
// }
