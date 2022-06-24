// To parse this JSON data, do
//
//     final saSubmission = saSubmissionFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SaSubmission saSubmissionFromJson(String str) =>
    SaSubmission.fromJson(json.decode(str));

String saSubmissionToJson(SaSubmission data) => json.encode(data.toJson());

class SaSubmission {
  SaSubmission({
    required this.studentId,
    required this.questionnaireId,
    required this.type,
    required this.shortAnswers,
  });

  int studentId;
  int questionnaireId;
  String type;
  List<ShortAnswer> shortAnswers;

  factory SaSubmission.fromJson(Map<String, dynamic> json) => SaSubmission(
        studentId: json["studentId"],
        questionnaireId: json["questionnaireId"],
        type: json["type"],
        shortAnswers: List<ShortAnswer>.from(
            json["shortAnswers"].map((x) => ShortAnswer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "studentId": studentId,
        "questionnaireId": questionnaireId,
        "type": type,
        "shortAnswers": List<dynamic>.from(shortAnswers.map((x) => x.toJson())),
      };
}

class ShortAnswer {
  ShortAnswer({
    required this.questionId,
    required this.answer,
  });

  int questionId;
  String answer;

  factory ShortAnswer.fromJson(Map<String, dynamic> json) => ShortAnswer(
        questionId: json["questionId"],
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "questionId": questionId,
        "answer": answer,
      };
}
