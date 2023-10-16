// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<OrderModel> orderModelFromJson(String str) =>
    List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromJson(x)));

String orderModelToJson(List<OrderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderModel {
  OrderModel({
    required this.id,
    required this.items,
    required this.userId,
    required this.addressid,
    required this.address,
    required this.mobile,
    required this.orderStatus,
    required this.orderedTime,
    required this.total,
  });

  final String id;
  final List<Item> items;
  final String userId;
  final String addressid;
  final String address;
  final String mobile;
  final String orderStatus;
  final String total;
  final DateTime orderedTime;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        userId: json["userId"],
        addressid: json["addressid"],
        address: json["address"],
        mobile: json["mobile"],
        total: json["total"],
        orderStatus: json["orderStatus"],
        orderedTime: ((json["orderedTime"]) as Timestamp).toDate(),
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "userId": userId,
        "addressid": addressid,
        "address": address,
        "mobile": mobile,
      };
}

class Item {
  Item({
    required this.count,
    required this.name,
    required this.price,
    required this.itemTotal,
    required this.foodId,
  });

  final String count;
  final String name;
  final String price;
  final String itemTotal;
  final String foodId;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        count: json["count"],
        name: json["name"],
        price: json["price"],
        itemTotal: json["itemTotal"],
        foodId: json["foodId"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "name": name,
        "price": price,
        "itemTotal": itemTotal,
        "foodId": foodId,
      };
}
