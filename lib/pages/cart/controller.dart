// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:toyskart/core/constants/routes.dart';
// import 'package:toyskart/global/app_service.dart';
// import 'package:toyskart/global/toast.dart';
// import 'package:toyskart/pages/user_info/address/model.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';

// class CartController extends GetxController {
//   RxList<FoodsModel> selectedItemList = <FoodsModel>[].obs;
//   int total = 0;
//   AddressModel? defaultAddress;
//   String orderId = "";
//   String paymentMode = "Online";
//   Map<String, dynamic> docData = {};

//   RxList<AddressModel> addressList = <AddressModel>[].obs;
//   //RxList<AddressModel> finalFoodList = <AddressModel>[].obs;
//   //List<OrderModel> finalFoodList = [];
//   List<Map<String, dynamic>> temp = [];


//   setItem(items) async {
//     // selectedItemList = items;

//     // for (var item in selectedItemList) {
//     //   if (item.count > 0) {
//     //     total += item.count * int.parse(item.price);
//     //   }
//     // }
//     // update();
//   }

//   final Razorpay razorpay = Razorpay();
//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();

//     razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     razorpay.clear();
//   }

//   Future<void> openCheckout(data) async {
//     var options = {
//       'key': 'rzp_test_NNbwJ9tmM0fbxj',
//       'amount': data['total'],
//       'name': data['id'],
//       'orderId': data['id'],
//       'description': 'Payment',
//       "currency": "INR",
//       'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
//       'external': {
//         'wallets': ['paytm']
//       }
//     };

//     try {
//       razorpay.open(options);
//     } catch (e) {
//       print(e);
//     }
//   }

//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     //  Get.toNamed(RouteConst.success);
//     if (response.paymentId != null) {
//       finalPlaceOrder(docData, response.paymentId!, 'Success');

//       update();
//     }
//     Fluttertoast.showToast(
//         msg: "SUCCESS: ${response.paymentId!}", timeInSecForIosWeb: 4);
//   }

//   void _handlePaymentError(PaymentFailureResponse response) {
//     finalPlaceOrder(docData, response.code!, response.message!);

//     Fluttertoast.showToast(
//         msg: "ERROR: ${response.code} - ${response.message!}",
//         timeInSecForIosWeb: 4);
//   }

//   void _handleExternalWallet(ExternalWalletResponse response) {
//     Fluttertoast.showToast(
//         msg: "EXTERNAL_WALLET: ${response.walletName!}", timeInSecForIosWeb: 4);
//   }

//   placeOrder() async {
//     var userDetails = AppService.to.fireUser!;
//     var jsonData = [];
//     if (AppService.to.selectedAddress.isNotEmpty) {
//       if (paymentMode != "Cash") {
//         //var db = FirebaseFirestore.instance.collection('orders').doc();
//         // orderId = db.id;
//         for (var item in selectedItemList) {
//           if (item.count > 0) {
//             jsonData.add({
//               //'id': db.id,
//               'foodId': item.id,
//               "count": item.count.toString(),
//               "name": item.name,
//               "price": item.price,
//               "itemTotal": (item.count * int.parse(item.price)).toString(),
//             });
//           }
//         }

//         docData = {
//           //  'id': db.id,
//           "userId": userDetails.uid,
//           "addressid": AppService.to.selectedAddress[0].id,
//           "address":
//               "${AppService.to.selectedAddress[0].address1} ${AppService.to.selectedAddress[0].address2}",
//           "mobile": AppService.to.selectedAddress[0].receiverPhoneNo,
//           "orderedTime": Timestamp.now(),
//           'orderStatus': 'New',
//           'total': total.toString()
//         };
//         docData["items"] = jsonData;
//         await openCheckout(docData);

//         update();
//       } else {
//         finalPlaceOrder(docData, 'COD', 'pending');
//       }
//     } else {
//       toast('Please select delivery address');
//     }
//   }

//   finalPlaceOrder(Map<String, dynamic> data, transactionId, status) async {
//     if (AppService.to.selectedAddress.isNotEmpty) {
//       var db = FirebaseFirestore.instance.collection('orders').doc();
//       data["transactionId"] = transactionId;
//       data["id"] = db.id;
//       data["paymentStatus"] = status;

//       await db.set(data).onError((e, _) => toast("Please try again"));
//       Get.toNamed(RouteConst.success);
//       update();
//     } else {
//       toast('Please select delivery address');
//     }
//   }
// }
