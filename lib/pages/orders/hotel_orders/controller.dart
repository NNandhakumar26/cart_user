import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:toyskart/pages/checkout/model.dart';
import 'package:toyskart/pages/orders/date_time_model.dart';

class AllOrderListListController extends GetxController {
  RxList<OrderModel> allOrders = <OrderModel>[].obs;
  RxList<OrderModel> forCount = <OrderModel>[].obs;
  String status = 'New';
  String singleOrderStatus = 'New';
  List<DateTimeModel> filteredDate = [];
  DateTimeModel? filteredDate2;
  int newCount = 0;
  int acceptedCount = 0;
  int wayCount = 0;
  int deliveredCount = 0;
  addtime() {
    var time = [
      {"Time": "Today", "Date": DateTime.now().toString()},
      {
        "Time": "Yesterday",
        "Date": DateTime.now().add(const Duration(days: 1)).toString()
      },
      {
        "Time": "Last 7 days",
        "Date": DateTime.now().subtract(const Duration(days: 7)).toString()
      },
      {
        "Time": "Last 14 days",
        "Date": DateTime.now().subtract(const Duration(days: 14)).toString()
      },
      {
        "Time": "Last 30 days",
        "Date": DateTime.now().subtract(const Duration(days: 30)).toString()
      },
      {
        "Time": "Last 60 days",
        "Date": DateTime.now().subtract(const Duration(days: 60)).toString()
      },
      {
        "Time": "Last 6 months ",
        "Date": DateTime.now().subtract(const Duration(days: 180)).toString()
      },
      {
        "Time": "Last 1 year ",
        "Date": DateTime.now().subtract(const Duration(days: 365)).toString()
      }
    ];
    for (var item in time) {
      filteredDate.add(DateTimeModel.fromJson(item));
    }
    update();
  }

  // AddressModel checkoutItems = {};
  List checkoutList = [];
  // getOrders() async {
  //   var userDetails = AppService.to.fireUser!;

  //   var db = FirebaseFirestore.instance.collection('orders');
  //   await db.get().then((event) {
  //     allOrders.clear();
  //     for (var doc in event.docs) {
  //       allOrders.add(OrderModel.fromJson(doc.data()));
  //     }
  //   });

  //   update();
  // }

  getOrdersCount() async {
    var db = FirebaseFirestore.instance.collection('orders');
    await db.get().then((event) {
      forCount.clear();

      for (var doc in event.docs) {
        forCount.add(OrderModel.fromJson(doc.data()));
      }

      for (var i in forCount) {
        if (i.orderStatus == "New") {
          newCount += 1;
        } else if (i.orderStatus == "Accepted") {
          acceptedCount += 1;
        } else if (i.orderStatus == "On the way") {
          wayCount += 1;
        } else if (i.orderStatus == "Delivered") {
          deliveredCount += 1;
        }
      }
    });

    update();
  }

  getOrders(orderStatus) async {
    var db = FirebaseFirestore.instance.collection('orders');
    await db.where('orderStatus', isEqualTo: orderStatus).get().then((event) {
      allOrders.clear();

      for (var doc in event.docs) {
        allOrders.add(OrderModel.fromJson(doc.data()));
        // if (orderStatus == "New") {
        //   newCount = allOrders.length;
        // } else if (orderStatus == "Accepted") {
        //   acceptedCount = allOrders.length;
        // } else if (orderStatus == "On the way") {
        //   wayCount = allOrders.length;
        // } else if (orderStatus == "Delivered") {
        //   deliveredCount = allOrders.length;
        // }
      }
    });

    update();
  }

  // storeNotificationToken(id) async {
  //   var userDetails = AppService.to.fireUser!;
  //   String? token = await FirebaseMessaging.instance.getToken();
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(userDetails.uid)
  //       .set({'token': token}, SetOptions(merge: true));
  // }

  updateproductStatus(orderId, orderStatus, userId) async {
    //   var db = FirebaseFirestore.instance.collection('orders').doc(orderId);
    //   final jsonData = {
    //     'orderStatus': orderStatus,
    //   };

    //   await db.update(jsonData);

    //   var db2 = FirebaseFirestore.instance.collection('users');

    //   await db2.where('uuid', isEqualTo: userId).get().then((event) {
    //     //   print(event.docs);

    //     sendNotification(orderStatus, event.docs[0].data()['token']);
    //   });
    //   singleOrderStatus = "New";
    //   //getOrders(status);
    //   allOrders.removeWhere((element) => element.id == orderId);
    //   if (orderStatus == "New") {
    //   } else if (orderStatus == "Accepted") {
    //     acceptedCount += 1;
    //     newCount -= 1;
    //   } else if (orderStatus == "On the way") {
    //     wayCount += 1;
    //     acceptedCount -= 1;
    //   } else if (orderStatus == "Delivered") {
    //     deliveredCount += 1;
    //     wayCount -= 1;
    //   }
    //   update();
    // }

    String dateAsReadable(DateTime? dateTime,
        {String format = "dd-MMM-yyyy", String ifNull = " - "}) {
      if (dateTime == null) return ifNull;

      DateFormat formatter = DateFormat(format);
      return formatter.format(dateTime);
    }

    @override
    void onReady() {
      // TODO: implement onReady
      getOrdersCount();
      addtime();
      getOrders('New');
      Timer.periodic(const Duration(minutes: 1), (timer) {
        getOrders('New');
      });
      super.onReady();
    }
//   String dat (){

// DateTime dt = (map['timestamp'] as Timestamp).toDate()
  }
}
