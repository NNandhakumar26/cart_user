// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:toyskart/core/constants/routes.dart';
// import 'package:toyskart/global/app_drawer.dart';
// import 'package:toyskart/global/app_service.dart';
// import 'package:toyskart/pages/user_info/address/bottom_view.dart';

// import '../../../core/constants/colors.dart';
// import 'controller.dart';

// class Cart extends GetView<CartController> {
//   const Cart({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;

//     return GetBuilder<CartController>(
//       initState: (state) async {
//         await controller.setItem(Get.arguments);
//       },
//       builder: (ctrl) {
//         return Scaffold(
//             //backgroundColor: ColorConst.background,

//             extendBody: true,
//             drawer: const AppDrawer(),
//             appBar: AppBar(
//               title: const Text(
//                 'Cart',
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: ColorConst.black,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//               actions: const [],
//             ),
//             body: Obx((() => controller.selectedItemList.isEmpty
//                 ? Container(
//                     color: ColorConst.background,
//                     child: Column(
//                       children: [
//                         Expanded(
//                           child: Container(
//                             color: ColorConst.background,
//                             child: const Center(
//                               child: Text(
//                                 'Sorry.. Not Ready for Ordering.',
//                                 style: TextStyle(
//                                     color: ColorConst.black, fontSize: 20),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 : Container(
//                     color: ColorConst.background,

//                     // height: 400,
//                     child: Column(
//                       children: [
//                         AppService.to.selectedAddress.isNotEmpty
//                             ? Padding(
//                                 padding: const EdgeInsets.all(10.0),
//                                 child: ListTile(
//                                   contentPadding: const EdgeInsets.all(0),
//                                   minVerticalPadding: 0,
//                                   title: Text(
//                                     "${AppService.to.selectedAddress[0].address1}-${AppService.to.selectedAddress[0].address2}",
//                                     style: const TextStyle(
//                                         color: ColorConst.black,
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w600),
//                                   ),
//                                   subtitle: Text(
//                                     AppService.to.selectedAddress[0].address2,
//                                     style: const TextStyle(
//                                         color: ColorConst.primary,
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w600),
//                                   ),
//                                   trailing: TextButton(
//                                       onPressed: () {
//                                         Get.bottomSheet(const BuildSheet());
//                                       },
//                                       child: const Text(
//                                         'Change address',
//                                         style: TextStyle(
//                                           color: ColorConst.primary,
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       )),
//                                 ),

//                                 // Column(
//                                 //   mainAxisAlignment: MainAxisAlignment.start,
//                                 //   crossAxisAlignment: CrossAxisAlignment.start,
//                                 //   children: [
//                                 //     const Text(
//                                 //       'Delivery address',
//                                 //       textAlign: TextAlign.left,
//                                 //       style: TextStyle(color: ColorConst.black),
//                                 //     ),
//                                 //     DropdownButton<AddressModel>(
//                                 //       value: controller.defaultAddress,
//                                 //       icon: const Icon(Icons.arrow_drop_down),
//                                 //       iconSize: 24,
//                                 //       elevation: 16,
//                                 //       isExpanded: true,
//                                 //       dropdownColor: ColorConst.background,
//                                 //       style: const TextStyle(color: ColorConst.black),
//                                 //       // style: const TextStyle(color: Colors.deepPurple),
//                                 //       underline: Container(
//                                 //         height: 0,
//                                 //         color: Colors.grey,
//                                 //       ),
//                                 //       items: controller.addressList.map((item) {
//                                 //         return DropdownMenuItem(
//                                 //           value: item,
//                                 //           child: Text(
//                                 //             "${item.address1}-${item.address2}",
//                                 //             style: const TextStyle(
//                                 //                 color: ColorConst.black),
//                                 //           ),
//                                 //         );
//                                 //       }).toList(),
//                                 //       hint: const Text('Select Address',
//                                 //           style: TextStyle(color: Colors.white)),
//                                 //       onChanged: (Stringvalue) {
//                                 //         controller.defaultAddress = Stringvalue;
//                                 //         AppService.to.selectedAddress =
//                                 //             ((Stringvalue));
//                                 //         controller.update();
//                                 //       },
//                                 //     ),
//                                 //   ],
//                                 // ),
//                               )
//                             : Container(),
//                         Expanded(
//                           child: SizedBox(
//                             // height: screenHeight * .6,
//                             child: Container(
//                               margin: const EdgeInsets.only(
//                                   right: 25, left: 20, top: 25),
//                               // decoration: BoxDecoration(
//                               //   borderRadius: BorderRadius.circular(20),
//                               //   boxShadow: const [
//                               //     BoxShadow(
//                               //         blurRadius: 10, color: ColorConst.grey3)
//                               //   ],
//                               //   color: ColorConst.white,
//                               // ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       for (var a
//                                           in controller.selectedItemList)
//                                         Container(
//                                             // height: 50,
//                                             // width: screenWidth * .75,
//                                             margin: const EdgeInsets.all(2),
//                                             child: ListTile(
//                                               title: Text(
//                                                 a.name,
//                                                 style: const TextStyle(
//                                                     color: ColorConst.black,
//                                                     fontSize: 18,
//                                                     fontWeight:
//                                                         FontWeight.w600),
//                                               ),
//                                               subtitle: Text(
//                                                 a.count.toString() +
//                                                     '*' +
//                                                     "\u{20B9}${a.price}",
//                                                 style: const TextStyle(
//                                                     color: ColorConst.primary,
//                                                     fontSize: 12,
//                                                     fontWeight:
//                                                         FontWeight.w600),
//                                               ),
//                                               trailing: Text(
//                                                 "\u{20B9}${a.count * int.parse(a.price)}",
//                                                 style: const TextStyle(
//                                                     color: ColorConst.primary,
//                                                     fontSize: 18,
//                                                     fontWeight:
//                                                         FontWeight.w600),
//                                               ),
//                                             )),
//                                     ],
//                                   ),
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   Column(
//                                     children: [
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.end,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.end,
//                                         children: [
//                                           const Spacer(),
//                                           const SizedBox(
//                                             width: 25,
//                                           ),
//                                           Expanded(
//                                             flex: 1,
//                                             child: InkWell(
//                                               child: Container(
//                                                 //alignment: Alignment.bottomRight,
//                                                 padding:
//                                                     const EdgeInsets.symmetric(
//                                                         horizontal: 20,
//                                                         vertical: 10),
//                                                 decoration: BoxDecoration(
//                                                     border: Border.all(
//                                                       color: ColorConst.primary,
//                                                     ),
//                                                     borderRadius:
//                                                         const BorderRadius.only(
//                                                       bottomRight:
//                                                           Radius.circular(20),
//                                                       topLeft:
//                                                           Radius.circular(20),
//                                                     )),
//                                                 child: Column(
//                                                   children: [
//                                                     Text(
//                                                       " Total : \u{20B9}${controller.total}",
//                                                       style: const TextStyle(
//                                                           color: ColorConst
//                                                               .primary,
//                                                           fontSize: 18,
//                                                           fontWeight:
//                                                               FontWeight.w600),
//                                                     )
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         if (AppService.to.globalAaddressList.isNotEmpty &&
//                             AppService.to.selectedAddress.isEmpty) ...[
//                           Align(
//                               alignment: Alignment.bottomCenter,
//                               child: InkWell(
//                                 onTap: () {
//                                   Get.bottomSheet(const BuildSheet());
//                                 },
//                                 child: Container(
//                                   height: 50,
//                                   margin: const EdgeInsets.all(5),
//                                   alignment: Alignment.center,
//                                   width: double.infinity,
//                                   color: ColorConst.primary,
//                                   child: const Text(
//                                     'Select Address',
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.w600,
//                                         color: Color(0xff140E36)),
//                                   ),
//                                 ),
//                               ))
//                         ],
//                         if (AppService.to.globalAaddressList.isEmpty) ...[
//                           Align(
//                             alignment: Alignment.bottomCenter,
//                             child: InkWell(
//                               onTap: () {
//                                 Get.toNamed(RouteConst.selectLocation,
//                                     parameters: {'flag': "1"});
//                                 // controller.placeOrder();
//                               },
//                               child: Container(
//                                 height: 50,
//                                 margin: const EdgeInsets.all(5),
//                                 alignment: Alignment.center,
//                                 width: double.infinity,
//                                 color: ColorConst.primary,
//                                 child: const Text(
//                                   'Add Address',
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.w600,
//                                       color: Color(0xff140E36)),
//                                 ),
//                               ),
//                             ),
//                           )
//                         ],
//                         if (AppService.to.globalAaddressList.isNotEmpty &&
//                             AppService.to.selectedAddress.isNotEmpty) ...[
//                           Align(
//                             alignment: Alignment.bottomCenter,
//                             child: Row(
//                               children: [
//                                 Container(
//                                   height: 50,
//                                   margin: const EdgeInsets.all(5),
//                                   alignment: Alignment.center,
//                                   width: 100, //double.infinity,
//                                   // color: ColorConst.primary,
//                                   child: DropdownButtonFormField(
//                                     decoration: InputDecoration(
//                                         isDense: true,
//                                         prefix: const SizedBox(
//                                           width: 15,
//                                         ),
//                                         contentPadding: const EdgeInsets.only(
//                                             top: 14, right: 14, bottom: 14),
//                                         hintText: 'Type',
//                                         hintStyle: const TextStyle(
//                                           color: ColorConst.grey3,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w400,
//                                         ),
//                                         //alignLabelWithHint: true,
//                                         border: OutlineInputBorder(
//                                           borderSide: const BorderSide(
//                                               color: ColorConst.black),
//                                           borderRadius:
//                                               BorderRadius.circular(4.0),
//                                         ),
//                                         errorBorder: OutlineInputBorder(
//                                           borderSide: const BorderSide(
//                                             color: Colors.red,
//                                           ),
//                                           borderRadius:
//                                               BorderRadius.circular(4.0),
//                                         ),
//                                         focusedBorder: OutlineInputBorder(
//                                           borderSide: const BorderSide(
//                                               color: ColorConst.black),
//                                           borderRadius:
//                                               BorderRadius.circular(4.0),
//                                         ),
//                                         enabledBorder: OutlineInputBorder(
//                                           borderSide: const BorderSide(
//                                               color: ColorConst.black),
//                                           borderRadius:
//                                               BorderRadius.circular(4.0),
//                                         ),
//                                         fillColor: Colors.transparent,
//                                         filled: true),
//                                     value: controller.paymentMode,
//                                     elevation: 0,
//                                     dropdownColor: ColorConst.background,
//                                     style: const TextStyle(color: Colors.black),
//                                     onChanged: (String? newValue) {
//                                       controller.paymentMode = newValue!;
//                                       // if (newValue == 'Veg') {
//                                       //   controller.type = "1";
//                                       //   controller.dt = 'Veg';
//                                       // } else {
//                                       //   controller.type = "2";
//                                       //   controller.dt = 'Non-Veg';
//                                       // }
//                                       controller.update();
//                                     },
//                                     items: <String>['Online', 'Cash']
//                                         .map<DropdownMenuItem<String>>(
//                                             (String value) {
//                                       return DropdownMenuItem<String>(
//                                         value: value,
//                                         child: Center(
//                                           child: Text(
//                                             value,
//                                             style: const TextStyle(
//                                                 color: ColorConst.primary),
//                                           ),
//                                         ),
//                                       );
//                                     }).toList(),
//                                   ),
//                                 ),

//                                 ElevatedButton(
//                                     style: ElevatedButton.styleFrom(
//                                       primary: ColorConst.primary,
//                                       elevation: 0,
//                                       minimumSize: Size(screenWidth - 115, 50),
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(2.0),
//                                       ),
//                                     ),
//                                     child: Text(
//                                       'Pay \u{20B9}${controller.total} ${controller.paymentMode == "Cash" ? " on delivery" : ''}',
//                                       textAlign: TextAlign.center,
//                                       style: const TextStyle(
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.w600,
//                                           color: Color(0xff140E36)),
//                                     ),
//                                     onPressed: () async {
//                                       controller.placeOrder();
//                                     }),
//                                 // InkWell(
//                                 //   onTap: () {
//                                 //     // Get.toNamed(RouteConst.checkout);
//                                 //     controller.placeOrder();
//                                 //   },
//                                 //   child: Container(
//                                 //     height: 50,
//                                 //     margin: const EdgeInsets.all(5),
//                                 //     alignment: Alignment.center,
//                                 //     width: double.minPositive,
//                                 //     color: ColorConst.primary,
//                                 //     child: Text(
//                                 //       'Pay \u{20B9}${controller.total}',
//                                 //       textAlign: TextAlign.center,
//                                 //       style: const TextStyle(
//                                 //           fontSize: 20,
//                                 //           fontWeight: FontWeight.w600,
//                                 //           color: Color(0xff140E36)),
//                                 //     ),
//                                 //   ),
//                                 // ),
//                               ],
//                             ),
//                           ),
//                         ]
//                       ],
//                     ),
//                   ))));
//       },
//     );
//   }
// }
