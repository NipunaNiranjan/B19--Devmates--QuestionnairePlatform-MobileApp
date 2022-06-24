// To parse this JSON data, do
//
//     final questionnaires = questionnairesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Questionnaires questionnairesFromJson(String str) =>
    Questionnaires.fromJson(json.decode(str));

String questionnairesToJson(Questionnaires data) => json.encode(data.toJson());

class Questionnaires {
  Questionnaires({
    required this.statusCode,
    required this.status,
    required this.message,
    required this.body,
  });

  int statusCode;
  String status;
  String message;
  List<qBody> body;

  factory Questionnaires.fromJson(Map<String, dynamic> json) => Questionnaires(
        statusCode: json["statusCode"],
        status: json["status"],
        message: json["message"],
        body: List<qBody>.from(json["body"].map((x) => qBody.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "message": message,
        "body": List<dynamic>.from(body.map((x) => x.toJson())),
      };
}

class qBody {
  qBody({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
  });

  int id;
  String name;
  String description;
  String type;

  factory qBody.fromJson(Map<String, dynamic> json) => qBody(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "type": type,
      };
}
