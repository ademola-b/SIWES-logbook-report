import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siwes/models/entry_date_response.dart';
import 'package:siwes/models/entry_report_response.dart';
import 'package:siwes/models/ind_std_list.dart';
import 'package:siwes/models/industry_supervisor_details.dart';
import 'package:siwes/models/logbook_entry_response.dart';
import 'package:siwes/models/login_response.dart';
import 'package:http/http.dart' as http;
import 'package:siwes/models/placement_centre_response.dart';
import 'package:siwes/models/sch_std_list_response.dart';
import 'package:siwes/models/school_supervisor_profile.dart';
import 'package:siwes/models/student_details.dart';
import 'package:siwes/models/user_response.dart';
import 'package:siwes/models/week_comment_response.dart';
import 'package:siwes/models/week_dates_response.dart';
import 'package:siwes/screens/students/logEntry.dart';

import 'package:siwes/services/urls.dart';
import 'package:siwes/utils/constants.dart';
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
  static Future<UserResponse?> getUser(context) async {
    //get user token
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    try {
      var response =
          await http.get(userUrl, headers: {"Authorization": "Token $token"});
      print(response);
      return UserResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: DefaultText(size: 15.0, text: "Server Error: $e")));
    }
    return null;
  }

  //week dates
  static Future<List<WeekDatesResponse>> getWeekDates() async {
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
  static Future<List<IndustrySupervisorDetails>?>? getIndProfile() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");

    try {
      var response = await http
          .get(indProfile, headers: {"Authorization": "Token $token"});
      if (response.statusCode == 200) {
        return industrySupervisorDetailsFromJson(response.body);
      } else {
        throw Exception("Failed to get details");
      }
    } catch (e) {
      print("An error occurred $e");
    }
    return <IndustrySupervisorDetails>[];
  }

  //student list
  static Future<List<IndStdList>?> getIndStdList() async {
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
  static Future<List<EntryDateResponse>?> getEntryDate(
      int studentId, String date, context) async {
    try {
      http.Response response = await http
          .get(Uri.parse("$base_url/api/entry_date/$studentId/$date"));
      if (response.statusCode == 200) {
        return entryDateResponseFromJson(response.body);
      }
    } catch (e) {
      print("Server Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: DefaultText(size: 15.0, text: "Server Errorss: $e")));
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
  static Future<WeekCommentResponse?>? updateComment(
      {context,
      required int id,
      required int studentId,
      required int weekId,
      String? indComment,
      String? schComment}) async {
    var body = jsonEncode({
      "id": id,
      "student": studentId,
      "week": weekId,
      "industry_comment": indComment,
      "school_comment": schComment
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
  //profile
  static Future<List<SchoolSupervisorProfile>?> getSchProfile(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    try {
      http.Response response = await http
          .get(schProfileUrl, headers: {'Authorization': "Token $token"});
      if (response.statusCode == 200) {
        return schoolSupervisorProfileFromJson(response.body);
      } else {
        throw Exception("Failed to get profile");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: DefaultText(size: 15.0, text: "Server error: $e")));
    }
    return null;
  }

  // get students
  static Future<List<SchStdListResponse>?> getSchStdList(context) async {
    //get user token
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    try {
      http.Response response = await http
          .get(schStdListUrl, headers: {'Authorization': "Token $token"});
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

  //Student Services
  //post entry
  static Future<LogbookEntry?> PostLogEntry(
      context,
      String week,
      String entry_date,
      String title,
      String description,
      File? diagram) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    try {
      var headers = {'Authorization': 'Token $token'};
      var request = http.MultipartRequest('POST', logEntryUrl);
      request.fields.addAll({
        'week': week,
        'entry_date': entry_date,
        'title': title,
        'description': description
      });
      if (diagram != null) {
        request.files
            .add(await http.MultipartFile.fromPath('diagram', diagram.path));
      }

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 201) {
        print(await response.stream.bytesToString());
      } else {
        throw Exception("An error occurred: ${response.reasonPhrase}");
        // print(response.reasonPhrase);
      }
    } catch (e) {
      print("Server Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: DefaultText(
        size: 15.0,
        text: "Server Error: $e",
      )));
    }

    return null;
  }

  static Future<List<EntryReportResponse>?> entryReport(
      context, String from, String to) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    try {
      http.Response response = await http.get(
          Uri.parse("$base_url/api/report/?from=$from&to=$to"),
          headers: {"Authorization": "Token $token"});

      if (response.statusCode == 200) {
        return entryReportResponseFromJson(response.body);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: DefaultText(
        size: 15.0,
        text: "An error occurred: $e",
      )));
    }

    return null;
  }
}
