import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toyskart/core/constants/api.dart';
import 'package:toyskart/core/constants/routes.dart';
import 'package:toyskart/core/services/api/data_api.dart';
import 'package:toyskart/core/utils/loader.dart';
import 'package:toyskart/core/utils/misc.dart';
import 'package:toyskart/global/app_service.dart';
import 'package:toyskart/global/functions/global_functions.dart';
import 'package:toyskart/global/toast.dart';
import 'package:toyskart/pages/cart/model.dart';
import 'package:toyskart/pages/checkout/request_model.dart';
import 'package:toyskart/pages/user_info/address/model.dart';

class CheckoutController extends GetxController {
  RxList<CartListModel> selectedItemList = <CartListModel>[].obs;
  RxInt total = 0.obs;
  RxInt grandTotal = 0.obs;
  var gst = 0.18;
  var deliveryCharge = 150;
  AddressModel? defaultAddress;
  String? orderId;
  String paymentMode = "Online";
  Map<String, dynamic> docData = {};

  RxList<AddressModel> addressList = <AddressModel>[].obs;
  //RxList<AddressModel> finalFoodList = <AddressModel>[].obs;
  //List<OrderModel> finalFoodList = [];
  List<Map<String, dynamic>> temp = [];
  final TextEditingController deliveryAddress = TextEditingController();
  getAddress() async {
    addressList.clear();
    if (AppService.to.selectedAddress.isNotEmpty) {
      addressList.addAll(AppService.to.selectedAddress);
    }

    update();
  }

  getCheckoutItems() async {
    getAddress();

    await getCartDetails();
    selectedItemList.clear();
    selectedItemList = AppService.to.globalCartList;
    dPrint(AppService.to.globalCartCount);
    dPrint(AppService.to.globalCartItems);
    for (var item in selectedItemList) {
      if (item.productPrice > 0) {
        total.value += item.itemCount * (item.productPrice);
      }
    }

    grandTotal.value =
        (total.value + (total.value * (gst)) + deliveryCharge).toInt();
    update();
  }

  final Razorpay razorpay = Razorpay();
  load() async {
    await delay(100);
    getCheckoutItems();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    load();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  Future<void> openCheckout(PaymentRequestModel data, orderId) async {
    var options = {
      'key': 'rzp_test_F34TWekaZbekdw',
      'amount': data.orderAmount,
      'name': data.id,
      'order_id': orderId,
      'paymentId': data.paymentId,
      'description': 'Payment',
      "currency": "INR",
      'prefill': {
        'contact':
            '7010543395', //AppService.to.selectedAddress[0].receiverPhoneNo,
        'email': 'test@razorpay.com'
      },
      "config": {
        "display": {
          "hide": [
            {
              "method": "emi",
              "method": "paylater",
              "method": "netbanking",
              "method": "card",
              "method": "wallet"
            }
          ],
          "preferences": {
            "show_default_blocks": "true",
          },
        },
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      dPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Get.toNamed(RouteConst.success);
    if (response.paymentId != null) {
      finalPlaceOrder(docData, response.paymentId!, true);

      update();
    }
    Fluttertoast.showToast(
        msg: "SUCCESS: ${response.paymentId!}", timeInSecForIosWeb: 4);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    //finalPlaceOrder(docData, response.code!, false);

    Fluttertoast.showToast(
        msg: "ERROR: ${response.code} - ${response.message!}",
        timeInSecForIosWeb: 4);
    hideLoader();
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: ${response.walletName!}", timeInSecForIosWeb: 4);
  }

  addToCart(CartListModel item, bool isAdd) async {
    showLoader();
    try {
      if (isAdd) {
        item.itemCount++;
        AppService.to.globalCartCount.value =
            AppService.to.globalCartCount.value + 1;
        AppService.to.globalCartItems.value =
            AppService.to.globalCartItems.value + item.productPrice;
        // AppService.to.globalCartCount.value += 1;
        //total.value = AppService.to.globalCartItems.value;

        total.value += item.productPrice;
      } else {
        item.itemCount--;

        AppService.to.globalCartCount.value =
            AppService.to.globalCartCount.value - 1;
        AppService.to.globalCartItems.value =
            AppService.to.globalCartItems.value - item.productPrice;
        //AppService.to.globalCartCount.value -= 1;
        //total.value = AppService.to.globalCartItems.value;
        total.value -= item.productPrice;
      }

      update();
      var api = DataApiService<List>(
        ApiConst.cart,
        //dataKey: "detail",
        msgToast: false,
        appJson: true,
        showLoader: false,
        errorToast: false,
      );
      Map<String, String> params = {
        "products": '${item.productId}~${item.itemCount}',
        "userId": AppService.to.loggedUser[0].id,
        // " AppService.to.globalCartCount.value": '${item.count}'
      };

      if (!await api.post(params, {})) {
        if (isAdd) {
          item.itemCount--;
          AppService.to.globalCartCount.value =
              AppService.to.globalCartCount.value - 1;
          AppService.to.globalCartItems.value =
              AppService.to.globalCartItems.value - item.productPrice;
          //AppService.to.globalCartCount.value -= 1;
          // total.value = AppService.to.globalCartItems.value;
          total.value -= item.productPrice;
        } else {
          item.itemCount++;
          AppService.to.globalCartCount.value =
              AppService.to.globalCartCount.value + 1;
          AppService.to.globalCartItems.value =
              AppService.to.globalCartItems.value + item.productPrice;
          // AppService.to.globalCartCount.value += 1;
          //  total.value = AppService.to.globalCartItems.value;
          total.value += item.productPrice;
        }
        update();
        return;
      }
      if (item.itemCount == 0) {
        selectedItemList.removeWhere((element) => element.id == item.id);
        AppService.to.globalCartList
            .removeWhere((element) => element.id == item.id);
        update();
      }
    } catch (e) {
      toast(e.toString());
    } finally {
      grandTotal.value =
          (total.value + (total.value * (gst)) + deliveryCharge).toInt();

      hideLoader();
    }
    // getCartDetails();
  }

  List<PaymentRequestModel> paymentRequest = [];

  createOrder(int amount) async {
    showLoader();
    String username = 'rzp_test_F34TWekaZbekdw';
    String password = 'dDlpROJAxuV6eZ4m0FWlBRXC';
    String basicAuth =
        'Basic ${base64.encode(utf8.encode('$username:$password'))}';
    dPrint(basicAuth);

    var r = await http.post(Uri.parse('https://api.razorpay.com/v1/orders'),
        headers: <String, String>{
          'authorization': basicAuth
        },
        body: {
          "amount": "${(amount * 100)}",
          "currency": "INR",
          "receipt": '${DateTime.now()}',
        });
    dPrint(r.statusCode);
    dPrint(r.body);
    var res = jsonDecode(r.body);
    if (r.statusCode == 200) {
      return res["id"];
    } else {
      return null;
    }
  }

  placeOrder() async {
    var userDetails = AppService.to.loggedUser[0];
    //var jsonData = [];
    if (AppService.to.selectedAddress.isNotEmpty) {
      orderId = await createOrder(total.value);
      if (orderId != null) {
        String productListString = "";
        for (var item in selectedItemList) {
          productListString += "|${item.productId}~${item.itemCount}";
        }
        var t = jsonEncode(AppService.to.selectedAddress[0]);
        String addressString = AppService.to.selectedAddress[0].address1 +
            AppService.to.selectedAddress[0].address2 +
            AppService.to.selectedAddress[0].landMark +
            AppService.to.selectedAddress[0].phoneNo;
        Map<String, String> params = {
          //  'id': db.id,
          "products": productListString.replaceFirst("|", ""),
          "addressId": AppService.to.selectedAddress[0].id,
          "address": jsonEncode(AppService.to.selectedAddress[0]),
          "userId": userDetails.id,
          "actualAmount": total.toString(),
          "orderAmount": total.toString(),
          //  "orderDate": DateTime.now().toString(),
          'orderId': orderId!,
          "paymentMethod": "${1}", // 5 cod
          "paymentGateway": "${1}", // 2 cod
          'deliveryCharge': deliveryCharge.toString()
        };
        //docData["items"] = jsonData;
        dPrint(params);
        var api = DataApiService<List>(
          ApiConst.orders,
          dataKey: "detail",
          msgToast: false,
          appJson: true,
          showLoader: false,
          errorToast: false,
        );

        if (!await api.post(params, {})) return;
        var data = api.body['detail'];
        paymentRequest.add(PaymentRequestModel.fromJson(data));
        await openCheckout(paymentRequest[0], orderId);

        update();
        // } else {
        //   finalPlaceOrder(docData, 'COD', 'pending');
        // }
      } else {
        toast('An error occured during order creation');
      }
    } else {
      toast('Please select delivery address');
    }
  }

  placeOrderCOD() async {
    var userDetails = AppService.to.loggedUser[0];
    //var jsonData = [];
    if (AppService.to.selectedAddress.isNotEmpty) {
      orderId = DateTime.now().toString();
      if (orderId != null || orderId != "") {
        String productListString = "";
        for (var item in selectedItemList) {
          productListString += "|${item.productId}~${item.itemCount}";
        }
        var t = jsonEncode(AppService.to.selectedAddress[0]);
        String addressString = AppService.to.selectedAddress[0].address1 +
            AppService.to.selectedAddress[0].address2 +
            AppService.to.selectedAddress[0].landMark +
            AppService.to.selectedAddress[0].phoneNo;
        Map<String, String> params = {
          //  'id': db.id,
          "products": productListString.replaceFirst("|", ""),
          "addressId": AppService.to.selectedAddress[0].id,
          "address": jsonEncode(AppService.to.selectedAddress[0]),
          "userId": userDetails.id,
          "actualAmount": total.toString(),
          "orderAmount": total.toString(),
          //  "orderDate": DateTime.now().toString(),
          'orderId': orderId!,
          "paymentMethod": "${5}", // 5 cod
          "paymentGateway": "${2}", // 2 cod
        };

        var api = DataApiService<List>(
          ApiConst.orders,
          dataKey: "detail",
          msgToast: false,
          appJson: true,
          showLoader: false,
          errorToast: false,
        );

        if (!await api.post(params, {})) return;
        var data = api.body['detail'];
        Get.toNamed(RouteConst.success);
        update();
        // } else {
        //   finalPlaceOrder(docData, 'COD', 'pending');
        // }
      } else {
        toast('An error occured during order creation');
      }
    } else {
      toast('Please select delivery address');
    }
  }

  finalPlaceOrder(Map<String, dynamic> data, transactionId, status) async {
    var userDetails = AppService.to.loggedUser[0];
    Map<String, String> params = {
      "userId": userDetails.id,
      'orderId': orderId!,
      // "paymentMethod": "${1}",
      "paymentGateway": "${1}",
    };
    //docData["items"] = jsonData;
    dPrint(params);
    var api = DataApiService<List>(
      status ? "payment/success-payment" : "payment/failure-payment",
      //dataKey: "detail",
      msgToast: false,
      appJson: true,
      showLoader: false,
      errorToast: false,
    );

    if (!await api.post(params, {})) {
      hideLoader();

      return;
    }

    if (status) {
      hideLoader();
      Get.toNamed(RouteConst.success);
    }
  }
}
