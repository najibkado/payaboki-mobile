// To parse this JSON data, do
//
//     final newPasswordModel = newPasswordModelFromJson(jsonString);

import 'dart:convert';

NewPasswordModel newPasswordModelFromJson(String str) =>
    NewPasswordModel.fromJson(json.decode(str));

String newPasswordModelToJson(NewPasswordModel data) =>
    json.encode(data.toJson());

class NewPasswordModel {
  NewPasswordModel({
    required this.newPassword,
  });

  String newPassword;

  factory NewPasswordModel.fromJson(Map<String, dynamic> json) =>
      NewPasswordModel(
        newPassword: json["new_password"],
      );

  Map<String, dynamic> toJson() => {
        "new_password": newPassword,
      };
}
