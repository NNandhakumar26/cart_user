// To parse this JSON data, do
//
//     final paymentRequestModel = paymentRequestModelFromJson(jsonString);

import 'dart:convert';

List<PaymentRequestModel> paymentRequestModelFromJson(String str) =>
    List<PaymentRequestModel>.from(
        json.decode(str).map((x) => PaymentRequestModel.fromJson(x)));

String paymentRequestModelToJson(List<PaymentRequestModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentRequestModel {
  PaymentRequestModel({
    required this.id,
    required this.products,
    required this.productsName,
    required this.address,
    required this.addressId,
    required this.actualAmount,
    required this.orderAmount,
    required this.userIp,
    required this.orderDate,
    required this.userId,
    required this.productStatus,
    required this.orderProcessed,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.paymentId,
    required this.orderId,
  });

  final String id;
  final String products;
  final String productsName;
  final String address;
  final String addressId;
  final int actualAmount;
  final int orderAmount;
  final String userIp;
  final String orderDate;
  final String userId;
  final int productStatus;
  final int orderProcessed;
  final int status;
  final DateTime createdAt;
  final String updatedAt;
  final int v;
  final String orderId;
  final String paymentId;

  factory PaymentRequestModel.fromJson(Map<String, dynamic> json) =>
      PaymentRequestModel(
        id: json["_id"],
        products: json["products"],
        productsName: json["productsName"],
        address: json["address"],
        addressId: json["addressId"],
        actualAmount: json["actualAmount"],
        orderAmount: json["orderAmount"],
        userIp: json["userIp"] ?? "",
        orderDate: json["orderDate"],
        userId: json["userId"],
        productStatus: json["productStatus"] ?? 0,
        orderProcessed: json["orderProcessed"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"],
        v: json["__v"],
        paymentId: json["paymentId"],
        orderId: json["orderId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "products": products,
        "productsName": productsName,
        "address": address,
        "addressId": addressId,
        "actualAmount": actualAmount,
        "orderAmount": orderAmount,
        "userIp": userIp,
        "orderDate": orderDate,
        "userId": userId,
        //  "foodStatus": foodStatus,
        "orderProcessed": orderProcessed,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt,
        "__v": v,
        "paymentId": paymentId,
      };
}
