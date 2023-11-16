import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:toyskart/core/constants/routes.dart';
import 'package:toyskart/global/app_back_button.dart';
import 'package:toyskart/global/app_service.dart';
import 'package:toyskart/global/debounce.dart';
import 'package:toyskart/pages/user_info/address/bottom_view.dart';

import '../../../core/constants/colors.dart';
import 'controller.dart';

class CheckOut extends GetView<CheckoutController> {
  const CheckOut({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        //backgroundColor: ColorConst.background,

        //extendBody: true,
        // drawer: const AppDrawer(),
        appBar: AppBar(
          backgroundColor: ColorConst.primary,
          leading: const AppBackButton(),
          title: const Text(
            'Checkout',
          ),
          //  actions: const [AppSearchButton(), AppCartButton()],
        ),
        body: GetBuilder<CheckoutController>(builder: (ctrl) {
          if (controller.selectedItemList.isEmpty) {
            return Obx(() => Center(
                  child: Container(
                      height: 100,
                      margin: const EdgeInsets.only(top: 0, left: 0, bottom: 0),
                      child: AppService.to.inRequest()
                          ? Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Center(
                                  child: JumpingDotsProgressIndicator(
                                numberOfDots: 4,
                                fontSize: 60.0,
                                color: ColorConst.primary,
                              )),
                            )
                          : Text(
                              'No Items Found',
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xffB3B3BF)),
                            )),
                ));
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Obx(
                  () => AppService.to.selectedAddress.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 15),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            minVerticalPadding: 0,
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Delivery address",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: ColorConst.primary,
                                      fontSize: 16,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "${AppService.to.selectedAddress[0].address1}, ${AppService.to.selectedAddress[0].address2}, ${AppService.to.selectedAddress[0].city}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: ColorConst.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: InkWell(
                                      onTap: () {
                                        Get.bottomSheet(const BuildSheet());
                                      },
                                      child: Text(
                                        'Change address',
                                        style: TextStyle(
                                          color:
                                              ColorConst.black.withOpacity(0.9),
                                          fontSize: 14,
                                          letterSpacing: 0.4,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(),
                ),
                const Divider(
                  color: ColorConst.primary,
                  thickness: 0.8,
                ),
                SizedBox(
                  height: 250,
                  child: ListView.builder(
                      itemCount: controller.selectedItemList.length,
                      itemBuilder: (context, index) {
                        var a = controller.selectedItemList[index];
                        return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            //height: 20,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        a.productName,
                                        style: const TextStyle(
                                            color: ColorConst.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "\u{20B9}${(a.productPrice)}",
                                        style: const TextStyle(
                                            color: ColorConst.primary,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        height: 30,
                                        //  width: 20,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 0),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: ColorConst.primary,
                                          ),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(20),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              child: const Icon(
                                                Icons.remove_circle_outline,
                                                color: ColorConst.primary,
                                                size: 18,
                                              ),
                                              onTap: () async {
                                                final debouncer = Debouncer(
                                                    milliseconds: 500);
                                                debouncer.run(() async {
                                                  if (a.itemCount > 0) {
                                                    await controller.addToCart(
                                                        a, false);
                                                  }
                                                });
                                              },
                                            ),
                                            Text(
                                              a.itemCount.toString(),
                                              style: const TextStyle(
                                                  color: ColorConst.primary,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            InkWell(
                                              child: const Icon(
                                                Icons.add_circle_outline,
                                                color: ColorConst.primary,
                                                size: 18,
                                              ),
                                              onTap: () async {
                                                final debouncer = Debouncer(
                                                    milliseconds: 500);
                                                debouncer.run(() async {
                                                  await controller.addToCart(
                                                      a, true);
                                                });
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "\u{20B9}${a.itemCount * a.productPrice}",
                                        style: const TextStyle(
                                            color: ColorConst.primary,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ));
                      }),
                ),

                // ],
                //  ),
                const SizedBox(
                  height: 15,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      child: Container(
                        //alignment: Alignment.bottomRight,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorConst.primary,
                            ),
                            borderRadius: const BorderRadius.only()),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 300,
                              height: 40,
                              child: ListTile(
                                title: const Text(
                                  " Total :",
                                  style: TextStyle(
                                      color: ColorConst.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                trailing: Text(
                                  " \u{20B9}${controller.total}",
                                  style: const TextStyle(
                                      color: ColorConst.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 300,
                              height: 40,
                              child: ListTile(
                                title: const Text(
                                  " GST :",
                                  style: TextStyle(
                                      color: ColorConst.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                trailing: Text(
                                  " ${(controller.gst * 100).toInt()} %",
                                  style: const TextStyle(
                                      color: ColorConst.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 300,
                              height: 40,
                              child: ListTile(
                                title: const Text(
                                  "Delivery Charge :",
                                  style: TextStyle(
                                      color: ColorConst.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                trailing: Text(
                                  " \u{20B9}${controller.deliveryCharge}",
                                  style: const TextStyle(
                                      color: ColorConst.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            const Divider(
                              color: ColorConst.primary,
                              thickness: 0.8,
                            ),
                            SizedBox(
                              width: 300,
                              height: 40,
                              child: ListTile(
                                title: const Text(
                                  "Grand Total :",
                                  style: TextStyle(
                                      color: ColorConst.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                trailing: Text(
                                  " \u{20B9}${controller.grandTotal}",
                                  style: const TextStyle(
                                      color: ColorConst.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),

                if (AppService.to.globalAaddressList.isNotEmpty &&
                    AppService.to.selectedAddress.isEmpty) ...[
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                        onTap: () {
                          Get.bottomSheet(const BuildSheet());
                        },
                        child: Container(
                          height: 50,
                          margin: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          width: double.infinity,
                          color: ColorConst.primary,
                          child: const Text(
                            'Select Address',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: ColorConst.white),
                          ),
                        ),
                      ))
                ],
                if (AppService.to.globalAaddressList.isEmpty) ...[
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(
                          RouteConst.address,
                        );
                        // controller.placeOrder();
                      },
                      child: Container(
                        height: 50,
                        margin: const EdgeInsets.all(5),
                        alignment: Alignment.center,
                        width: double.infinity,
                        color: ColorConst.primary,
                        child: const Text(
                          'Add Address',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: ColorConst.white),
                        ),
                      ),
                    ),
                  )
                ],
                if (AppService.to.globalAaddressList.isNotEmpty &&
                    AppService.to.selectedAddress.isNotEmpty) ...[
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConst.primary,
                            elevation: 0,
                            minimumSize: Size(screenWidth, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2.0),
                            ),
                          ),
                          child: Text(
                            'Pay \u{20B9}${controller.grandTotal} ',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: ColorConst.white),
                          ),
                          onPressed: () async {
                            controller.placeOrder();
                          }),
                    ),
                  ),
                ],
                const SizedBox(
                  height: 8,
                )
              ],
            ),
          );
        }));
  }
}
