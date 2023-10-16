// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

List<CategoryModel> categoryModelFromJson(String str) =>
    List<CategoryModel>.from(
        json.decode(str).map((x) => CategoryModel.fromJson(x)));

String categoryModelToJson(List<CategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel {
  CategoryModel({
    required this.id,
    required this.name,
    required this.value,
    required this.status,
    required this.parentCategoryId,
    required this.subCategoryExists,
    required this.isActive,
  });

  final String id;
  final String name;
  final String value;
  final int status;
  final String parentCategoryId;
  final bool subCategoryExists;
  bool isActive;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["_id"],
        name: json["name"] ?? '',
        value: json["value"] ?? '',
        status: json["status"] ?? 0,
        parentCategoryId: json["parentCategoryId"] ?? '',
        subCategoryExists: json["subCategoryExists"] ?? false,
        isActive: json["enable"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "value": value,
        "status": status,
        "parentCategoryId": parentCategoryId,
        "subCategoryExists": subCategoryExists,
      };
}
