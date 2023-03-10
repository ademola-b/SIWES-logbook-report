// To parse this JSON data, do
//
//     final weekCommentResponse = weekCommentResponseFromJson(jsonString);

import 'dart:convert';

WeekCommentResponse weekCommentResponseFromJson(String str) => WeekCommentResponse.fromJson(json.decode(str));

String weekCommentResponseToJson(WeekCommentResponse data) => json.encode(data.toJson());

class WeekCommentResponse {
    WeekCommentResponse({
        required this.id,
        required this.student,
        required this.week,
        required this.industryComment,
        required this.schoolComment,
    });

    int id;
    int student;
    int week;
    String industryComment;
    String schoolComment;

    factory WeekCommentResponse.fromJson(Map<String, dynamic> json) => WeekCommentResponse(
        id: json["id"],
        student: json["student"],
        week: json["week"],
        industryComment: json["industry_comment"],
        schoolComment: json["school_comment"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "student": student,
        "week": week,
        "industry_comment": industryComment,
        "school_comment": schoolComment,
    };
}
