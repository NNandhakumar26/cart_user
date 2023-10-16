// To parse this JSON data, do
//
//     final cartListModel = cartListModelFromJson(jsonString);

import 'dart:convert';

List<CartListModel> cartListModelFromJson(String str) =>
    List<CartListModel>.from(
        json.decode(str).map((x) => CartListModel.fromJson(x)));

String cartListModelToJson(List<CartListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartListModel {
  CartListModel({
    required this.id,
    required this.productId,
    required this.userId,
    required this.createdAt,
    required this.itemCount,
    required this.productName,
    required this.productImage,
    required this.productDescription,
    required this.productPrice,
    required this.productEnable,
  });

  final String id;
  final String productId;
  final String userId;
  final DateTime createdAt;
  int itemCount;
  final String productName;
  final dynamic productImage;
  final String productDescription;
  final int productPrice;
  final bool productEnable;

  factory CartListModel.fromJson(Map<String, dynamic> json) => CartListModel(
        id: json["_id"],
        productId: json["productId"],
        userId: json["userId"],
        createdAt: DateTime.parse(json["createdAt"]),
        itemCount: json["itemCount"] ?? 0,
        productName: json["productName"] ?? '',
        productImage: json["productImage"],
        productDescription: json["productDescription"] ?? '',
        productPrice: json["productPrice"] ?? 0,
        productEnable: json["productEnable"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "productId": productId,
        "userId": userId,
        "createdAt": createdAt.toIso8601String(),
        "itemCount": itemCount,
        "productName": productName,
        "productImage": productImage,
        "productDescription": productDescription,
        "productPrice": productPrice,
        "productEnable": productEnable,
      };
}
