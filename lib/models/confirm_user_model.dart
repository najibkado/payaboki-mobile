import 'dart:convert';

UserConfirm userConfirmFromJson(String str) => UserConfirm.fromJson(json.decode(str));

String userConfirmToJson(UserConfirm data) => json.encode(data.toJson());

class UserConfirm {
  UserConfirm({
    required this.user,
    required this.id,
  });

  String user;
  int id;

  factory UserConfirm.fromJson(Map<String, dynamic> json) => UserConfirm(
    user: json["user"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "id": id,
  };
}
