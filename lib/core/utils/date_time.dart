import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///
/// 'd-M-yyyy h:mm a'
///
/// 'EEEE' day
///
String dateAsReadable(DateTime? dateTime,
    {String format = "dd-MMM-yyyy", String ifNull = " - "}) {
  if (dateTime == null) return ifNull;

  DateFormat formatter = DateFormat(format);
  return formatter.format(dateTime);
}

DateTime parseDateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

String timeAsReadable(TimeOfDay? time,
    {bool amPm = true, bool showSecond = false, String ifNull = ' - '}) {
  if (time == null) return ifNull;
  String minute = time.minute < 10 ? '0${time.minute}' : time.minute.toString();

  if (amPm) {
    String hourOfPeriod = time.hourOfPeriod < 10
        ? '0${time.hourOfPeriod}'
        : time.hourOfPeriod.toString();

    return "$hourOfPeriod:$minute${showSecond ? ':00' : ''} ${time.period.index == 1 ? 'PM' : 'AM'}";
  }
  String hour = time.hour < 10 ? '0${time.hour}' : time.hour.toString();
  return "$hour:$minute${showSecond ? ':00' : ''}";
}

TimeOfDay? parseTime(String? t) {
  if (t == null) return null;
  var s = t.split(':');
  if (s.length < 2) return null;
  int? hour = int.tryParse(s[0]);
  int? minute = int.tryParse(s[1]);
  if (hour == null || minute == null) return null;
  return TimeOfDay(hour: hour, minute: minute);
}

/// positive if [second] is biggger
int timeCompare(TimeOfDay first, TimeOfDay second) {
  int f = (first.hour * 60) + first.minute;
  int s = (second.hour * 60) + second.minute;
  return s - f;
}
