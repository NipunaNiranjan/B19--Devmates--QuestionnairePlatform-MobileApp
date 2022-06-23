// To parse this JSON data, do
//
//     final classes = classesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Classes classesFromJson(String str) => Classes.fromJson(json.decode(str));

String classesToJson(Classes data) => json.encode(data.toJson());

class Classes {
  Classes({
    required this.statusCode,
    required this.status,
    required this.message,
    required this.body,
  });

  int statusCode;
  String status;
  String message;
  List<Body> body;

  factory Classes.fromJson(Map<String, dynamic> json) => Classes(
        statusCode: json["statusCode"],
        status: json["status"],
        message: json["message"],
        body: List<Body>.from(json["body"].map((x) => Body.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "message": message,
        "body": List<dynamic>.from(body.map((x) => x.toJson())),
      };
}

class Body {
  Body({
    required this.classId,
    required this.className,
    required this.noOfStudents,
    required this.fromDate,
    required this.toDate,
    required this.createdAt,
    required this.teacher,
  });

  int classId;
  String className;
  int noOfStudents;
  DateTime fromDate;
  DateTime toDate;
  DateTime createdAt;
  Teacher teacher;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        classId: json["classId"],
        className: json["className"],
        noOfStudents: json["noOfStudents"],
        fromDate: DateTime.parse(json["fromDate"]),
        toDate: DateTime.parse(json["toDate"]),
        createdAt: DateTime.parse(json["createdAt"]),
        teacher: Teacher.fromJson(json["teacher"]),
      );

  Map<String, dynamic> toJson() => {
        "classId": classId,
        "className": className,
        "noOfStudents": noOfStudents,
        "fromDate": fromDate.toIso8601String(),
        "toDate": toDate.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "teacher": teacher.toJson(),
      };
}

class Teacher {
  Teacher({
    required this.email,
    required this.phone,
  });

  String email;
  String phone;

  factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
        email: json["email"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "phone": phone,
      };
}
