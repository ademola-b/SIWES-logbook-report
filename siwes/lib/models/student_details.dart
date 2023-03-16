// To parse this JSON data, do
//
//     final studentDetailResponse = studentDetailResponseFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/foundation.dart';

List<StudentDetailResponse> studentDetailResponseFromJson(String str) =>
    List<StudentDetailResponse>.from(
        json.decode(str).map((x) => StudentDetailResponse.fromJson(x)));

String studentDetailResponseToJson(List<StudentDetailResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudentDetailResponse {
  StudentDetailResponse({
    required this.id,
    required this.user,
    required this.profilePic,
    required this.profilePicMem,
    required this.phoneNo,
    required this.departmentId,
    required this.schoolBasedSupervisor,
    required this.industryBasedSupervisor,
    this.placementLocation,
  });

  int id;
  User user;
  String profilePic;
  Uint8List profilePicMem;
  String phoneNo;
  String departmentId;
  SchoolBasedSupervisor schoolBasedSupervisor;
  IndustryBasedSupervisor industryBasedSupervisor;
  dynamic placementLocation;

  factory StudentDetailResponse.fromJson(Map<String, dynamic> json) =>
      StudentDetailResponse(
        id: json["id"],
        user: User.fromJson(json["user"]),
        profilePic: json["profile_pic"],
        profilePicMem: base64Decode(json["profile_pic_mem"]),
        phoneNo: json["phone_no"],
        departmentId: json["department_id"],
        schoolBasedSupervisor:
            SchoolBasedSupervisor.fromJson(json["school_based_supervisor"]),
        industryBasedSupervisor:
            IndustryBasedSupervisor.fromJson(json["industry_based_supervisor"]),
        placementLocation: json["placement_location"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user.toJson(),
        "profile_pic": profilePic,
        "profile_pic_mem": profilePicMem,
        "phone_no": phoneNo,
        "department_id": departmentId,
        "school_based_supervisor": schoolBasedSupervisor.toJson(),
        "industry_based_supervisor": industryBasedSupervisor.toJson(),
        "placement_location": placementLocation,
      };
}

class IndustryBasedSupervisor {
  IndustryBasedSupervisor({
    required this.id,
    required this.user,
    required this.profilePic,
    required this.profileNoMemory,
    required this.phoneNo,
    required this.placementCenter,
  });

  int id;
  User user;
  String profilePic;
  Uint8List profileNoMemory;
  String phoneNo;
  PlacementCenter placementCenter;

  factory IndustryBasedSupervisor.fromJson(Map<String, dynamic> json) =>
      IndustryBasedSupervisor(
        id: json["id"],
        user: User.fromJson(json["user"]),
        profilePic: json["profile_pic"],
        profileNoMemory: base64Decode(json["profile_no_memory"]),
        phoneNo: json["phone_no"],
        placementCenter: PlacementCenter.fromJson(json["placement_center"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user.toJson(),
        "profile_pic": profilePic,
        "profile_no_memory": profileNoMemory,
        "phone_no": phoneNo,
        "placement_center": placementCenter.toJson(),
      };
}

class PlacementCenter {
  PlacementCenter({
    required this.id,
    required this.name,
    required this.longitude,
    required this.latitude,
    required this.radius,
  });

  int id;
  String name;
  String longitude;
  String latitude;
  String radius;

  factory PlacementCenter.fromJson(Map<String, dynamic> json) =>
      PlacementCenter(
        id: json["id"],
        name: json["name"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        radius: json["radius"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "longitude": longitude,
        "latitude": latitude,
        "radius": radius,
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

class SchoolBasedSupervisor {
  SchoolBasedSupervisor({
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

  factory SchoolBasedSupervisor.fromJson(Map<String, dynamic> json) =>
      SchoolBasedSupervisor(
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
