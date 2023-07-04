// To parse this JSON data, do
//
//     final register = registerFromJson(jsonString);

import 'dart:convert';

RegisterModel registerFromJson(String str) =>
    RegisterModel.fromJson(json.decode(str));

String registerToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  RegisterModel({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.email,
  });

  String username;
  String firstName;
  String lastName;
  String password;
  String email;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        username: json["username"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        password: json["password"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "first_name": firstName,
        "last_name": lastName,
        "password": password,
        "email": email,
      };
}
