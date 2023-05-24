import 'dart:convert';

List<EntryReportResponse> entryReportResponseFromJson(String str) => List<EntryReportResponse>.from(json.decode(str).map((x) => EntryReportResponse.fromJson(x)));

String entryReportResponseToJson(List<EntryReportResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EntryReportResponse {
    int week;
    DateTime entryDate;
    String title;
    String description;

    EntryReportResponse({
        required this.week,
        required this.entryDate,
        required this.title,
        required this.description,
    });

    factory EntryReportResponse.fromJson(Map<String, dynamic> json) => EntryReportResponse(
        week: json["week"],
        entryDate: DateTime.parse(json["entry_date"]),
        title: json["title"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "week": week,
        "entry_date": "${entryDate.year.toString().padLeft(4, '0')}-${entryDate.month.toString().padLeft(2, '0')}-${entryDate.day.toString().padLeft(2, '0')}",
        "title": title,
        "description": description,
    };
}
