import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:toyskart/core/constants/routes.dart';
import 'package:toyskart/global/app_service.dart';
import 'package:toyskart/global/style.dart';
import 'package:toyskart/global/widgets/cart_button.dart';
import 'package:toyskart/pages/user_info/address/views/view.dart';

import '../../../core/constants/colors.dart';
import 'controller.dart';

class AddressList extends GetView<AddressListController> {
  const AddressList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return GetBuilder<AddressListController>(
      initState: (state) async {
        await controller.getAddress();
        controller.mobile.text = AppService.to.loggedUser[0].phoneNumber;
      },
      builder: (ctrl) {
        return Scaffold(
            //backgroundColor: ColorConst.background,

            //  extendBody: true,
            appBar: AppBar(
              backgroundColor: ColorConst.primary,
              leading: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.chevron_left,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Get.offNamed(RouteConst.home);
                  }),
              title: const Text(
                'My Address',
              ),
              actions: [
                InkWell(
                  onTap: () {
                    controller.isEditToogle = false;
                    controller.address1.clear();
                    controller.address2.clear();
                    controller.landMark.clear();
                    controller.mobile.clear();
                    controller.city.clear();
                    controller.state.clear();
                    controller.pinCode.clear();
                    controller.isSelected.value = false;
                    controller.isEditToogle = false;
                    controller.update();

                    Get.to(() => const ModifyAddress(), arguments: null);
                  },
                  child: const Icon(
                    Icons.add_location_alt_outlined,
                    color: ColorConst.white,
                    size: 25,
                  ),
                ),
                const CartButton(),
              ],
            ),
            body: Obx((() => controller.addressList.isEmpty
                ? Obx(() => Center(
                      child: Container(
                          height: 100,
                          margin:
                              const EdgeInsets.only(top: 0, left: 0, bottom: 0),
                          child: AppService.to.inRequest()
                              ? Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Center(
                                        child: JumpingDotsProgressIndicator(
                                      numberOfDots: 4,
                                      fontSize: 60.0,
                                      color: ColorConst.primary,
                                    )),
                                  ),
                                )
                              : Text(
                                  'No Address Found',
                                  textAlign: TextAlign.justify,
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xffB3B3BF)),
                                )),
                    ))
                : Container(
                    color: ColorConst.background,

                    // height: 400,
                    child: Column(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: screenHeight * .7,
                            child: ListView.builder(
                                itemCount: controller.addressList.length,
                                itemBuilder: (context, index) {
                                  var item = controller.addressList[index];
                                  return Container(
                                    margin: const EdgeInsets.only(
                                        right: 25, left: 20, top: 25),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 10,
                                            color: item.defaultAddress
                                                ? ColorConst.green
                                                : ColorConst.grey3)
                                      ],
                                      color: ColorConst.white,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 25, left: 20),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    child: PrimaryText(
                                                        text: item.fullName,
                                                        size: 16,
                                                        color: ColorConst.black,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  SizedBox(
                                                    // width:
                                                    //     MediaQuery.of(context)
                                                    //             .size
                                                    //             .width /
                                                    //         2.2,
                                                    child: PrimaryText(
                                                        text:
                                                            '${item.address1}, ${item.address2}',
                                                        size: 16,
                                                        color: ColorConst.black,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  SizedBox(
                                                    child: PrimaryText(
                                                        text: item.landMark,
                                                        size: 16,
                                                        color: ColorConst.black,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: PrimaryText(
                                                            text: item.phoneNo,
                                                            size: 16,
                                                            color: ColorConst
                                                                .black,
                                                          ),
                                                        ),
                                                        TextButton(
                                                            onPressed: () {
                                                              controller
                                                                  .setAddress(
                                                                      item);
                                                            },
                                                            child: const Text(
                                                              'Edit',
                                                              style: TextStyle(
                                                                color: ColorConst
                                                                    .primary,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            )),
                                                        TextButton(
                                                            onPressed: () {
                                                              controller
                                                                  .deletePopUp(
                                                                      context,
                                                                      item.id);
                                                            },
                                                            child: const Text(
                                                              'Delete',
                                                              style: TextStyle(
                                                                color: ColorConst
                                                                    .primary,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            )),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                        // Container(
                                        //   transform: Matrix4.translationValues(30.0, 25.0, 0.0),
                                        //   decoration: BoxDecoration(
                                        //       borderRadius: BorderRadius.circular(50),
                                        //       boxShadow: [
                                        //         BoxShadow(color: Colors.grey[400], blurRadius: 20)
                                        //       ]),
                                        //   child: Hero(
                                        //     tag: imagePath,
                                        //     child: Image.asset(imagePath,
                                        //         width: MediaQuery.of(context).size.width / 2.9),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ),
                      ],
                    ),
                  ))));
      },
    );
  }
}
