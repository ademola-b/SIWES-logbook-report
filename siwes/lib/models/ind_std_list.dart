// To parse this JSON data, do
//
//     final indStdList = indStdListFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/foundation.dart';

List<IndStdList> indStdListFromJson(String str) => List<IndStdList>.from(json.decode(str).map((x) => IndStdList.fromJson(x)));

String indStdListToJson(List<IndStdList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IndStdList {
    IndStdList({
        required this.id,
        required this.user,
        required this.picMem,
        required this.phoneNo,
    });

    int id;
    User user;
    Uint8List picMem;
    String phoneNo;

    factory IndStdList.fromJson(Map<String, dynamic> json) => IndStdList(
        id: json["id"],
        user: User.fromJson(json["user"]),
        picMem: base64Decode(json["pic_mem"]),
        phoneNo: json["phone_no"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user": user.toJson(),
        "pic_mem": picMem,
        "phone_no": phoneNo,
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
