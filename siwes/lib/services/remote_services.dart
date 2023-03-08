import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siwes/models/entry_date_response.dart';
import 'package:siwes/models/ind_std_list.dart';
import 'package:siwes/models/login_response.dart';
import 'package:http/http.dart' as http;
import 'package:siwes/models/student_details.dart';
import 'package:siwes/models/user_response.dart';
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
  Future<List<StudentDetailResponse>> getStdDetails() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");

    try {
      var response = await http
          .get(stdDetailsUrl, headers: {"Authorization": "Token $token"});
      if (response.statusCode == 200) {
        final std = studentDetailResponseFromJson(response.body);
        return std;
      } else {
        print("Server error");
      }
    } catch (e) {
      print("An error occurred $e");
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
      print("Server from error $e");
    }

    return <IndStdList>[];
  }

  //Entry Date
  Future<List<EntryDateResponse>?> getEntryDate(context) async {
    try {
      http.Response response = await http.get(entryDateUrl);
      if (response.statusCode == 200) {
        return entryDateResponseFromJson(response.body);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: DefaultText(size: 15.0, text: "Server Error: $e")));
    }

    return null;
  }
}
