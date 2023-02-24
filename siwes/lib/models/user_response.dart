// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'dart:convert';

UserResponse userResponseFromJson(String str) => UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
    UserResponse({
        required this.pk,
        required this.username,
        required this.email,
        required this.firstName,
        required this.lastName,
        required this.userType,
    });

    int pk;
    String username;
    String email;
    String firstName;
    String lastName;
    String userType;

    factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
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
