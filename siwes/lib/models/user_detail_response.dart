// To parse this JSON data, do
//
//     final userDetail = userDetailFromJson(jsonString);

import 'dart:convert';

UserDetail userDetailFromJson(String str) => UserDetail.fromJson(json.decode(str));

String userDetailToJson(UserDetail data) => json.encode(data.toJson());

class UserDetail {
    int pk;
    String username;
    String email;
    String firstName;
    String lastName;
    String userType;

    UserDetail({
        required this.pk,
        required this.username,
        required this.email,
        required this.firstName,
        required this.lastName,
        required this.userType,
    });

    factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        pk: json["pk"],
        username: json["username"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        userType: json["user_type"],
    );

    Map<String, dynamic> toJson() => {
        "pk": pk,
        "username": username,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "user_type": userType,
    };
}
