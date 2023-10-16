import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:toyskart/core/constants/routes.dart';
import 'package:toyskart/core/services/api/data_api.dart';
import 'package:toyskart/core/utils/loader.dart';
import 'package:toyskart/global/app_service.dart';
import 'package:toyskart/global/toast.dart';

class AuthPageController extends GetxController {
  var app = AppService.to;
  var email = "", name = "", password = "";
  bool isObscure = false;
  bool isAgreed = false;
  final mobile = TextEditingController();
  final otpNumber = TextEditingController();
  String verifyId = '';
  bool signInMode = true;
  late Timer countDown;
  int seconds = 90;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  void addUser(uid) async {
    //   var db = FirebaseFirestore.instance.collection('users').doc();

    //   final jsonData = {
    //     'id': db.id,
    //     'password': password,
    //     'role': 'user',
    //     'uuid': uid,
    //     'email': email
    //   };
    //   var a = await db.set(jsonData);

    //   update();
  }

  Future startTimer() async {
    update();
    const oneSec = Duration(seconds: 1);
    countDown = Timer.periodic(
      oneSec,
      (timer) {
        if (seconds == 0) {
          countDown.cancel();
          timer.cancel();
          update();
        } else {
          seconds--;
          update();
        }
      },
    );
  }

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    showLoader();

    try {
      var auth = FirebaseAuth.instance;
      final authCredential =
          await auth.signInWithCredential(phoneAuthCredential);

      hideLoader();
      var api = DataApiService<List>(
        'auth/signin',
        msgToast: false,
        appJson: true,
        showLoader: false,
      );

      if (!await api.post({}, {})) return;
      if (authCredential.user != null) {
        Get.offAllNamed(RouteConst.initial);

        //Get.offAll(HotelHomeScreen());
      }
    } on FirebaseAuthException catch (e) {
      hideLoader();
      toast(e.message);
    }
  }

  sendOtp({bool resend = false}) async {
    if (!formkey.currentState!.validate()) {
      hideLoader();
      return;
    }
    var auth = FirebaseAuth.instance;
    showLoader();

    await auth.verifyPhoneNumber(
      phoneNumber: mobile.text,
      timeout: const Duration(seconds: 90),
      verificationCompleted: (phoneAuthCredential) async {
        //signInWithPhoneAuthCredential(phoneAuthCredential);
        hideLoader();
        toast(phoneAuthCredential.toString());
      },
      verificationFailed: (verificationFailed) async {
        hideLoader();

        toast(verificationFailed.message);
      },
      codeSent: (verificationId, resendingToken) async {
        hideLoader();
        if (!resend) {
          Get.toNamed(RouteConst.otpVerify);
        }
        otpNumber.clear();
        seconds = 90;
        verifyId = verificationId;
        startTimer();
        toast('sent');
      },
      codeAutoRetrievalTimeout: (verificationId) async {
        hideLoader();
      },
    );
    hideLoader();

    // try {
    //   await FirebaseAuth.instance
    //       .signInWithEmailAndPassword(email: email, password: password);
    //   afterFirebaseAuth();
    // } on FirebaseAuthException catch (e) {
    //   toast(e.message);
    //   return;
    // } finally {}
  }

  void signUpWithEmail() async {
    if (!formkey.currentState!.validate()) return;
    // if (!isAgreed) {
    //   toast("Please agree to our terms and conditions");
    //   return;
    // }
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      //await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      FirebaseAuth.instance.currentUser!.reload();
      addUser(FirebaseAuth.instance.currentUser!.uid);
      signInMode = true;
      update();
    } on FirebaseAuthException catch (e) {
      toast(e.message);

      return;
    } finally {
      //hideLoader();
    }

    toast("Registered Successfully, Please verify your email.");
  }

  void signInWihGoogle() async {
    //showLoader();
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      toast(e.code);
    } on PlatformException catch (e) {
      toast(e.message);
    } finally {
      //addUser();
      afterFirebaseAuth();
    }
  }

  void afterFirebaseAuth() async {
    var app = AppService.to;
    if (app.fireUser == null) {
      // hideLoader();
      return;
    } else {
      Get.offAllNamed(RouteConst.list);
    }
    // var pid = app.fireUser!.providerData[0].providerId;
    // if (!app.fireUser!.emailVerified && pid != 'facebook.com') {
    //   toast('Please verify your email.');
    //   FirebaseAuth.instance.signOut();
    //   // hideLoader();
    //   return;
    // }

    // if (!await loadUser(false)) {
    //   FirebaseAuth.instance.signOut();
    //   hideLoader();
    //   return;
    // }
    // signUpdetails();
    // if (!app.user!.twoFactorEnable) {
    //   Prefs.setBool(PrefsConst.is2FAVerified, false);
    // }

    //  hideLoader();
  }
}
