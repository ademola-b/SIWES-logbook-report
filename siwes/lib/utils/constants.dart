import 'package:flutter/material.dart';

class Constants {
  static Color? primaryColor = Colors.green[500];
  static Color? backgroundColor = Colors.green[100];
  // static const Color backgroundColor = Color(0xFFabf7b1);

  List<DateTime> getDaysInWeek(DateTime start_date, DateTime end_date) {
    List<DateTime> days = [];
    for (var i = 0; i <= end_date.difference(start_date).inDays; i++) {
      days.add(start_date.add(Duration(days: i)));
    }

    return days;
  }
}
