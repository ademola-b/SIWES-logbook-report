// To parse this JSON data, do
//
//     final logbookEntryResponse = logbookEntryResponseFromJson(jsonString);

import 'dart:convert';

LogbookEntryResponse logbookEntryResponseFromJson(String str) => LogbookEntryResponse.fromJson(json.decode(str));

String logbookEntryResponseToJson(LogbookEntryResponse data) => json.encode(data.toJson());

class LogbookEntryResponse {
    LogbookEntryResponse({
        required this.week,
        required this.entryDate,
        required this.title,
        required this.description,
        required this.diagram,
        required this.diagramMem,
    });

    int week;
    DateTime entryDate;
    String title;
    String description;
    String diagram;
    String diagramMem;

    factory LogbookEntryResponse.fromJson(Map<String, dynamic> json) => LogbookEntryResponse(
        week: json["week"],
        entryDate: DateTime.parse(json["entry_date"]),
        title: json["title"],
        description: json["description"],
        diagram: json["diagram"],
        diagramMem: json["diagram_mem"],
    );

    Map<String, dynamic> toJson() => {
        "week": week,
        "entry_date": "${entryDate.year.toString().padLeft(4, '0')}-${entryDate.month.toString().padLeft(2, '0')}-${entryDate.day.toString().padLeft(2, '0')}",
        "title": title,
        "description": description,
        "diagram": diagram,
        "diagram_mem": diagramMem,
    };
}
