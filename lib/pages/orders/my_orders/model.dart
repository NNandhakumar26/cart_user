// // To parse this JSON data, do
// //
// //     final orderListModel = orderListModelFromJson(jsonString);

// import 'dart:convert';

// List<OrderListModel> orderListModelFromJson(String str) =>
//     List<OrderListModel>.from(
//         json.decode(str).map((x) => OrderListModel.fromJson(x)));

// String orderListModelToJson(List<OrderListModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class OrderListModel {
//   OrderListModel({
//     required this.id,
//     required this.products,
//     required this.productsName,
//     required this.address,
//     required this.actualAmount,
//     required this.orderAmount,
//     required this.orderDate,
//     required this.orderProcessed,
//     required this.productStatus,
//   });

//   final String id;
//   final String products;
//   final String address;
//   final String productsName;
//   final int actualAmount;
//   final int orderAmount;
//   final DateTime orderDate;
//   final int orderProcessed;
//   final int productStatus;

//   factory OrderListModel.fromJson(Map<String, dynamic> json) {
//     var orderListModel = OrderListModel(
//       id: json["_id"],
//       products: json["products"],
//       address: json["address"],
//       productsName: json["productsName"],
//       actualAmount: json["actualAmount"],
//       orderAmount: json["orderAmount"],
//       orderDate: DateTime.parse(json["orderDate"]),
//       orderProcessed: json["orderProcessed"],
//       productStatus: json["productStatus"],
//     );
//     return orderListModel;
//   }
//   String productStatusUpdate() {
//     String foodLiveStatus = "";
//     //  default: 0, // 0.pending 1.New 2.Accepted 3.outOfDelivery 4.Delivered
//     if (productStatus == 0) {
//       foodLiveStatus = "Pending";
//     } else if (productStatus == 1) {
//       foodLiveStatus = "New";
//     } else if (productStatus == 2) {
//       foodLiveStatus = "Accepted";
//     } else if (productStatus == 3) {
//       foodLiveStatus = "Out for delivery";
//     } else if (productStatus == 4) {
//       foodLiveStatus = "Delivered";
//     }
//     return foodLiveStatus;
//   }

//   List items() {
//     List itemsList = productsName.split("<br>");

//     return itemsList;
//   }

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "products": products,
//         "productsName": productsName,
//         "actualAmount": actualAmount,
//         "orderAmount": orderAmount,
//         "orderDate": orderDate.toIso8601String(),
//         "orderProcessed": orderProcessed,
//         "productStatus": productStatus,
//       };
// }

// To parse this JSON data, do
//
//     final orderListModel = orderListModelFromJson(jsonString);

import 'dart:convert';

import 'package:toyskart/pages/user_info/address/model.dart';

List<List<OrderListModel>> orderListModelFromJson(String str) =>
    List<List<OrderListModel>>.from(json.decode(str).map((x) =>
        List<OrderListModel>.from(x.map((x) => OrderListModel.fromJson(x)))));

String orderListModelToJson(List<List<OrderListModel>> data) =>
    json.encode(List<dynamic>.from(
        data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))));

class OrderListModel {
  OrderListModel(
      {required this.id,
      required this.productsName,
      required this.address,
      required this.actualAmount,
      required this.orderAmount,
      required this.paymentMethod,
      required this.orderId,
      required this.orderDate,
      required this.productStatus,
      required this.orderProcessed,
      required this.totalAmount,
      required this.deliveryCharge,
      required this.gstAmount,
      required this.products});

  final String id;
  final List<ProductsName> productsName;
  final AddressModel address;
  final int actualAmount;
  final int orderAmount;
  final dynamic paymentMethod;

  final String orderId;
  final DateTime orderDate;
  final int productStatus;

  final int orderProcessed;
  final String products;
  final int deliveryCharge;
  final int gstAmount;
  final int totalAmount;

  factory OrderListModel.fromJson(Map<String, dynamic> json) {
    var orderListModel = OrderListModel(
      id: json["_id"],
      products: json["products"],
      productsName: List<ProductsName>.from(jsonDecode(json["productsName"])
          .map((x) => ProductsName.fromJson(x))),
      address: AddressModel.fromJson(jsonDecode(json["address"])),
      actualAmount: json["actualAmount"],
      orderAmount: json["orderAmount"],
      paymentMethod: json["paymentMethod"],
      orderId: json["orderId"],
      deliveryCharge: json["deliveryCharge"],
      gstAmount: 18, //json["gstAmount"],
      totalAmount: json["totalAmount"],
      orderDate: DateTime.parse(json["orderDate"]),
      productStatus: json["productStatus"],
      orderProcessed: json["orderProcessed"],
    );
    return orderListModel;
  }
  String productStatusUpdate() {
    String foodLiveStatus = "";
    //  default: 0, // 0.pending 1.New 2.Accepted 3.outOfDelivery 4.Delivered
    if (productStatus == 0) {
      foodLiveStatus = "Pending";
    } else if (productStatus == 1) {
      foodLiveStatus = "New";
    } else if (productStatus == 2) {
      foodLiveStatus = "Accepted";
    } else if (productStatus == 3) {
      foodLiveStatus = "Out for delivery";
    } else if (productStatus == 4) {
      foodLiveStatus = "Delivered";
    }
    return foodLiveStatus;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "productsName": List<dynamic>.from(productsName.map((x) => x.toJson())),
        "address": address.toJson(),
        "actualAmount": actualAmount,
        "orderAmount": orderAmount,
        "paymentMethod": paymentMethod,
        "orderId": orderId,
        "orderDate": orderDate.toIso8601String(),
        "productStatus": productStatus,
        "orderProcessed": orderProcessed,
      };
}

class Address {
  Address({
    required this.id,
    required this.geoLocation,
    required this.address1,
    required this.addressType,
    required this.defaultAddress,
    required this.userId,
    required this.address2,
    required this.receiverName,
    required this.receiverPhoneNo,
  });

  final String id;
  final String? geoLocation;
  final String address1;
  final int addressType;
  final bool defaultAddress;
  final String userId;
  final String address2;
  final String receiverName;
  final String receiverPhoneNo;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["_id"],
        geoLocation: json["geoLocation"],
        address1: json["address1"],
        addressType: json["addressType"],
        defaultAddress: json["defaultAddress"],
        userId: json["userId"],
        address2: json["address2"],
        receiverName: json["receiverName"],
        receiverPhoneNo: json["receiverPhoneNo"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "geoLocation": geoLocation,
        "address1": address1,
        "addressType": addressType,
        "defaultAddress": defaultAddress,
        "userId": userId,
        "address2": address2,
        "receiverName": receiverName,
        "receiverPhoneNo": receiverPhoneNo,
      };
}

class ProductsName {
  ProductsName({
    required this.name,
    required this.itemCount,
    required this.actualAmount,
    required this.offerAmount,
  });

  final String name;
  final int itemCount;
  final int actualAmount;
  final int offerAmount;

  factory ProductsName.fromJson(Map<String, dynamic> json) => ProductsName(
        name: json["name"],
        itemCount: json["itemCount"],
        actualAmount: json["actualAmount"],
        offerAmount: json["offerAmount"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "itemCount": itemCount,
        "actualAmount": actualAmount,
        "offerAmount": offerAmount,
      };
}
