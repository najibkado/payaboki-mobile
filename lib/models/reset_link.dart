import 'dart:convert';

ResetLink resetLinkFromJson(String str) => ResetLink.fromJson(json.decode(str));

String resetLinkToJson(ResetLink data) => json.encode(data.toJson());

class ResetLink {
  ResetLink({
    required this.resetLink,
  });

  String resetLink;

  factory ResetLink.fromJson(Map<String, dynamic> json) => ResetLink(
        resetLink: json["reset_link"],
      );

  Map<String, dynamic> toJson() => {
        "reset_link": resetLink,
      };
}
