// To parse this JSON data, do
//
//     final logbookEntry = logbookEntryFromJson(jsonString);

import 'dart:convert';

LogbookEntry logbookEntryFromJson(String str) => LogbookEntry.fromJson(json.decode(str));

String logbookEntryToJson(LogbookEntry data) => json.encode(data.toJson());

class LogbookEntry {
    LogbookEntry({
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

    factory LogbookEntry.fromJson(Map<String, dynamic> json) => LogbookEntry(
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
