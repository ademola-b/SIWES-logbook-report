// To parse this JSON data, do
//
//     final schStdListResponse = schStdListResponseFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/foundation.dart';

List<SchStdListResponse> schStdListResponseFromJson(String str) =>
    List<SchStdListResponse>.from(
        json.decode(str).map((x) => SchStdListResponse.fromJson(x)));

String schStdListResponseToJson(List<SchStdListResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SchStdListResponse {
  SchStdListResponse({
    required this.id,
    required this.user,
    required this.picMem,
    required this.phoneNo,
    required this.industryBasedSupervisor,
  });

  int id;
  User user;
  Uint8List picMem;
  String phoneNo;
  IndustryBasedSupervisor industryBasedSupervisor;

  factory SchStdListResponse.fromJson(Map<String, dynamic> json) =>
      SchStdListResponse(
        id: json["id"],
        user: User.fromJson(json["user"]),
        picMem: base64Decode(json["pic_mem"]),
        phoneNo: json["phone_no"],
        industryBasedSupervisor:
            IndustryBasedSupervisor.fromJson(json["industry_based_supervisor"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user.toJson(),
        "pic_mem": picMem,
        "phone_no": phoneNo,
        "industry_based_supervisor": industryBasedSupervisor.toJson(),
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
  String profileNoMemory;
  String phoneNo;
  PlacementCenter placementCenter;

  factory IndustryBasedSupervisor.fromJson(Map<String, dynamic> json) =>
      IndustryBasedSupervisor(
        id: json["id"],
        user: User.fromJson(json["user"]),
        profilePic: json["profile_pic"],
        profileNoMemory: json["profile_no_memory"],
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
