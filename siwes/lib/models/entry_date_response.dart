// To parse this JSON data, do
//
//     final entryDateResponse = entryDateResponseFromJson(jsonString);

import 'dart:convert';

List<EntryDateResponse> entryDateResponseFromJson(String str) => List<EntryDateResponse>.from(json.decode(str).map((x) => EntryDateResponse.fromJson(x)));

String entryDateResponseToJson(List<EntryDateResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EntryDateResponse {
    EntryDateResponse({
        required this.week,
        required this.entryDate,
        required this.title,
        required this.description,
        required this.diagram,
        required this.student,
    });

    int week;
    DateTime entryDate;
    String title;
    String description;
    String diagram;
    Student student;

    factory EntryDateResponse.fromJson(Map<String, dynamic> json) => EntryDateResponse(
        week: json["week"],
        entryDate: DateTime.parse(json["entry_date"]),
        title: json["title"],
        description: json["description"],
        diagram: json["diagram"],
        student: Student.fromJson(json["student"]),
    );

    Map<String, dynamic> toJson() => {
        "week": week,
        "entry_date": entryDate.toIso8601String(),
        "title": title,
        "description": description,
        "diagram": diagram,
        "student": student.toJson(),
    };
}

class Student {
    Student({
        required this.id,
        required this.user,
        required this.profilePic,
        required this.profilePicMem,
        required this.phoneNo,
        required this.departmentId,
        required this.schoolBasedSupervisor,
        required this.industryBasedSupervisor,
        this.placementLocation,
    });

    int id;
    User user;
    String profilePic;
    String profilePicMem;
    String phoneNo;
    String departmentId;
    SchoolBasedSupervisor schoolBasedSupervisor;
    IndustryBasedSupervisor industryBasedSupervisor;
    dynamic placementLocation;

    factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json["id"],
        user: User.fromJson(json["user"]),
        profilePic: json["profile_pic"],
        profilePicMem: json["profile_pic_mem"],
        phoneNo: json["phone_no"],
        departmentId: json["department_id"],
        schoolBasedSupervisor: SchoolBasedSupervisor.fromJson(json["school_based_supervisor"]),
        industryBasedSupervisor: IndustryBasedSupervisor.fromJson(json["industry_based_supervisor"]),
        placementLocation: json["placement_location"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user": user.toJson(),
        "profile_pic": profilePic,
        "profile_pic_mem": profilePicMem,
        "phone_no": phoneNo,
        "department_id": departmentId,
        "school_based_supervisor": schoolBasedSupervisor.toJson(),
        "industry_based_supervisor": industryBasedSupervisor.toJson(),
        "placement_location": placementLocation,
    };
}

class IndustryBasedSupervisor {
    IndustryBasedSupervisor({
        required this.id,
        required this.user,
        required this.profilePic,
        required this.profileNoMemory,
        required this.phoneNo,
        this.placementCenter,
    });

    int id;
    User user;
    String profilePic;
    String profileNoMemory;
    String phoneNo;
    dynamic placementCenter;

    factory IndustryBasedSupervisor.fromJson(Map<String, dynamic> json) => IndustryBasedSupervisor(
        id: json["id"],
        user: User.fromJson(json["user"]),
        profilePic: json["profile_pic"],
        profileNoMemory: json["profile_no_memory"],
        phoneNo: json["phone_no"],
        placementCenter: json["placement_center"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user": user.toJson(),
        "profile_pic": profilePic,
        "profile_no_memory": profileNoMemory,
        "phone_no": phoneNo,
        "placement_center": placementCenter,
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

class SchoolBasedSupervisor {
    SchoolBasedSupervisor({
        required this.id,
        required this.user,
        required this.profilePic,
        required this.phoneNo,
        required this.departmentId,
        required this.profilePicMemory,
    });

    int id;
    User user;
    String profilePic;
    String phoneNo;
    String departmentId;
    String profilePicMemory;

    factory SchoolBasedSupervisor.fromJson(Map<String, dynamic> json) => SchoolBasedSupervisor(
        id: json["id"],
        user: User.fromJson(json["user"]),
        profilePic: json["profile_pic"],
        phoneNo: json["phone_no"],
        departmentId: json["department_id"],
        profilePicMemory: json["profile_pic_memory"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user": user.toJson(),
        "profile_pic": profilePic,
        "phone_no": phoneNo,
        "department_id": departmentId,
        "profile_pic_memory": profilePicMemory,
    };
}
