import 'dart:convert';

Transaction transactionFromJson(String str) =>
    Transaction.fromJson(json.decode(str));

String transactionToJson(Transaction data) => json.encode(data.toJson());

class Transaction {
  Transaction({
    required this.sender,
    required this.reciever,
    required this.amount,
    required this.method,
  });

  int sender;
  int reciever;
  double amount;
  int method;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        sender: json["sender"],
        reciever: json["reciever"],
        amount: json["amount"],
        method: json["method"],
      );

  Map<String, dynamic> toJson() => {
        "sender": sender,
        "reciever": reciever,
        "amount": amount,
        "method": method,
      };
}
