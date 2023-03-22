import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siwes/models/week_dates_response.dart';
import 'package:siwes/services/remote_services.dart';

class Constants {
  static Color? primaryColor = Colors.green[500];
  static Color? backgroundColor = Colors.green[100];
  // static const Color backgroundColor = Color(0xFFabf7b1);

  List<dynamic> getDaysInWeek(DateTime start_date, DateTime end_date) {
    List<DateTime> days = [];
    List converted_days = [];
    for (var i = 0; i <= end_date.difference(start_date).inDays; i++) {
      days.add(start_date.add(Duration(days: i)));
    }

    for (var date in days) {
      String newDate =
          DateFormat("yyyy-MM-dd").format(DateTime.parse(date.toString()));
      converted_days.add(newDate);
    }

    return converted_days;
  }

  static String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return "This Field is required";
    }
    return null;
  }

  static clearDetails() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
  }


}
