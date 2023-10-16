// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:toyskart/core/constants/assets.dart';
// import 'package:toyskart/global/style.dart';

// import '../../../core/constants/colors.dart';
// import 'controller.dart';

// class AllOrderList extends GetView<AllOrderListListController> {
//   const AllOrderList({Key? key, required this.type, required this.nextState})
//       : super(key: key);
//   final String type;
//   final String nextState;
//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//     return GetBuilder<AllOrderListListController>(initState: (state) async {
//       await controller.getOrders(type);
//     }, builder: (ctrl) {
//       return Material(
//           //backgroundColor: ColorConst.background,

//           child: Obx((() => controller.allOrders.isEmpty
//               ? Center(
//                   child: Container(
//                     color: ColorConst.background,
//                     child: const Center(
//                       child: Text(
//                         'No Orders found.',
//                         style: TextStyle(color: ColorConst.black, fontSize: 20),
//                       ),
//                     ),
//                   ),
//                 )
//               : Container(
//                   color: ColorConst.background,

//                   // height: 400,
//                   child: SizedBox(
//                     height: screenHeight * .8,
//                     child: ListView.builder(
//                         itemCount: controller.allOrders.length,
//                         itemBuilder: (context, index) {
//                           var item = controller.allOrders[index];
//                           return Container(
//                             margin: const EdgeInsets.only(
//                                 right: 25, left: 20, top: 25),
//                             decoration: BoxDecoration(
//                               image: DecorationImage(
//                                 opacity: 0.9,
//                                 image: AssetImage(type == "New"
//                                     ? AssetConst.newOrder
//                                     : type == "Accepted"
//                                         ? AssetConst.cooking
//                                         : type == "On the way"
//                                             ? AssetConst.out
//                                             : type == "Delivered"
//                                                 ? AssetConst.done
//                                                 : AssetConst.done),
//                                 fit: BoxFit.cover,
//                               ),
//                               borderRadius: BorderRadius.circular(20),
//                               boxShadow: const [
//                                 BoxShadow(
//                                     blurRadius: 10, color: ColorConst.grey3)
//                               ],
//                               color: ColorConst.grey3,
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.only(
//                                           top: 25, left: 20),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           SizedBox(
//                                             child: PrimaryText(
//                                                 text: 'Orde ID: ${item.id}',
//                                                 size: 14,
//                                                 color: ColorConst.black,
//                                                 fontWeight: FontWeight.w700),
//                                           ),
//                                           SizedBox(
//                                             child: PrimaryText(
//                                                 height: 1.5,
//                                                 text:
//                                                     'Ordered Time: ${controller.dateAsReadable(item.orderedTime, format: 'dd-MM-yyyy @ hh:mm a')}',
//                                                 size: 14,
//                                                 color: ColorConst.black,
//                                                 fontWeight: FontWeight.w700),
//                                           ),
//                                           // SizedBox(
//                                           //   child: PrimaryText(
//                                           //       height: 1.5,
//                                           //       text:
//                                           //           'Delivered Time: ${controller.dateAsReadable(item.orderedTime, format: 'dd-MM-yyyy @ hh:mm a')}',
//                                           //       size: 14,
//                                           //       color: ColorConst.black,
//                                           //       fontWeight:
//                                           //           FontWeight.w700),
//                                           // ),
//                                           SizedBox(
//                                             child: PrimaryText(
//                                                 height: 1.5,
//                                                 text:
//                                                     'Status: ${item.orderStatus}',
//                                                 size: 14,
//                                                 color: ColorConst.green,
//                                                 fontWeight: FontWeight.w700),
//                                           ),
//                                           const SizedBox(
//                                             height: 5,
//                                           ),
//                                           for (var a in item.items)
//                                             Container(
//                                               // height: 50,
//                                               width: screenWidth * .75,
//                                               margin: const EdgeInsets.all(2),
//                                               child: ListTile(
//                                                 contentPadding:
//                                                     const EdgeInsets.all(0),
//                                                 minVerticalPadding: 0,
//                                                 title: Text(
//                                                   a.name,
//                                                   style: const TextStyle(
//                                                       color: ColorConst.black,
//                                                       fontSize: 16,
//                                                       fontWeight:
//                                                           FontWeight.w600),
//                                                 ),
//                                                 subtitle: Text(
//                                                   "\u{20B9}${a.price}",
//                                                   style: const TextStyle(
//                                                       color: ColorConst.primary,
//                                                       fontSize: 14,
//                                                       fontWeight:
//                                                           FontWeight.w600),
//                                                 ),
//                                                 trailing: Text(
//                                                   "* ${a.count} =   \u{20B9}${a.itemTotal}",
//                                                   style: const TextStyle(
//                                                       color: ColorConst.primary,
//                                                       fontSize: 16,
//                                                       fontWeight:
//                                                           FontWeight.w600),
//                                                 ),
//                                               ),
//                                             ),
//                                         ],
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//                                   ],
//                                 ),
//                                 Column(
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.end,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.end,
//                                       children: [
//                                         nextState != "Done"
//                                             ? Expanded(
//                                                 flex: 1,
//                                                 child: TextButton(
//                                                   child: Text(
//                                                     nextState,
//                                                     style: const TextStyle(
//                                                         color:
//                                                             ColorConst.primary,
//                                                         fontSize: 15),
//                                                   ),
//                                                   onPressed: () {
//                                                     controller
//                                                             .singleOrderStatus =
//                                                         nextState;
//                                                     controller.updateproductStatus(
//                                                         item.id,
//                                                         nextState == 'Accept'
//                                                             ? 'Accepted'
//                                                             : nextState,
//                                                         item.userId);
//                                                     controller.update();
//                                                   },
//                                                 ))
//                                             : const Spacer(),
//                                         Expanded(
//                                           flex: 1,
//                                           child: InkWell(
//                                             child: Container(
//                                               //alignment: Alignment.bottomRight,
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                       horizontal: 20,
//                                                       vertical: 10),
//                                               decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                     color: ColorConst.primary,
//                                                   ),
//                                                   borderRadius:
//                                                       const BorderRadius.only(
//                                                     bottomRight:
//                                                         Radius.circular(20),
//                                                     topLeft:
//                                                         Radius.circular(20),
//                                                   )),
//                                               child: Column(
//                                                 children: [
//                                                   Text(
//                                                     " Total : \u{20B9}${item.total}",
//                                                     style: const TextStyle(
//                                                         color:
//                                                             ColorConst.primary,
//                                                         fontSize: 18,
//                                                         fontWeight:
//                                                             FontWeight.w600),
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           );
//                         }),
//                   ),
//                 ))));
//     });
//   }
// }
