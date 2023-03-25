import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siwes/models/week_dates_response.dart';
import 'package:siwes/services/remote_services.dart';
import 'package:siwes/utils/defaultText.dart';

class Constants {
  static Color? primaryColor = Colors.green[500];
  static Color? backgroundColor = Colors.green[100];
  // static const Color backgroundColor = Color(0xFFabf7b1);

  static List<dynamic> getDaysInWeek(DateTime start_date, DateTime end_date) {
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

  static Future<dynamic> DialogBox(context, String? text, Color? color, IconData? icon) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: color,
              content: SizedBox(
                height: 180.0,
                child: Column(
                  children: [
                    Icon(
                      icon,
                      size: 70.0,
                      color: Constants.backgroundColor,
                    ),
                    const SizedBox(height: 20.0),
                    DefaultText(
                      size: 20.0,
                      text: text!,
                      color: Colors.white,
                      align: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ));
  }
}
