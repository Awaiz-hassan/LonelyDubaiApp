// To parse this JSON data, do
//
//     final updateUser = updateUserFromJson(jsonString);

import 'dart:convert';

UpdateUser updateUserFromJson(String str) =>
    UpdateUser.fromJson(json.decode(str));

String updateUserToJson(UpdateUser data) => json.encode(data.toJson());

class UpdateUser {
  UpdateUser({
    required this.code,
  });

  int code;

  factory UpdateUser.fromJson(Map<String, dynamic> json) => UpdateUser(
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
      };
}
