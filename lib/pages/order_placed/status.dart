import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyskart/core/constants/routes.dart';
import 'package:toyskart/global/functions/global_functions.dart';

import '../../../../core/constants/assets.dart';
import '../../../../core/constants/colors.dart';

class PaymentStatus extends StatefulWidget {
  const PaymentStatus({
    Key? key,
  }) : super(key: key);

  @override
  State<PaymentStatus> createState() => _PaymentStatusState();
}

class _PaymentStatusState extends State<PaymentStatus> {
  @override
  void initState() {
    // TODO: implement initState
    //_startTimer();
    super.initState();
  }

  int _counter = 30;

  late Timer _timer;

  void _startTimer() {
    _counter = 5;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        // setState(() {
        _counter--;
        // });
      } else {
        Get.offAllNamed(RouteConst.list);
        _timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = kIsWeb ? 400 : MediaQuery.of(context).size.width;
    double screenHeight = kIsWeb ? 400 : MediaQuery.of(context).size.height;

    // var d = widget.data['paymentId'];
    // if (widget.status == 'failure') {
    //   // _startTimer();
    //   delay(5000).then((value) => Get.offNamed(RouteConst.cart));
    // } else if (widget.status == 'success') {
    //   paymentStatus(widget.data);
    // }

    return Scaffold(
        backgroundColor: ColorConst.background,
        appBar: AppBar(
          backgroundColor: ColorConst.background,
          leading: Container(),
          centerTitle: true,
          title: const Text(
            'Order Status',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: Image.asset(
                      AssetConst.success,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight * 0.1),

                      const Text(
                        "Thank You!",
                        style: TextStyle(
                          color: ColorConst.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 36,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      const Text(
                        "Order placed Successfully",
                        style: TextStyle(
                          color: ColorConst.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      const Text(
                        "You will be redirected to the Our Menu shortly\nor click here to return to Our Menu",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ColorConst.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.06),
                      InkWell(
                        onTap: () async {
                          await getCartDetails();
                          Get.offNamed(RouteConst.home);
                        },
                        child: Container(
                          height: 50,
                          margin: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          width: double.infinity,
                          color: ColorConst.primary,
                          child: const Text(
                            'Our Menu',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: ColorConst.white),
                          ),
                        ),
                      )
                      // Flexible(
                      //   child: HomeButton(
                      //     title: 'Home',
                      //     onTap: () {},
                      //   ),
                      // ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 200),
              ],
            ),
          ),
        ));
  }
}
