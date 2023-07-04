// To parse this JSON data, do
//
//     final otpModel = otpModelFromJson(jsonString);

import 'dart:convert';

OtpModel otpModelFromJson(String str) => OtpModel.fromJson(json.decode(str));

String otpModelToJson(OtpModel data) => json.encode(data.toJson());

class OtpModel {
  OtpModel({
    required this.user,
    required this.token,
  });

  var user;
  String token;

  factory OtpModel.fromJson(Map<String, dynamic> json) => OtpModel(
        user: json["user"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "code": token,
      };
}
