import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siwes/models/entry_report_response.dart';
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

  static Future<dynamic> DialogBox(
      context, String? text, Color? color, IconData? icon) {
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
                      weight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
            ));
  }

  static Future<String> getDownloadPath(context) async {
    Directory? dir;
    try {
      Platform.isIOS
          ? dir = await getApplicationDocumentsDirectory()
          : dir = Directory('/storage/emulated/0/Download');
      if (!await dir.exists()) dir = await getExternalStorageDirectory();
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: DefaultText(
              size: 15.0,
              text:
                  "Can't get download folder, check if storage permission is enabled")));
    }

    // print("Saved Dir: ${dir!.path}");
    return dir!.path;
  }

  static Future<bool> generateCSV(
      List<dynamic>? stdRepo, String file_name, context) async {
    try {
      List<List<String>> csvData = [
        <String>[
          'Registration No',
          'Full Name',
        ],
        ...stdRepo!.map((item) => [
              item.user.username,
              "${item.user.firstName} ${item.user.lastName}",
            ])
      ];
      String csv = const ListToCsvConverter().convert(csvData);

      // final String dir = (await getExternalStorageDirectory())!.path;
      final String dir = (await getDownloadPath(context));
      final String path = "$dir/$file_name.csv";
      // print(path);
      final File file = File(path);

      await file.writeAsString(csv);

      return true;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: DefaultText(size: 15.0, text: "An error Occurred: $e")));
      return false;
    }
  }

  static Future<bool> generateEntryCSV(
      List<EntryReportResponse>? entryRepo, String file_name, context) async {
    try {
      List<List<String>> csvData = [
        <String>['Week', 'Entry Date', 'Title', 'Description'],
        ...entryRepo!.map((item) =>
            ["${item.week}", "${item.entryDate}", item.title, item.description])
      ];
      String csv = const ListToCsvConverter().convert(csvData);

      // final String dir = (await getExternalStorageDirectory())!.path;
      final String dir = (await getDownloadPath(context));
      final String path = "$dir/$file_name.csv";
      // print(path);
      final File file = File(path);

      await file.writeAsString(csv);

      return true;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: DefaultText(size: 15.0, text: "An error Occurred: $e")));
      return false;
    }
  }
}
