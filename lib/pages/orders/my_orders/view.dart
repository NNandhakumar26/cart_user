import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:toyskart/global/app_cart_button.dart';
import 'package:toyskart/global/app_service.dart';
import 'package:toyskart/global/functions/willpop.dart';
import 'package:toyskart/global/style.dart';
import 'package:toyskart/global/widgets/botton_navigation/botton_navigation.dart';

import '../../../core/constants/colors.dart';
import 'controller.dart';

class MyOrderList extends GetView<MyOrderListController> {
  const MyOrderList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return GetBuilder<MyOrderListController>(initState: (state) async {
      await controller.getOrders();
    }, builder: (ctrl) {
      return Scaffold(
          //backgroundColor: ColorConst.background,

          // extendBody: true,
          // drawer: const AppDrawer(),
          appBar: AppBar(
            backgroundColor: ColorConst.primary,
            // leading: const AppBackButton(),
            title: const Text(
              'My Orders',
            ),
            actions: const [AppCartButton()],
          ),
          bottomNavigationBar: SizedBox(
            height: 70,
            child: BottomNavCustom(indexValue: 2),
          ),
          body: Theme(
              data: Theme.of(context),
              child: WillPopScope(
                  onWillPop: () async {
                    return backPressed(context);
                  },
                  child: controller.myOrders.isEmpty
                      ? Obx(() => Center(
                            child: Container(
                                height: 100,
                                margin: const EdgeInsets.only(
                                    top: 0, left: 0, bottom: 0),
                                child: AppService.to.inRequest()
                                    ? Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Center(
                                              child:
                                                  JumpingDotsProgressIndicator(
                                            numberOfDots: 4,
                                            fontSize: 60.0,
                                            color: ColorConst.primary,
                                          )),
                                        ),
                                      )
                                    : Text(
                                        'No Items Found',
                                        textAlign: TextAlign.justify,
                                        style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xffB3B3BF)),
                                      )),
                          ))
                      : RefreshIndicator(
                          onRefresh: () async {
                            controller.getOrders();
                          },

                          // height: 400,
                          child: ListView.builder(
                              itemCount: controller.myOrders.length,
                              itemBuilder: (context, index) {
                                var item = controller.myOrders[index];
                                return InkWell(
                                  onTap: () {
                                    if (controller.exandingId == item.id) {
                                      controller.exandingId = null;
                                    } else {
                                      controller.exandingId = item.id;
                                    }
                                    controller.update();
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        right: 25,
                                        left: 20,
                                        top: 10,
                                        bottom: 15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: const [
                                        BoxShadow(
                                            blurRadius: 10,
                                            color: ColorConst.grey3)
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
                                                  // SizedBox(
                                                  //   child: PrimaryText(
                                                  //       text:
                                                  //           'Orde ID: ${item.id}',
                                                  //       size: 14,
                                                  //       color: ColorConst.black,
                                                  //       fontWeight:
                                                  //           FontWeight.w700),
                                                  // ),
                                                  SizedBox(
                                                    child: PrimaryText(
                                                        height: 1.5,
                                                        text:
                                                            'Ordered Time: ${controller.dateAsReadable(item.orderDate, format: 'dd-MM-yyyy @ hh:mm a')}',
                                                        size: 14,
                                                        color: ColorConst.black,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  // SizedBox(
                                                  //   child: PrimaryText(
                                                  //       height: 1.5,
                                                  //       text:
                                                  //           'Delivered Time: ${controller.dateAsReadable(item.orderedTime, format: 'dd-MM-yyyy @ hh:mm a')}',
                                                  //       size: 14,
                                                  //       color: ColorConst.black,
                                                  //       fontWeight:
                                                  //           FontWeight.w700),
                                                  // ),
                                                  SizedBox(
                                                    child: PrimaryText(
                                                        height: 1.5,
                                                        text:
                                                            'Status: ${item.productStatusUpdate()}',
                                                        size: 14,
                                                        color: ColorConst.green,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  for (var a
                                                      in item.productsName)
                                                    Container(
                                                      // height: 50,
                                                      width: screenWidth * .75,
                                                      margin:
                                                          const EdgeInsets.all(
                                                              2),
                                                      child: ListTile(
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        minVerticalPadding: 0,
                                                        title: Text(
                                                          a.name,
                                                          style: const TextStyle(
                                                              color: ColorConst
                                                                  .black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        subtitle: Text(
                                                          "\u{20B9}${a.actualAmount} X ${a.itemCount}",
                                                          style: const TextStyle(
                                                              color: ColorConst
                                                                  .primary,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        trailing: Text(
                                                          "\u{20B9}${a.itemCount * a.actualAmount}",
                                                          style: const TextStyle(
                                                              color: ColorConst
                                                                  .primary,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                        if (controller.exandingId ==
                                            item.id) ...[
                                          InkWell(
                                            child: Container(
                                              //alignment: Alignment.bottomRight,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 10),
                                              // decoration: BoxDecoration(
                                              //     border: Border.symmetric(
                                              //       vertical: BorderSide.none,
                                              //       horizontal: BorderSide.lerp(
                                              //           1.0, 1, 1),
                                              //       //  color: ColorConst.primary,
                                              //     ),
                                              //     borderRadius:
                                              //         const BorderRadius
                                              //                 .horizontal(
                                              //             left: Radius.zero,
                                              //             right: Radius.zero)),

                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Divider(
                                                      color: ColorConst.primary,
                                                      thickness: 1),
                                                  SizedBox(
                                                    width: 300,
                                                    height: 40,
                                                    child: ListTile(
                                                      title: const Text(
                                                        " Ordered Amount :",
                                                        style: TextStyle(
                                                            color: ColorConst
                                                                .black,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      trailing: Text(
                                                        " \u{20B9}${item.orderAmount}",
                                                        style: const TextStyle(
                                                            color: ColorConst
                                                                .black,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
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
                                                            color: ColorConst
                                                                .black,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      trailing: Text(
                                                        " ${(item.gstAmount)} %",
                                                        style: const TextStyle(
                                                            color: ColorConst
                                                                .black,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
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
                                                            color: ColorConst
                                                                .black,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      trailing: Text(
                                                        " \u{20B9}${item.deliveryCharge}",
                                                        style: const TextStyle(
                                                            color: ColorConst
                                                                .black,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                  ),
                                                  const Divider(
                                                      color: ColorConst.primary,
                                                      thickness: 1),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  ElevatedButton(
                                                    style: OutlinedButton
                                                        .styleFrom(
                                                      foregroundColor:
                                                          ColorConst.white,
                                                      // backgroundColor:
                                                      //     const Color.fromRGBO(
                                                      //         230, 169, 25, 1),
                                                      minimumSize:
                                                          const Size.fromHeight(
                                                              32),
                                                      textStyle:
                                                          const TextStyle(
                                                              fontSize: 14),
                                                    ),
                                                    child: const Text(
                                                        'Get Receipt'),
                                                    onPressed: () {
                                                      controller
                                                          .createReceipt(item);
                                                    },
                                                  ),
                                                  //   width: 300,
                                                  //   height: 40,
                                                  //   child: ListTile(
                                                  //     title: const Text(
                                                  //       "Grand Total :",
                                                  //       style: TextStyle(
                                                  //           color: ColorConst.black,
                                                  //           fontSize: 18,
                                                  //           fontWeight:
                                                  //               FontWeight.w600),
                                                  //     ),
                                                  //     trailing: Text(
                                                  //       " \u{20B9}${item.totalAmount}",
                                                  //       style: const TextStyle(
                                                  //           color: ColorConst.black,
                                                  //           fontSize: 18,
                                                  //           fontWeight:
                                                  //               FontWeight.w600),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                        Row(
                                          children: [
                                            // Expanded(
                                            //     flex: 1,
                                            //     child: TextButton(
                                            //         onPressed: () {},
                                            //         child: const Text(
                                            //           'REORDER',
                                            //           style: TextStyle(
                                            //             color: ColorConst.primary,
                                            //             fontSize: 14,
                                            //             fontWeight: FontWeight.w600,
                                            //           ),
                                            //         ))),
                                            //Spacer(),
                                            Expanded(
                                              flex: 1,
                                              child: InkWell(
                                                child: Container(
                                                  //alignment: Alignment.bottomRight,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20,
                                                      vertical: 10),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color:
                                                            ColorConst.primary,
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        bottomRight:
                                                            Radius.circular(20),
                                                        bottomLeft:
                                                            Radius.circular(20),
                                                      )),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        " Total : \u{20B9}${item.totalAmount}",
                                                        style: const TextStyle(
                                                            color: ColorConst
                                                                .primary,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );

                                // Container(
                                //   //height: 150,
                                //   color: const Color(0xff1A1C3E),
                                //   margin: const EdgeInsets.all(10),
                                //   child: Row(
                                //     children: [
                                //       Container(
                                //         margin: const EdgeInsets.all(20),
                                //         child: Column(
                                //           mainAxisAlignment:
                                //               MainAxisAlignment.center,
                                //           crossAxisAlignment:
                                //               CrossAxisAlignment.start,
                                //           children: [
                                //             Text(
                                //               'Order Id : ${item.id}',
                                //               softWrap: true,
                                //               style: const TextStyle(
                                //                   color: ColorConst.black,
                                //                   fontSize: 16,
                                //                   fontWeight:
                                //                       FontWeight.w600),
                                //             ),

                                //             const SizedBox(height: 10),
                                //             Text(
                                //               'Address : ${item.address}',
                                //               softWrap: true,
                                //               style: const TextStyle(
                                //                   color: ColorConst.black,
                                //                   fontSize: 16,
                                //                   fontWeight:
                                //                       FontWeight.w600),
                                //             ),

                                //             const SizedBox(height: 10),
                                //             Text(
                                //               'Mobile : ${item.mobile}',
                                //               softWrap: true,
                                //               style: const TextStyle(
                                //                   color: ColorConst.black,
                                //                   fontSize: 16,
                                //                   fontWeight:
                                //                       FontWeight.w600),
                                //             ),
                                //             const SizedBox(height: 10),
                                //             Text(
                                //               'Order Status: ${item.orderStatus}',
                                //               softWrap: true,
                                //               style: const TextStyle(
                                //                   color: ColorConst.black,
                                //                   fontSize: 16,
                                //                   fontWeight:
                                //                       FontWeight.w600),
                                //             ),
                                //             const SizedBox(height: 10),
                                //             Text(
                                //               'Ordered Time: ${controller.dateAsReadable(item.orderedTime, format: 'dd-MMMM-yyyy @ hh:mm a')}',
                                //               softWrap: true,
                                //               style: const TextStyle(
                                //                   color: ColorConst.black,
                                //                   fontSize: 16,
                                //                   fontWeight:
                                //                       FontWeight.w600),
                                //             ),
                                //             for (var a in item.items)
                                //               Container(
                                //                 // height: 50,
                                //                 width: screenWidth * .75,
                                //                 margin:
                                //                     const EdgeInsets.all(2),
                                //                 child: ListTile(
                                //                   title: Text(
                                //                     a.name,
                                //                     style: const TextStyle(
                                //                         color:
                                //                             ColorConst.black,
                                //                         fontSize: 18,
                                //                         fontWeight:
                                //                             FontWeight.w600),
                                //                   ),
                                //                   subtitle: Text(
                                //                     a.count.toString() +
                                //                         '*' +
                                //                         "\u{20B9}${a.price}",
                                //                     style: const TextStyle(
                                //                         color: ColorConst
                                //                             .primary,
                                //                         fontSize: 14,
                                //                         fontWeight:
                                //                             FontWeight.w600),
                                //                   ),
                                //                   trailing: Text(
                                //                     "\u{20B9}${a.itemTotal}",
                                //                     style: const TextStyle(
                                //                         color: ColorConst
                                //                             .primary,
                                //                         fontSize: 18,
                                //                         fontWeight:
                                //                             FontWeight.w600),
                                //                   ),
                                //                 ),
                                //               ),
                                //             const SizedBox(height: 10),
                                //             Align(
                                //               alignment:
                                //                   Alignment.bottomRight,
                                //               child: Text(
                                //                 'Total: \u{20B9}${item.total}',
                                //                 softWrap: true,
                                //                 textAlign: TextAlign.right,
                                //                 style: const TextStyle(
                                //                     color: ColorConst.primary,
                                //                     fontSize: 16,
                                //                     fontWeight:
                                //                         FontWeight.w600),
                                //               ),
                                //             ),

                                //             // Text(
                                //             //   item.location,
                                //             //   style: const TextStyle(
                                //             //       color: ColorConst.black,
                                //             //       fontSize: 16,
                                //             //       fontWeight:
                                //             //           FontWeight.w600),
                                //             // ),
                                //           ],
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // );
                              }),
                        ))));
    });
  }
}
