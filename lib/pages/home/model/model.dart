// To parse this JSON data, do
//
//     final itemList = itemListFromJson(jsonString);

import 'dart:convert';

List<ItemList> itemListFromJson(String str) =>
    List<ItemList>.from(json.decode(str).map((x) => ItemList.fromJson(x)));

String itemListToJson(List<ItemList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ItemList {
  ItemList({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.status,
    required this.category,
    required this.stockCount,
    required this.gstPercent,
    required this.categoryList,
    required this.image,
    required this.cartCount,
    required this.isWishListed,
  });

  final String id;
  final String name;
  final String description;
  final int price;
  final int status;
  final List<String> category;
  final int stockCount;
  final int gstPercent;
  final List<dynamic> categoryList;
  final List<String> image;
  int cartCount;
  bool isWishListed;

  factory ItemList.fromJson(Map<String, dynamic> json) => ItemList(
        id: json["_id"],
        name: json["name"] ?? '',
        description: json["description"],
        price: json["price"],
        status: json["status"],
        category: List<String>.from(json["category"].map((x) => x) ?? []),
        stockCount: json["stockCount"] ?? 0,
        gstPercent: json["gstPercent"],
        categoryList: List<dynamic>.from(json["categoryList"].map((x) => x)),
        image: List<String>.from(json["image"].map((x) => x)),
        cartCount: json["cartCount"],
        isWishListed: json["isWishListed"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "price": price,
        "status": status,
        "category": List<dynamic>.from(category.map((x) => x)),
        "stockCount": stockCount,
        "gstPercent": gstPercent,
        "categoryList": List<dynamic>.from(categoryList.map((x) => x)),
        "image": List<dynamic>.from(image.map((x) => x)),
        "cartCount": cartCount,
        "isWishListed": isWishListed,
      };
}
