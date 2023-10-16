import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../constants/routes.dart';

void logout() async {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  googleSignIn.signOut();
  await FirebaseAuth.instance.signOut();
  //AppService.to.user = null;

  Get.offAllNamed(RouteConst.initial);
}
