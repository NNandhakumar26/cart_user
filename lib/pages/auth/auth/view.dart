import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:toyskart/core/constants/assets.dart';
import 'package:toyskart/core/utils/loader.dart';
import 'package:toyskart/pages/auth/auth/controller.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: GetBuilder<AuthPageController>(
      initState: (_) {},
      builder: (_) {
        return Container(
          child: Stack(
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
                padding: const EdgeInsets.only(left: 10, right: 10, top: 35),
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius:
                        const BorderRadius.only(topLeft: Radius.circular(40))),
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.45 - 20),
                height: MediaQuery.of(context).size.height * 0.60,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                    child: Form(
                  key: _.formkey,
                  child: Column(
                    children: [
                      // Text(isLoginWithEmail ? '${AppLocalizations.of(context).tle_login_with}' : '${AppLocalizations.of(context).txt_provide_number_desc}', style: Theme.of(context).textTheme.bodyText1),
                      const Padding(
                        padding: EdgeInsets.only(top: 2, bottom: 20),
                        child: Text("Login or Sign Up",
                            style:
                                TextStyle(color: Colors.black, fontSize: 20)),
                      ),
                      const SizedBox(
                        height: 50,
                      ),

                      Container(
                        height: 100,
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(0.0))),
                        padding: const EdgeInsets.only(),
                        child: IntlPhoneField(
                          decoration: const InputDecoration(
                            hintText: 'Phone Number',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          initialCountryCode: 'IN',
                          showDropdownIcon: true,
                          //6 disableLengthCheck: true,
                          onChanged: (phone) {
                            print(phone.completeNumber);
                            _.mobile.text = phone.completeNumber;
                            _.update();
                          },
                        ),
                      ),

                      Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
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
                          onPressed: () async {
                            showLoader();
                            _.sendOtp();
                          },
                          child: const Text('Generate OTP',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                        ),
                      ),
                    ],
                  ),
                )),
              )
            ],
          ),
        );
      },
    ));
  }
}
