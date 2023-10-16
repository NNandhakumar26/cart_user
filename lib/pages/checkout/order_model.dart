// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

List<OrderModel> orderModelFromJson(String str) =>
    List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromJson(x)));

String orderModelToJson(List<OrderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderModel {
  OrderModel({
    required this.id,
    required this.entity,
    required this.amount,
    required this.amountPaid,
    required this.amountDue,
    required this.currency,
    required this.receipt,
    required this.offerId,
    required this.status,
    required this.attempts,
    required this.notes,
    required this.createdAt,
  });

  final String id;
  final String entity;
  final int amount;
  final int amountPaid;
  final int amountDue;
  final String currency;
  final DateTime receipt;
  final dynamic offerId;
  final String status;
  final int attempts;
  final List<dynamic> notes;
  final int createdAt;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        entity: json["entity"],
        amount: json["amount"],
        amountPaid: json["amount_paid"],
        amountDue: json["amount_due"],
        currency: json["currency"],
        receipt: DateTime.parse(json["receipt"]),
        offerId: json["offer_id"],
        status: json["status"],
        attempts: json["attempts"],
        notes: List<dynamic>.from(json["notes"].map((x) => x)),
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "entity": entity,
        "amount": amount,
        "amount_paid": amountPaid,
        "amount_due": amountDue,
        "currency": currency,
        "receipt": receipt.toIso8601String(),
        "offer_id": offerId,
        "status": status,
        "attempts": attempts,
        "notes": List<dynamic>.from(notes.map((x) => x)),
        "created_at": createdAt,
      };
}
