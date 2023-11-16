import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:toyskart/core/constants/assets.dart';
import 'package:toyskart/core/constants/colors.dart';
import 'package:toyskart/pages/auth/auth/controller.dart';
import 'package:unicons/unicons.dart';

class OtpVerifyPage extends StatefulWidget {
  const OtpVerifyPage({super.key});

  @override
  State<OtpVerifyPage> createState() => _OtpVerifyPageState();
}

class _OtpVerifyPageState extends State<OtpVerifyPage>
    with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      // FirebaseAuth.instance.signOut();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isScrollable = MediaQuery.of(context).size.height < 600;

    return GetBuilder<AuthPageController>(
      builder: (_) {
        return Scaffold(
          //color: ColorConst.background,
          extendBody: true,
          // drawer: const AppDrawer(),
          // appBar: AppBar(
          //   leading: Container(
          //     padding: const EdgeInsets.only(left: 10),
          //     child: InkWell(
          //       // When the user taps the button, show a snackbar.
          //       onTap: () {
          //         Get.back();
          //       },
          //       child: const Padding(
          //         padding:
          //             EdgeInsets.only(top: 2, left: 0, right: 1, bottom: 1),
          //         child: Icon(
          //           UniconsLine.angle_left,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          body: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                height: MediaQuery.of(context).size.height * 0.50,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(AssetConst.loginBg),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 35),
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius:
                        const BorderRadius.only(topLeft: Radius.circular(40))),
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.45 - 20),
                height: MediaQuery.of(context).size.height * 0.60,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        //  height: 50,
                        padding: const EdgeInsets.only(left: 10),
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          // When the user taps the button, show a snackbar.
                          onTap: () {
                            Get.back();
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(
                                top: 2, left: 0, right: 1, bottom: 1),
                            child: Icon(
                              UniconsLine.angle_left,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const Text(
                        'Verify',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: ColorConst.black,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Enter the OTP we have sent',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(0.0))),
                        padding: const EdgeInsets.only(),
                        //decoration: const BoxDecoration(),
                        child: Column(
                          children: [
                            PinCodeTextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              length: 6,
                              autoFocus: true,
                              keyboardType: TextInputType.number,
                              obscureText: false,
                              cursorColor: ColorConst.primary,
                              animationType: AnimationType.fade,
                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(5),
                                fieldHeight: 50,
                                fieldWidth: 40,
                                activeFillColor:
                                    ColorConst.primary.withOpacity(0.5),
                                activeColor: Colors.grey,
                                selectedColor: Colors.grey,
                                inactiveColor: Colors.grey,
                                disabledColor: Colors.transparent,
                                selectedFillColor: Colors.transparent,
                                inactiveFillColor: Colors.transparent,
                              ),
                              animationDuration:
                                  const Duration(milliseconds: 300),
                              backgroundColor: Colors.transparent,
                              enableActiveFill: true,
                              controller: _.otpNumber,
                              onChanged: (value) {},
                              appContext: context,
                            ),
                            //const SizedBox(height: 24),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  gradient: LinearGradient(
                                      stops: const [0, .90],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Theme.of(context).primaryColorLight,
                                        Theme.of(context).primaryColor
                                      ])),
                              margin: const EdgeInsets.only(top: 20),
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                onPressed: _.otpNumber.text.length == 6
                                    ? () async {
                                        PhoneAuthCredential
                                            phoneAuthCredential =
                                            PhoneAuthProvider.credential(
                                                verificationId: _.verifyId,
                                                smsCode: _.otpNumber.text);

                                        _.signInWithPhoneAuthCredential(
                                            phoneAuthCredential);
                                      }
                                    : null,
                                child: const Text('Submit',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18)),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Didn`t receive OTP? ",
                                      style: TextStyle(
                                        letterSpacing: 1,
                                        fontWeight: FontWeight.w700,
                                        color: ColorConst.grey3,
                                      )),
                                  _.seconds != 0
                                      ? Text("Wait ${_.seconds}s",
                                          style: const TextStyle(
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.w700,
                                            color: ColorConst.grey3,
                                          ))
                                      : TextButton(
                                          onPressed: () async {
                                            await _.sendOtp(resend: true);
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.only(left: 0),
                                            child: Text('Resend OTP',
                                                style: TextStyle(
                                                  letterSpacing: 1,
                                                  fontWeight: FontWeight.w700,
                                                  color: ColorConst.grey3,
                                                )),
                                          ),
                                        )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
