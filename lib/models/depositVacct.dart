// To parse this JSON data, do
//
//     final depositVacct = depositVacctFromJson(jsonString);

import 'dart:convert';

DepositVacct depositVacctFromJson(String str) =>
    DepositVacct.fromJson(json.decode(str));

String depositVacctToJson(DepositVacct data) => json.encode(data.toJson());

class DepositVacct {
  DepositVacct({
    required this.responseCode,
    required this.responseMessage,
    required this.flwReference,
    required this.orderRef,
    required this.accountstatus,
    required this.frequency,
    required this.bankname,
    required this.createdOn,
    required this.expiryDate,
    required this.note,
    required this.amount,
  });

  String responseCode;
  String responseMessage;
  String flwReference;
  String orderRef;
  String accountstatus;
  int frequency;
  String bankname;
  int createdOn;
  int expiryDate;
  String note;
  String amount;

  factory DepositVacct.fromJson(Map<String, dynamic> json) => DepositVacct(
        responseCode: json["response_code"],
        responseMessage: json["response_message"],
        flwReference: json["flw_reference"],
        orderRef: json["orderRef"],
        accountstatus: json["accountstatus"],
        frequency: json["frequency"],
        bankname: json["bankname"],
        createdOn: json["created_on"],
        expiryDate: json["expiry_date"],
        note: json["note"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "response_message": responseMessage,
        "flw_reference": flwReference,
        "orderRef": orderRef,
        "accountstatus": accountstatus,
        "frequency": frequency,
        "bankname": bankname,
        "created_on": createdOn,
        "expiry_date": expiryDate,
        "note": note,
        "amount": amount,
      };
}
