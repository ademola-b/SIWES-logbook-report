// To parse this JSON data, do
//
//     final logbookEntryResponse = logbookEntryResponseFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/foundation.dart';

List<LogbookEntryResponse> logbookEntryResponseFromJson(String str) => List<LogbookEntryResponse>.from(json.decode(str).map((x) => LogbookEntryResponse.fromJson(x)));

String logbookEntryResponseToJson(List<LogbookEntryResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LogbookEntryResponse {
    LogbookEntryResponse({
        this.student,
        required this.week,
        required this.entryDate,
        required this.title,
        required this.description,
        required this.diagram,
        required this.diagramMem,
    });

    int? student;
    int week;
    DateTime entryDate;
    String title;
    String description;
    String diagram;
    Uint8List diagramMem;

    factory LogbookEntryResponse.fromJson(Map<String, dynamic> json) => LogbookEntryResponse(
        student: json["student"],
        week: json["week"],
        entryDate: DateTime.parse(json["entry_date"]),
        title: json["title"],
        description: json["description"],
        diagram: json["diagram"],
        diagramMem: base64Decode(json["diagram_mem"]),
    );

    Map<String, dynamic> toJson() => {
        "student": student,
        "week": week,
        "entry_date": "${entryDate.year.toString().padLeft(4, '0')}-${entryDate.month.toString().padLeft(2, '0')}-${entryDate.day.toString().padLeft(2, '0')}",
        "title": title,
        "description": description,
        "diagram": diagram,
        "diagram_mem": diagramMem,
    };
}
