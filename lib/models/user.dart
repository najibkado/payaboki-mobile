// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.userId,
    required this.user,
    required this.token,
  });

  int userId;
  UserClass user;
  String token;

  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json["user_id"],
    user: UserClass.fromJson(json["user"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "user": user.toJson(),
    "token": token,
  };
}

class UserClass {
  UserClass({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  String username;
  String firstName;
  String lastName;
  String email;

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
    username: json["username"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
  };
}
