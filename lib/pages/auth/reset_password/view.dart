// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:gigavus_login/pages/auth/reset_password/controller.dart';
// import 'package:unicons/unicons.dart';

// import '../../../core/constants/assets.dart';
// import '../../../core/constants/colors.dart';

// class ResetPassword extends GetView<ResetPasswordController> {
//   const ResetPassword({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var email = "";
//     bool isScrollable = MediaQuery.of(context).size.height < 600;
//     GlobalKey<FormState> formkey = GlobalKey<FormState>();

//     var body = Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         const SizedBox(
//           height: 100,
//         ),
//         Form(
//           key: controller.formkeys,
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Obx(() => TextFormField(
//                       controller: controller.oldPassword,
//                       maxLength: 50,
//                       obscureText: !controller.oldIsObscure.value,

//                       keyboardType: TextInputType.visiblePassword,
//                       style: const TextStyle(color: ColorConst.black),
//                       //autofocus: true,
//                       validator: (input) =>
//                           input!.isEmpty ? 'Please enter Old password' : null,

//                       decoration: InputDecoration(
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               controller.oldIsObscure.value
//                                   ? UniconsLine.eye
//                                   : UniconsLine.eye_slash,
//                               color: ColorConst.grey3,
//                               size: 24,
//                             ),
//                             onPressed: () {
//                               controller.oldIsObscure.value =
//                                   !controller.oldIsObscure.value;
//                             },
//                           ),
//                           isDense: true,
//                           prefix: const SizedBox(
//                             width: 15,
//                           ),
//                           contentPadding: const EdgeInsets.only(
//                               top: 14, right: 14, bottom: 14),
//                           hintText: 'Old Password',
//                           hintStyle: const TextStyle(
//                             color: ColorConst.grey3,
//                             fontSize: 16,
//                             fontWeight: FontWeight.w400,
//                           ),
//                           //alignLabelWithHint: true,
//                           border: OutlineInputBorder(
//                             borderSide:
//                                 const BorderSide(color: ColorConst.black),
//                             borderRadius: BorderRadius.circular(4.0),
//                           ),
//                           errorBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                               color: Colors.red,
//                             ),
//                             borderRadius: BorderRadius.circular(4.0),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide:
//                                 const BorderSide(color: ColorConst.black),
//                             borderRadius: BorderRadius.circular(4.0),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide:
//                                 const BorderSide(color: ColorConst.black),
//                             borderRadius: BorderRadius.circular(4.0),
//                           ),
//                           fillColor: Colors.transparent,
//                           filled: true),
//                       // onChanged: (value) {
//                       //   // setState(() {
//                       //   controller.oldPassword = value.trim();
//                       //   // });
//                       // },
//                     )),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Obx(() => TextFormField(
//                       controller: controller.newPassword,

//                       maxLength: 50,
//                       obscureText: !controller.newIsObscure.value,

//                       keyboardType: TextInputType.emailAddress,
//                       style: const TextStyle(color: ColorConst.black),
//                       //autofocus: true,
//                       validator: (input) =>
//                           input!.isEmpty ? 'Please enter New password' : null,
//                       decoration: InputDecoration(
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               controller.newIsObscure.value
//                                   ? UniconsLine.eye
//                                   : UniconsLine.eye_slash,
//                               color: ColorConst.grey3,
//                               size: 24,
//                             ),
//                             onPressed: () {
//                               controller.newIsObscure.value =
//                                   !controller.newIsObscure.value;
//                             },
//                           ),
//                           isDense: true,
//                           prefix: const SizedBox(
//                             width: 15,
//                           ),
//                           contentPadding: const EdgeInsets.only(
//                               top: 14, right: 14, bottom: 14),
//                           hintText: 'New Password',
//                           hintStyle: const TextStyle(
//                             color: ColorConst.grey3,
//                             fontSize: 16,
//                             fontWeight: FontWeight.w400,
//                           ),
//                           //alignLabelWithHint: true,
//                           border: OutlineInputBorder(
//                             borderSide:
//                                 const BorderSide(color: ColorConst.black),
//                             borderRadius: BorderRadius.circular(4.0),
//                           ),
//                           errorBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                               color: Colors.red,
//                             ),
//                             borderRadius: BorderRadius.circular(4.0),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide:
//                                 const BorderSide(color: ColorConst.black),
//                             borderRadius: BorderRadius.circular(4.0),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide:
//                                 const BorderSide(color: ColorConst.black),
//                             borderRadius: BorderRadius.circular(4.0),
//                           ),
//                           fillColor: Colors.transparent,
//                           filled: true),
//                       // onChanged: (value) {
//                       //   // setState(() {
//                       //   controller.newPassword = value.trim();
//                       //   // });
//                       // },
//                     )),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Obx(() => TextFormField(
//                       controller: controller.confirmNewPassword,

//                       maxLength: 50,
//                       obscureText: !controller.cnewIsObscure.value,
//                       keyboardType: TextInputType.emailAddress,
//                       //autofocus: true,
//                       style: const TextStyle(color: ColorConst.black),
//                       validator: (input) => input!.isEmpty
//                           ? 'Please Re-enter New password'
//                           : null,
//                       decoration: InputDecoration(
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               controller.cnewIsObscure.value
//                                   ? UniconsLine.eye
//                                   : UniconsLine.eye_slash,
//                               color: ColorConst.grey3,
//                               size: 24,
//                             ),
//                             onPressed: () {
//                               controller.cnewIsObscure.value =
//                                   !controller.cnewIsObscure.value;
//                             },
//                           ),
//                           isDense: true,
//                           prefix: const SizedBox(
//                             width: 15,
//                           ),
//                           contentPadding: const EdgeInsets.only(
//                               top: 14, right: 14, bottom: 14),
//                           hintText: 'Confirm New Password',
//                           hintStyle: const TextStyle(
//                             color: ColorConst.grey3,
//                             fontSize: 16,
//                             fontWeight: FontWeight.w400,
//                           ),
//                           //alignLabelWithHint: true,
//                           border: OutlineInputBorder(
//                             borderSide:
//                                 const BorderSide(color: ColorConst.black),
//                             borderRadius: BorderRadius.circular(4.0),
//                           ),
//                           errorBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                               color: Colors.red,
//                             ),
//                             borderRadius: BorderRadius.circular(4.0),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide:
//                                 const BorderSide(color: ColorConst.black),
//                             borderRadius: BorderRadius.circular(4.0),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide:
//                                 const BorderSide(color: ColorConst.black),
//                             borderRadius: BorderRadius.circular(4.0),
//                           ),
//                           fillColor: Colors.transparent,
//                           filled: true),
//                       // onChanged: (value) {
//                       //   // setState(() {
//                       //   controller.confirmNewPassword = value.trim();
//                       //   // });
//                       // },
//                     )),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(
//                     left: 10.0, top: 0.0, right: 10.0, bottom: 5.0),
//                 child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       primary: ColorConst.primary,
//                       elevation: 0,
//                       minimumSize: const Size(double.infinity, 55),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(0.0)),
//                     ),
//                     child: const Text(
//                       'Reset',
//                       style: TextStyle(
//                           fontSize: 18,
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     onPressed: () async {
//                       controller.UpdatePassword();
//                     }),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );

//     return Scaffold(
//       backgroundColor: ColorConst.background,
//       appBar: AppBar(
//         backgroundColor: ColorConst.background,
//         centerTitle: true,
//         leading: Container(
//           padding: const EdgeInsets.only(left: 10),
//           child: InkWell(
//             // When the user taps the button, show a snackbar.
//             onTap: () {
//               Navigator.of(context).pop();
//             },
//             child: const Padding(
//               padding: EdgeInsets.only(top: 2, left: 0, right: 1, bottom: 1),
//               child: Icon(
//                 UniconsLine.angle_left,
//               ),
//             ),
//           ),
//         ),
//         title: const Text('Reset Password'),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage(AssetConst.loginBgtop),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: SafeArea(
//             child: isScrollable
//                 ? SingleChildScrollView(
//                     child: body,
//                   )
//                 : body,
//           ),
//         ),
//       ),
//     );
//   }
// }
