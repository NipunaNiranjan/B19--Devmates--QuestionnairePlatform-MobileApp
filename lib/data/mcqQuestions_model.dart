// To parse this JSON data, do
//
//     final questionnaires = questionnairesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

mcqQuestions questionnairesFromJson(String str) =>
    mcqQuestions.fromJson(json.decode(str));

String questionnairesToJson(mcqQuestions data) => json.encode(data.toJson());

class mcqQuestions {
  mcqQuestions({
    required this.statusCode,
    required this.status,
    required this.message,
    required this.body,
  });

  int statusCode;
  String status;
  String message;
  List<Bodymcq> body;

  factory mcqQuestions.fromJson(Map<String, dynamic> json) => mcqQuestions(
        statusCode: json["statusCode"],
        status: json["status"],
        message: json["message"],
        body: List<Bodymcq>.from(json["body"].map((x) => Bodymcq.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "message": message,
        "body": List<dynamic>.from(body.map((x) => x.toJson())),
      };
}

class Bodymcq {
  Bodymcq({
    required this.id,
    required this.question,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
    required this.correctAnswer,
    required this.questionnaireId,
  });

  int id;
  String question;
  String option1;
  String option2;
  String option3;
  String option4;
  int correctAnswer;
  int questionnaireId;

  factory Bodymcq.fromJson(Map<String, dynamic> json) => Bodymcq(
        id: json["id"],
        question: json["question"],
        option1: json["option1"],
        option2: json["option2"],
        option3: json["option3"],
        option4: json["option4"],
        correctAnswer: json["correctAnswer"],
        questionnaireId: json["questionnaireID"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "option1": option1,
        "option2": option2,
        "option3": option3,
        "option4": option4,
        "correctAnswer": correctAnswer,
        "questionnaireID": questionnaireId,
      };
}
