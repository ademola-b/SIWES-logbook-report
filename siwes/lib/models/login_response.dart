

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
    LoginResponse({
        this.key,
        this.nonFieldErrors,
    });

    final String? key;
    final List<dynamic>? nonFieldErrors;

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        key: json["key"],
        nonFieldErrors: json["non_field_errors"],
        // nonFieldErrors: List<dynamic>.from(json["non_field_errors"].map((x) => x)) ,
    );

    Map<String, dynamic> toJson() => {
        "key": key,
        "non_field_errors": nonFieldErrors
        // "non_field_errors": List<dynamic>.from(nonFieldErrors!.map((x) => x)),
    };
}
