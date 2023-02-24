// To parse this JSON data, do
//
//     final weekDatesResponse = weekDatesResponseFromJson(jsonString);

import 'dart:convert';

List<WeekDatesResponse> weekDatesResponseFromJson(String str) => List<WeekDatesResponse>.from(json.decode(str).map((x) => WeekDatesResponse.fromJson(x)));

String weekDatesResponseToJson(List<WeekDatesResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WeekDatesResponse {
    WeekDatesResponse({
        required this.startDate,
        required this.endDate,
    });

    DateTime startDate;
    DateTime endDate;

    factory WeekDatesResponse.fromJson(Map<String, dynamic> json) => WeekDatesResponse(
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
    );

    Map<String, dynamic> toJson() => {
        "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    };
}
