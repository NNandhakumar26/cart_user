// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.id,
    required this.firebaseUid,
    required this.createdAt,
    required this.displayName,
    required this.email,
    required this.emailVerified,
    required this.invitationCode,
    required this.inviteCode,
    required this.lastLogin,
    required this.loginCount,
    required this.online,
    required this.phoneNumber,
  });

  final String id;
  final String firebaseUid;
  final DateTime createdAt;
  final String displayName;
  final String email;
  final bool emailVerified;
  final String invitationCode;
  final String inviteCode;
  final DateTime lastLogin;
  final int loginCount;
  final bool online;
  final String phoneNumber;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        firebaseUid: json["firebaseUid"],
        createdAt: DateTime.parse(json["createdAt"]),
        displayName: json["displayName"] ?? '',
        email: json["email"] ?? '',
        emailVerified: json["emailVerified"],
        invitationCode: json["invitationCode"] ?? '',
        inviteCode: json["inviteCode"] ?? '',
        lastLogin: DateTime.parse(json["lastLogin"]),
        loginCount: json["loginCount"],
        online: json["online"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firebaseUid": firebaseUid,
        "createdAt": createdAt.toIso8601String(),
        "displayName": displayName,
        "email": email,
        "emailVerified": emailVerified,
        "invitationCode": invitationCode,
        "inviteCode": inviteCode,
        "lastLogin": lastLogin.toIso8601String(),
        "loginCount": loginCount,
        "online": online,
        "phoneNumber": phoneNumber,
      };
}
