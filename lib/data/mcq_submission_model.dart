// To parse this JSON data, do
//
//     final mcqSubmission = mcqSubmissionFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

McqSubmission mcqSubmissionFromJson(String str) =>
    McqSubmission.fromJson(json.decode(str));

String mcqSubmissionToJson(McqSubmission data) => json.encode(data.toJson());

class McqSubmission {
  McqSubmission({
    required this.studentId,
    required this.questionnaireId,
    required this.type,
    required this.mcqAnswers,
  });

  int studentId;
  int questionnaireId;
  String type;
  List<McqAnswer> mcqAnswers;

  factory McqSubmission.fromJson(Map<String, dynamic> json) => McqSubmission(
        studentId: json["studentId"],
        questionnaireId: json["questionnaireId"],
        type: json["type"],
        mcqAnswers: List<McqAnswer>.from(
            json["mcqAnswers"].map((x) => McqAnswer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "studentId": studentId,
        "questionnaireId": questionnaireId,
        "type": type,
        "mcqAnswers": List<dynamic>.from(mcqAnswers.map((x) => x.toJson())),
      };
}

class McqAnswer {
  McqAnswer({
    required this.questionId,
    required this.option,
  });

  int questionId;
  int option;

  factory McqAnswer.fromJson(Map<String, dynamic> json) => McqAnswer(
        questionId: json["questionId"],
        option: json["option"],
      );

  Map<String, dynamic> toJson() => {
        "questionId": questionId,
        "option": option,
      };
}
