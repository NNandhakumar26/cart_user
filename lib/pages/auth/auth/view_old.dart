// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:toyskart/core/constants/assets.dart';

// import '../../../core/constants/colors.dart';
// import 'controller.dart';

// class AuthPage extends StatelessWidget {
//   const AuthPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     bool isScrollable = MediaQuery.of(context).size.height < 600;

//     final border = OutlineInputBorder(
//       borderSide: const BorderSide(color: ColorConst.t4),
//       borderRadius: BorderRadius.circular(4.0),
//     );
//     return GetBuilder<AuthPageController>(
//       builder: (_) {
//         var body = Column(
//           children: [
//             //  const BackgroundPlayer(),
//             Container(
//               height: MediaQuery.of(context).size.height * .29,
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage(AssetConst.bg),
//                   fit: BoxFit.fill,
//                 ),
//                 //shape: BoxShape.circle,
//               ),
//             ),

//             Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   _.signInMode ? 'Sign In' : 'Create an account',
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                     fontSize: 30,
//                     fontWeight: FontWeight.w600,
//                     color: ColorConst.black,
//                   ),
//                 ),
//                 const SizedBox(height: 40),
//                 Form(
//                   key: _.formkey,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       if (!_.signInMode)
//                         Padding(
//                           padding: const EdgeInsets.only(bottom: 16, top: 20),
//                           child: TextFormField(
//                             maxLength: 16,
//                             validator: (input) {
//                               // final alphanumeric = RegExp("^[a-zA-Z0-9_]*\$");
//                               // alphanumeric.hasMatch(input); // true

//                               return input!.isEmpty
//                                   ? 'Please enter name'
//                                   : null;
//                             },
//                             decoration: InputDecoration(
//                               hintText: 'Name',
//                               isDense: true,
//                               prefix: const SizedBox(width: 16),
//                               contentPadding:
//                                   const EdgeInsets.only(top: 16, bottom: 16),
//                               hintStyle: const TextStyle(
//                                 color: ColorConst.t3,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                               counter: const SizedBox.shrink(),
//                               border: border,
//                               errorBorder: OutlineInputBorder(
//                                 borderSide: const BorderSide(
//                                   color: Colors.red,
//                                 ),
//                                 borderRadius: BorderRadius.circular(4.0),
//                               ),
//                               focusedBorder: border,
//                               enabledBorder: border,
//                               fillColor: Colors.white,
//                               filled: true,
//                             ),
//                             onChanged: (value) {
//                               _.name = value.trim();
//                             },
//                             style: const TextStyle(color: Colors.black),
//                           ),
//                         ),
//                       TextFormField(
//                         maxLength: 50,
//                         keyboardType: TextInputType.emailAddress,
//                         validator: (input) =>
//                             input!.isEmpty ? 'Please enter Email' : null,
//                         decoration: InputDecoration(
//                           contentPadding:
//                               const EdgeInsets.only(top: 16, bottom: 16),
//                           prefix: const SizedBox(width: 16),
//                           isDense: true,
//                           counter: const SizedBox.shrink(),
//                           hintText: _.signInMode ? 'Email' : 'Email',
//                           hintStyle: const TextStyle(
//                             color: ColorConst.t3,
//                             fontSize: 16,
//                             fontWeight: FontWeight.w400,
//                           ),
//                           border: border,
//                           errorBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                               color: Colors.red,
//                             ),
//                             borderRadius: BorderRadius.circular(4.0),
//                           ),
//                           focusedBorder: border,
//                           enabledBorder: border,
//                           fillColor: Colors.white,
//                           filled: true,
//                         ),
//                         style: const TextStyle(color: Colors.black),
//                         onChanged: (value) {
//                           _.email = value.trim();
//                         },
//                       ),
//                       const SizedBox(height: 16),
//                       TextFormField(
//                         maxLength: 50,
//                         obscureText: !_.isObscure,
//                         autovalidateMode: AutovalidateMode.onUserInteraction,
//                         validator: (s) {
//                           s = s ?? '';
//                           if (s.trim().isEmpty) {
//                             return 'Please enter password';
//                           }
//                           if (_.signInMode == false) {
//                             if (s.length < 8) {
//                               return 'Min characters allowed is 8';
//                             }
//                             if (s.length > 20) {
//                               return 'Max characters allowed is 20';
//                             }
//                             if (!s.contains(RegExp(r"[a-z]"))) {
//                               return 'Min. required Lowercase Character 1';
//                             }
//                             if (!s.contains(RegExp(r"[A-Z]"))) {
//                               return 'Min. required Uppercase Character 1';
//                             }
//                             if (!s.contains(RegExp(r"[0-9]"))) {
//                               return 'Min. required number 1';
//                             }
//                             if (!s
//                                 .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
//                               return 'Min. required Special Character 1';
//                             }
//                           }
//                           return null;
//                         },
//                         style: const TextStyle(color: Colors.black),
//                         decoration: InputDecoration(
//                           prefix: const SizedBox(width: 16),
//                           counter: const SizedBox.shrink(),
//                           isDense: true,
//                           contentPadding:
//                               const EdgeInsets.only(top: 16, bottom: 16),
//                           hintText: 'Password',
//                           hintStyle: const TextStyle(
//                             color: ColorConst.t3,
//                             fontSize: 16,
//                             fontWeight: FontWeight.w400,
//                           ),
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               _.isObscure
//                                   ? Icons.visibility_outlined
//                                   : Icons.visibility_off_outlined,
//                               color: ColorConst.textColor,
//                               size: 24,
//                             ),
//                             onPressed: () {
//                               _.isObscure = !_.isObscure;
//                               _.update();
//                             },
//                           ),
//                           border: border,
//                           focusedBorder: border,
//                           errorBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                               color: Colors.red,
//                             ),
//                             borderRadius: BorderRadius.circular(4.0),
//                           ),
//                           enabledBorder: border,
//                           fillColor: Colors.white,
//                           filled: true,
//                         ),
//                         onChanged: (value) {
//                           _.password = value.trim();
//                         },
//                       ),
//                       if (_.signInMode)
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: TextButton(
//                             style: TextButton.styleFrom(
//                                 primary: ColorConst.black,
//                                 textStyle: const TextStyle(fontSize: 16),
//                                 tapTargetSize:
//                                     MaterialTapTargetSize.shrinkWrap),
//                             child: const Text('Forget Password ?'),
//                             onPressed: () {
//                               // Get.to(
//                               //   () => const ForgotPasswordPage(),
//                               //   transition: Transition.rightToLeft,
//                               // );
//                             },
//                           ),
//                         ),
//                       // if (!_.signInMode)
//                       //   Row(
//                       //     children: [
//                       //       Checkbox(
//                       //         checkColor: ColorConst.background,
//                       //         fillColor: MaterialStateProperty.all(
//                       //           Colors.white,
//                       //         ),
//                       //         value: _.isAgreed,
//                       //         onChanged: (v) {
//                       //           _.isAgreed = v ?? false;
//                       //           _.update();
//                       //         },
//                       //       ),
//                       //     ],
//                       //   ),
//                       const SizedBox(height: 32),
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           minimumSize: const Size(double.infinity, 56),
//                         ),
//                         child: Text(_.signInMode ? 'Sign In' : 'Sign Up'),
//                         onPressed: () {
//                           _.signInMode
//                               ? _.signinWithEmail()
//                               : _.signUpWithEmail();
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 // Column(
//                 //   children: [
//                 //     Row(
//                 //       children: <Widget>[
//                 //         Expanded(
//                 //           child: Padding(
//                 //             padding: const EdgeInsets.symmetric(horizontal: 10),
//                 //             child: Divider(
//                 //               thickness: 1,
//                 //               color: Colors.grey.shade100,
//                 //             ),
//                 //           ),
//                 //         ),
//                 //         Text(
//                 //           'Or',
//                 //           style: TextStyle(
//                 //             fontSize: 16,
//                 //             color: Colors.grey.shade100,
//                 //           ),
//                 //         ),
//                 //         Expanded(
//                 //           child: Padding(
//                 //             padding: const EdgeInsets.symmetric(horizontal: 10),
//                 //             child: Divider(
//                 //               thickness: 1,
//                 //               color: Colors.grey.shade100,
//                 //             ),
//                 //           ),
//                 //         ),
//                 //       ],
//                 //     ),
//                 //     const SizedBox(height: 24),
//                 //     // const SocialAuthButton(),
//                 //   ],
//                 // ),
//               ],
//             ),
//           ],
//         );
//         return Material(
//           color: ColorConst.background,
//           child: Container(
//             padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
//             decoration: const BoxDecoration(
//                 // image: DecorationImage(
//                 //   image: AssetImage(AssetConst.loginBgtop),
//                 //   fit: BoxFit.cover,
//                 // ),
//                 ),
//             child: SafeArea(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Expanded(child: SingleChildScrollView(child: body)),
//                   TextButton(
//                     style: TextButton.styleFrom(
//                       primary: Colors.grey.shade200,
//                       textStyle: const TextStyle(
//                         fontSize: 16,
//                       ),
//                     ),
//                     onPressed: () {
//                       _.signInMode = !_.signInMode;
//                       _.update();
//                     },
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           _.signInMode
//                               ? 'Don`t have an account?'
//                               : 'Already have an account?',
//                           style: const TextStyle(
//                             fontWeight: FontWeight.w700,
//                             color: ColorConst.black,
//                           ),
//                         ),
//                         Text(
//                           ' ${_.signInMode ? 'Sign Up' : 'Sign In'}',
//                           style: const TextStyle(
//                             fontWeight: FontWeight.w700,
//                             color: ColorConst.primary,
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
