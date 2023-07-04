// To parse this JSON data, do
//
//     final update = updateFromJson(jsonString);

import 'dart:convert';

Update updateFromJson(String str) => Update.fromJson(json.decode(str));

String updateToJson(Update data) => json.encode(data.toJson());

class Update {
  Update({
    required this.user,
    required this.profile,
    required this.escrowInfo,
    required this.transactions,
    required this.walletInfo,
  });

  UpdateUser user;
  Profile profile;
  EscrowInfo escrowInfo;
  List<Tran> transactions;
  WalletInfo walletInfo;

  factory Update.fromJson(Map<String, dynamic> json) => Update(
        user: UpdateUser.fromJson(json["user"]),
        profile: Profile.fromJson(json["profile"]),
        escrowInfo: EscrowInfo.fromJson(json["escrowInfo"]),
        transactions:
            List<Tran>.from(json["transactions"].map((x) => Tran.fromJson(x))),
        walletInfo: WalletInfo.fromJson(json["walletInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "profile": profile.toJson(),
        "escrowInfo": escrowInfo.toJson(),
        "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
        "walletInfo": walletInfo.toJson(),
      };
}

class EscrowInfo {
  EscrowInfo({
    required this.trans,
  });

  List<Tran> trans;

  factory EscrowInfo.fromJson(Map<String, dynamic> json) => EscrowInfo(
        trans: List<Tran>.from(json["trans"].map((x) => Tran.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "trans": List<dynamic>.from(trans.map((x) => x.toJson())),
      };
}

class Tran {
  Tran({
    required this.escrowId,
    required this.sender,
    required this.senderEmail,
    required this.reciever,
    required this.recieverEmail,
    required this.amount,
    required this.approved,
    required this.method,
    required this.date,
    required this.time,
    required this.ref,
    required this.transactionId,
  });

  int? escrowId;
  String sender;
  String senderEmail;
  String reciever;
  String recieverEmail;
  double? amount;
  bool? approved;
  int? method;
  DateTime date;
  String time;
  String ref;
  int? transactionId;

  factory Tran.fromJson(Map<String, dynamic> json) => Tran(
        escrowId: json["escrow_id"],
        sender: json["sender"],
        senderEmail: json["sender_email"],
        reciever: json["reciever"],
        recieverEmail: json["reciever_email"],
        amount: json["amount"],
        approved: json["approved"],
        method: json["method"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
        ref: json["ref"],
        transactionId: json["transaction_id"],
      );

  Map<String, dynamic> toJson() => {
        "escrow_id": escrowId,
        "sender": sender,
        "sender_email": senderEmail,
        "reciever": reciever,
        "reciever_email": recieverEmail,
        "amount": amount,
        "approved": approved,
        "method": method,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time": time,
        "ref": ref,
        "transaction_id": transactionId,
      };
}

class Profile {
  Profile({
    required this.username,
    required this.name,
    required this.phone,
  });

  String username;
  String name;
  String phone;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        username: json["username"],
        name: json["name"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "name": name,
        "phone": phone,
      };
}

class UpdateUser {
  UpdateUser({
    required this.userId,
    required this.user,
  });

  int? userId;
  UserUser user;

  factory UpdateUser.fromJson(Map<String, dynamic> json) => UpdateUser(
        userId: json["user_id"],
        user: UserUser.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user": user.toJson(),
      };
}

class UserUser {
  UserUser({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  String username;
  String firstName;
  String lastName;
  String email;

  factory UserUser.fromJson(Map<String, dynamic> json) => UserUser(
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

class WalletInfo {
  WalletInfo({
    required this.walletId,
    required this.balance,
  });

  String walletId;
  double balance;

  factory WalletInfo.fromJson(Map<String, dynamic> json) => WalletInfo(
        walletId: json["wallet_id"],
        balance: json["balance"],
      );

  Map<String, dynamic> toJson() => {
        "wallet_id": walletId,
        "balance": balance,
      };
}

//TODO: Add dispute tracking from backend and frontend models.
//TODO: Add freeze tracking from backend and frontend.
