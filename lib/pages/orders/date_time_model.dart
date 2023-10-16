// To parse this JSON data, do
//
//     final dateTimeMode = dateTimeModeFromJson(jsonString);

import 'dart:convert';

List<DateTimeModel> dateTimeModeFromJson(String str) =>
    List<DateTimeModel>.from(
        json.decode(str).map((x) => DateTimeModel.fromJson(x)));

String dateTimeModeToJson(List<DateTimeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DateTimeModel {
  DateTimeModel({
    required this.time,
    required this.date,
  });

  final String time;
  final DateTime date;

  factory DateTimeModel.fromJson(Map<String, dynamic> json) => DateTimeModel(
        time: json["Time"],
        date: DateTime.parse(json["Date"]),
      );

  Map<String, dynamic> toJson() => {
        "Time": time,
        "Date": date.toIso8601String(),
      };
}
