// To parse this JSON data, do
//
//     final loginUser = loginUserFromJson(jsonString);

import 'dart:convert';

LoginUser loginUserFromJson(String str) => LoginUser.fromJson(json.decode(str));

String loginUserToJson(LoginUser data) => json.encode(data.toJson());

class LoginUser {
  LoginUser({
    required this.userId,
    required this.name,
    required this.email,
    required this.success,
  });

  int userId;
  String name;
  String email;
  String success;

  factory LoginUser.fromJson(Map<String, dynamic> json) => LoginUser(
    userId: json["user_id"],
    name: json["name"],
    email: json["email"],
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "name": name,
    "email": email,
    "success": success,
  };
}
