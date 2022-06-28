// To parse this JSON data, do
//
//     final questionnaires = questionnairesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SAQuestions questionnairesFromJson(String str) =>
    SAQuestions.fromJson(json.decode(str));

String questionnairesToJson(SAQuestions data) => json.encode(data.toJson());

class SAQuestions {
  SAQuestions({
    required this.statusCode,
    required this.status,
    required this.message,
    required this.body,
  });

  int statusCode;
  String status;
  String message;
  List<Bodysa> body;

  factory SAQuestions.fromJson(Map<String, dynamic> json) => SAQuestions(
        statusCode: json["statusCode"],
        status: json["status"],
        message: json["message"],
        body: List<Bodysa>.from(json["body"].map((x) => Bodysa.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "message": message,
        "body": List<dynamic>.from(body.map((x) => x.toJson())),
      };
}

class Bodysa {
  Bodysa({
    required this.id,
    required this.questionnaireId,
    required this.name,
    required this.question,
  });

  int id;
  int questionnaireId;
  String name;
  String question;

  factory Bodysa.fromJson(Map<String, dynamic> json) => Bodysa(
        id: json["id"],
        questionnaireId: json["questionnaireId"],
        name: json["name"],
        question: json["question"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "questionnaireId": questionnaireId,
        "name": name,
        "question": question,
      };
}
