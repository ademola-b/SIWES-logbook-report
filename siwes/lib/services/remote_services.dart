import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siwes/models/entry_date_response.dart';
import 'package:siwes/models/ind_std_list.dart';
import 'package:siwes/models/logbook_entry_response.dart';
import 'package:siwes/models/login_response.dart';
import 'package:http/http.dart' as http;
import 'package:siwes/models/placement_centre_response.dart';
import 'package:siwes/models/sch_std_list_response.dart';
import 'package:siwes/models/student_details.dart';
import 'package:siwes/models/user_response.dart';
import 'package:siwes/models/week_comment_response.dart';
import 'package:siwes/models/week_dates_response.dart';

import 'package:siwes/services/urls.dart';
import 'package:siwes/utils/defaultText.dart';

class RemoteServices {
  //login
  Future<LoginResponse?> login(String username, String password) async {
    try {
      var data = await http.post(loginUrl, body: {
        'username': username,
        'password': password,
      });

      var response = data.body;
      return LoginResponse.fromJson(jsonDecode(response));
    } catch (e) {
      print('Problem with Server: $e');
    }

    return null;
  }

  //user token
  Future<UserResponse?> getUser() async {
    //get user token
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    try {
      var response =
          await http.get(userUrl, headers: {"Authorization": "Token $token"});
      return UserResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      print(e);
    }
  }

  //week dates
  Future<List<WeekDatesResponse>> getWeekDates() async {
    try {
      var response = await http.get(weekDatesUrl);
      if (response.statusCode == 200) {
        final wk = weekDatesResponseFromJson(response.body);
        return wk;
      } else {
        throw Exception("Failed to get week dates");
      }
    } catch (e) {
      print("An error occured: $e");
    }

    return <WeekDatesResponse>[];
  }

  //student detail
  static Future<List<StudentDetailResponse>> getStdDetails() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");

    try {
      var response = await http
          .get(stdDetailsUrl, headers: {"Authorization": "Token $token"});

      if (response.statusCode == 200) {
        final std = studentDetailResponseFromJson(response.body);
        // print(std);
        return std;
      } else {
        print("Server error");
      }
    } catch (e) {
      print("Server Error: $e");
    }

    return <StudentDetailResponse>[];
  }

  //Industry Supervisor Remote Services
  //student list
  Future<List<IndStdList>?> getIndStdList() async {
    //get user token
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");

    try {
      var response = await http
          .get(indStdListUrl, headers: {"Authorization": "Token $token"});

      if (response.statusCode == 200) {
        var indstd = indStdListFromJson(response.body);
        return indstd;
      } else {
        throw Exception("Failed to get Student List");
      }
    } catch (e) {
      print("Server error: $e");
    }

    return <IndStdList>[];
  }

  //Entry Date
  Future<List<EntryDateResponse>?> getEntryDate(
      int studentId, String date, context) async {
    try {
      http.Response response = await http
          .get(Uri.parse("$base_url/api/entry_date/$studentId/$date"));
      if (response.statusCode == 200) {
        return entryDateResponseFromJson(response.body);
      }
    } catch (e) {
      print("Server Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: DefaultText(size: 15.0, text: "Server Error: $e")));
    }

    return null;
  }

  //week comment - industry supervisor
  static Future<WeekCommentResponse?>? getWeekComment(
      {context,
      required int studentId,
      required int weekId,
      String? industryComment,
      String? schoolComment}) async {
    var data = jsonEncode({
      'student': studentId,
      'week': weekId,
      'industry_comment': industryComment,
      'school_comment': schoolComment,
    });

    try {
      http.Response response = await http.post(wkCommentUrl,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: data);
      if (response.statusCode == 201) {
        return weekCommentResponseFromJson(response.body);
      } else {
        throw Exception("Failed to comment on entry");
      }
    } catch (e) {
      print("Server Error: $e");
    }

    return null;
  }

  //update Week comment
  Future<WeekCommentResponse?>? updateComment(
      {context,
      required int id,
      required int studentId,
      required int weekId,
      String? indComment}) async {
    var body = jsonEncode({
      "id": id,
      "student": studentId,
      "week": weekId,
      "industry_comment": indComment,
    });
    http.Response response = await http.put(updateEntryUrl(id),
        headers: <String, String>{
          'content-type': 'application/json; charset=UTF-8'
        },
        body: body);

    if (response.statusCode == 200) {
      return weekCommentResponseFromJson(response.body);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: DefaultText(size: 15.0, text: "Failed to update entry")));
      // throw Exception("Failed to update entry");
    }

    return null;
  }

  //Placement centre
  //get
  Future<List<PlacementCentreResponse>?>? getPlacementCentre(context) async {
    //get user token
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");

    try {
      http.Response response =
          await http.get(placementCentreUri, headers: <String, String>{
        'content-type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $token'
      });
      if (response.statusCode == 200) {
        return placementCentreResponseFromJson(response.body);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: DefaultText(size: 15.0, text: "An error occurred: $e")));
    }

    return null;
  }

  //Post Placement Centre
  Future<PlacementCentreResponse?>? addPlacementCentre(context, String name,
      String longitude, String latitude, String radius) async {
    //get user token
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");

    var data = jsonEncode({
      'name': name,
      'longitude': longitude,
      'latitude': latitude,
      'radius': radius
    });
    try {
      http.Response response = await http.post(placementCentreUri,
          headers: <String, String>{
            'content-type': 'application/json; charset=UTF-8',
            'Authorization': 'Token $token'
          },
          body: data);
      if (response.statusCode == 201) {
        return PlacementCentreResponse.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: DefaultText(size: 15.0, text: "An error occurred: $e")));
    }

    return null;
  }

  // School Based supervisor Services
  // get students
  static Future<List<SchStdListResponse?>?> getSchStdList(context) async {
    try {
      http.Response response = await http.get(schStdListUrl);
      if (response.statusCode == 200) {
        return schStdListResponseFromJson(response.body);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:
                DefaultText(size: 15.0, text: "Failed to load students list")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: DefaultText(size: 15.0, text: "Server error: $e")));
    }

    return <SchStdListResponse>[];
  }

  //get Logbook

  //Student Services
  //get or create entry
  Future<List<LogbookEntryResponse>?>? getPostLogEntry(
      {required int studentId, required String entry_date}) async {
    try {
      http.Response response = await http.get(logEntryUrl);
      if (response.statusCode == 200) {
        return logbookEntryResponseFromJson(response.body);
      } else {
        throw Exception("Failed to get log entry");
      }
    } catch (e) {
      print("Server Error: $e");
    }

    return [];
  }
}
