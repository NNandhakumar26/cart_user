// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);

import 'dart:convert';

List<AddressModel> addressModelFromJson(String str) => List<AddressModel>.from(
    json.decode(str).map((x) => AddressModel.fromJson(x)));

String addressModelToJson(List<AddressModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AddressModel {
  AddressModel({
    required this.id,
    required this.fullName,
    required this.address1,
    required this.addressType,
    required this.userId,
    // required this.createdAt,
    required this.address2,
    required this.city,
    required this.state,
    required this.pincode,
    required this.phoneNo,
    required this.landMark,
    required this.alternatePhn,
    // required this.receiverName,
    // required this.receiverPhoneNo,
    required this.defaultAddress,
  });

  final String id;
  final String fullName;
  final String address1;
  final int addressType;
  final String userId;
  // final DateTime createdAt;
  final String address2;
  final String city;
  final String state;
  final dynamic pincode;
  final String phoneNo;
  final String landMark;
  final String alternatePhn;
  // final dynamic receiverName;
  // final dynamic receiverPhoneNo;
  final bool defaultAddress;

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json["_id"],
        fullName: json["fullName"] ?? '',
        address1: json["address1"] ?? '',
        addressType: json["addressType"] ?? 1,
        userId: json["userId"],
        // createdAt: DateTime.parse(json["createdAt"]),
        address2: json["address2"],
        city: json["city"],
        state: json["state"],
        pincode: json["pincode"],
        phoneNo: json["phoneNo"],
        landMark: json["landMark"],
        alternatePhn: json["alternatePhn"],
        // receiverName: json["receiverName"],
        // receiverPhoneNo: json["receiverPhoneNo"],
        defaultAddress: json["defaultAddress"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fullName": fullName,
        "address1": address1,
        "addressType": addressType,
        "userId": userId,
        //"createdAt": createdAt.toIso8601String(),
        "address2": address2,
        "city": city,
        "state": state,
        "pincode": pincode,
        "phoneNo": phoneNo,
        "landMark": landMark,
        "alternatePhn": alternatePhn,
        // "receiverName": receiverName,
        // "receiverPhoneNo": receiverPhoneNo,
        "defaultAddress": defaultAddress,
      };
}
