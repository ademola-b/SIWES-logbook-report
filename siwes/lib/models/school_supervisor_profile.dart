// To parse this JSON data, do
//
//     final schoolSupervisorProfile = schoolSupervisorProfileFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/foundation.dart';

List<SchoolSupervisorProfile> schoolSupervisorProfileFromJson(String str) =>
    List<SchoolSupervisorProfile>.from(
        json.decode(str).map((x) => SchoolSupervisorProfile.fromJson(x)));

String schoolSupervisorProfileToJson(List<SchoolSupervisorProfile> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SchoolSupervisorProfile {
  SchoolSupervisorProfile({
    required this.id,
    required this.user,
    required this.profilePic,
    required this.phoneNo,
    required this.departmentId,
    required this.profilePicMemory,
  });

  int id;
  User user;
  String profilePic;
  String phoneNo;
  String departmentId;
  Uint8List profilePicMemory;

  factory SchoolSupervisorProfile.fromJson(Map<String, dynamic> json) =>
      SchoolSupervisorProfile(
        id: json["id"],
        user: User.fromJson(json["user"]),
        profilePic: json["profile_pic"],
        phoneNo: json["phone_no"],
        departmentId: json["department_id"],
        profilePicMemory: base64Decode(json["profile_pic_memory"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user.toJson(),
        "profile_pic": profilePic,
        "phone_no": phoneNo,
        "department_id": departmentId,
        "profile_pic_memory": profilePicMemory,
      };
}

class User {
  User({
    required this.pk,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  int pk;
  String username;
  String email;
  String firstName;
  String lastName;

  factory User.fromJson(Map<String, dynamic> json) => User(
        pk: json["pk"],
        username: json["username"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
      );

  Map<String, dynamic> toJson() => {
        "pk": pk,
        "username": username,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
      };
}
