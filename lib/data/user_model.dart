// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
  Users({
    required this.id,
    required this.username,
    required this.roles,
    required this.accessToken,
    required this.tokenType,
  });

  String id;
  String username;
  List<String> roles;
  String accessToken;
  String tokenType;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"],
        username: json["username"],
        roles: List<String>.from(json["roles"].map((x) => x)),
        accessToken: json["accessToken"],
        tokenType: json["tokenType"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "accessToken": accessToken,
        "tokenType": tokenType,
      };
}
