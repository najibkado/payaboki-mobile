import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:payaboki/models/confirm_user_model.dart';
import 'package:payaboki/models/data_model.dart';
import 'package:payaboki/models/depositVacct.dart';
import 'package:payaboki/models/reset_link.dart';
import 'package:payaboki/models/user.dart';
import 'package:payaboki/models/user_update_model.dart';
import 'package:payaboki/storage/storage.dart';

class Services {
  static const String url = 'https://www.payaboki.com/api/';
  //static const String url = 'http://10.0.2.2:8000/api/';
  static const String login = 'login';
  static const String logout = 'logout';
  static const String register = 'register';
  static const String verify = 'verify/';
  static const String recover = 'recover/';
  static const String send = 'send';
  static const String escrow = 'escrow';
  static const String userData = 'user-data';
  static const String confirm = 'user/';
  static const String deposit = 'vacct/';
  static const String descrow = 'vesc/';
  static const String approveEscrow = 'escrow/approve/';

  static String? token;
  static var headers;

  static void _headers() {
    LocalStorage.getToken().then((value) => {
          token = value!,
        });

    headers = {
      "Content-Type": "application/json",
      "Authorization": "Token " + token!
    };
  }

  //
  // static Future updateAppointment(appointmentId) async {
  //   String appointmentUpdate = 'appointment/update/$appointmentId';
  //   try {
  //     var appointmentUpdateUrl = Uri.parse(url + appointmentUpdate);
  //     _headers();
  //     var response = await http.get(appointmentUpdateUrl, headers: headers);
  //     if (response.statusCode == 200) {
  //       return jsonDecode(response.body).toString();
  //     } else {
  //       print(response.statusCode);
  //       print(response.body);
  //       throw (response.body);
  //     }
  //   } catch (e) {
  //     throw (e);
  //   }
  // }
  //
  // static Future getTreatments(patientId) async {
  //   String treatment = 'patients/$patientId/treatments';
  //   try {
  //     var treatmentUrl = Uri.parse(url + treatment);
  //     _headers();
  //     var response = await http.get(treatmentUrl, headers: headers);
  //     if (response.statusCode == 200) {
  //       return treatmentHistoryFromJson(response.body);
  //     } else {
  //       print(response.statusCode);
  //       print(response.body);
  //       throw (response.body);
  //     }
  //   } catch (e) {
  //     throw (e);
  //   }
  // }
  //
  // static Future getComplaints(patientId) async {
  //   String complaint = 'patients/$patientId/complaints';
  //   try {
  //     var complaintUrl = Uri.parse(url + complaint);
  //     _headers();
  //     var response = await http.get(complaintUrl, headers: headers);
  //     if (response.statusCode == 200) {
  //       return complaintsFromJson(response.body);
  //     } else {
  //       print(response.statusCode);
  //       print(response.body);
  //       throw (response.body);
  //     }
  //   } catch (e) {
  //     throw (e);
  //   }
  // }
  //
  // static Future setActivePayments(body) async {
  //   try {
  //     var requestInvestigationUrl = Uri.parse(url + finance);
  //     body = jsonEncode(body);
  //     var acceptedBody = jsonDecode(body);
  //     var response = await http.post(requestInvestigationUrl,
  //         headers: headers, body: acceptedBody);
  //     if (response.statusCode == 201) {
  //       return paymentFromJson(response.body);
  //     } else {
  //       print(response.statusCode);
  //       print(response.body);
  //       throw (response.body);
  //     }
  //   } catch (e) {
  //     throw (e);
  //   }
  // }
  //
  // static Future getActivePayments() async {
  //   try {
  //     var requestInvestigationUrl = Uri.parse(url + finance);
  //     var response = await http.get(requestInvestigationUrl, headers: headers);
  //     if (response.statusCode == 200) {
  //       return financeRequestModelFromJson(response.body);
  //     } else {
  //       print(response.statusCode);
  //       print(response.body);
  //       throw (response.body);
  //     }
  //   } catch (e) {
  //     throw (e);
  //   }
  // }
  //
  // static Future getActiveInvestigations() async {
  //   try {
  //     var requestInvestigationUrl = Uri.parse(url + requestInvestigation);
  //     var response = await http.get(requestInvestigationUrl, headers: headers);
  //     if (response.statusCode == 200) {
  //       return activeInvestigationsFromJson(response.body);
  //     } else {
  //       print(response.statusCode);
  //       print(response.body);
  //       throw (response.body);
  //     }
  //   } catch (e) {
  //     throw (e);
  //   }
  // }
  //
  static Future postRegister(body) async {
    try {
      var registerUrl = Uri.parse(url + register);
      body = jsonEncode(body);
      var acceptedBody = jsonDecode(body);

      var response = await http.post(registerUrl,
          body: acceptedBody, headers: {"Content-Type": "application/json"});
      if (response.statusCode == 201) {
        return userFromJson(response.body);
      } else {
        throw (response.body);
      }
    } catch (e) {
      throw (e);
    }
  }

  //
  // static Future addBlockData(body) async {
  //   try {
  //     var addDataUrl = Uri.parse(url + addData);
  //     body = jsonEncode(body);
  //     var acceptedBody = jsonDecode(body);
  //     _headers();
  //     var response =
  //     await http.post(addDataUrl, body: acceptedBody, headers: headers);
  //     if (response.statusCode == 201) {
  //       return jsonDecode(response.body);
  //     } else {
  //       print(response.statusCode);
  //       print(response.body);
  //       throw (response.body);
  //     }
  //   } catch (e) {
  //     throw (e);
  //   }
  // }
  //
  static Future getDepositAcct(amount) async {
    try {
      var depositUrl = Uri.parse(url + deposit + amount.toString());
      _headers();
      var response = await http.get(depositUrl, headers: headers);
      if (response.statusCode == 200) {
        return depositVacctFromJson(response.body);
      } else {
        throw (response.body);
      }
    } catch (e) {
      throw (e);
    }
  }

  static Future getVEscrowAcct(amount, id) async {
    try {
      var depositUrl =
          Uri.parse(url + descrow + amount.toString() + '/' + id.toString());

      _headers();
      var response = await http.get(depositUrl, headers: headers);
      if (response.statusCode == 200) {
        return depositVacctFromJson(response.body);
      } else {
        throw (response.body);
      }
    } catch (e) {
      throw (e);
    }
  }

  static Future approveEsc(id) async {
    try {
      var approveUrl = Uri.parse(url + approveEscrow + id.toString());

      _headers();
      var response = await http.get(approveUrl, headers: headers);
      if (response.statusCode == 201) {
        return true;
      } else {
        throw (response.body);
      }
    } catch (e) {
      print(e.toString());
      throw (e);
    }
  }
  //
  // static Future getEvents() async {
  //   try {
  //     var eventUrl = Uri.parse(url + event);
  //     _headers();
  //     var response = await http.get(eventUrl, headers: headers);
  //     if (response.statusCode == 200) {
  //       return eventsFromJson(response.body);
  //     } else {
  //       print(response.statusCode);
  //       print(response.body);
  //       throw (response.body);
  //     }
  //   } catch (e) {
  //     throw (e);
  //   }
  // }
  //
  // static Future getAppointmentInfo() async {
  //   try {
  //     var appointmentInfoUrl = Uri.parse(url + appointmentInfo);
  //     _headers();
  //     var response = await http.get(appointmentInfoUrl, headers: headers);
  //     if (response.statusCode == 200) {
  //       return appointmentInfoFromJson(response.body);
  //     } else {
  //       print(response.statusCode);
  //       print(response.body);
  //       throw (response.body);
  //     }
  //   } catch (e) {
  //     throw (e);
  //   }
  // }
  //
  // static Future setAppointment({body}) async {
  //   try {
  //     var appointmentUrl = Uri.parse(url + appointment);
  //     _headers();
  //     body = jsonEncode(body);
  //     var acceptedBody = jsonDecode(body);
  //     var response =
  //     await http.post(appointmentUrl, body: acceptedBody, headers: headers);
  //     if (response.statusCode == 201) {
  //       return appointmentFromJson(response.body);
  //     } else {
  //       print(response.statusCode);
  //       print(response.body);
  //       throw (response.body);
  //     }
  //   } catch (e) {
  //     throw (e);
  //   }
  // }
  //
  // static Future getPatientInformation(id) async {
  //   try {
  //     var patientInfoUrl = Uri.parse(url + patientInfo + id.toString());
  //     _headers();
  //     var response = await http.get(patientInfoUrl, headers: headers);
  //
  //     if (response.statusCode == 200) {
  //       return patientInformationFromJson(response.body);
  //     } else {
  //       print(response.statusCode);
  //       print(response.body);
  //       throw (response.body);
  //     }
  //   } catch (e) {
  //     throw (e);
  //   }
  // }
  //
  // static Future patientSetRequest({body}) async {
  //   try {
  //     var patientUrl = Uri.parse(url + patient);
  //     _headers();
  //     body = jsonEncode(body);
  //     var acceptedBody = jsonDecode(body);
  //     var response =
  //     await http.post(patientUrl, body: acceptedBody, headers: headers);
  //     if (response.statusCode == 201) {
  //       return patientFromJson(response.body);
  //     } else {
  //       print(response.statusCode);
  //       print(response.body);
  //       throw (response.body);
  //     }
  //   } catch (e) {
  //     throw (e);
  //   }
  // }
  //
  // // ignore: missing_return
  // static Future<Summary> summaryRequest() async {
  //   try {
  //     var summaryUrl = Uri.parse(url + summary);
  //     _headers();
  //     var response = await http.get(summaryUrl, headers: headers);
  //     if (response.statusCode == 200) {
  //       Summary userSummary = summaryFromJson(response.body);
  //       return userSummary;
  //     } else {
  //       throw ('Unable to get summary');
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //     throw ('Unable to get summary data');
  //   }
  // }

  static Future<UserConfirm> confirmUser(username) async {
    try {
      var confirmUrl = Uri.parse(url + confirm + username);
      _headers();
      var response = await http.get(confirmUrl, headers: headers);
      if (response.statusCode == 200) {
        return userConfirmFromJson(response.body);
      } else {
        throw ('Unable to get user');
      }
    } catch (e) {
      // print(e.toString());
      throw ('Error!');
    }
  }

  static Future<Update> userUpdate() async {
    try {
      var updateUrl = Uri.parse(url + userData);
      _headers();
      var response = await http.get(updateUrl, headers: headers);
      if (response.statusCode == 200) {
        return updateFromJson(response.body);
      } else {
        throw ('Unable to get update');
      }
    } catch (e) {
      // print(e.toString());
      throw (e);
    }
  }

  static Future<bool> sendTransaction(body) async {
    try {
      var sendUrl = Uri.parse(url + send);
      _headers();
      var response = await http.post(sendUrl, body: body, headers: headers);
      if (response.statusCode == 201) {
        print('Funds Sent Successfully');
        return true;
      } else {
        throw ('Error Sending Funds');
      }
    } catch (e) {
      // print(e.toString());
      throw (e);
    }
  }

  static Future<bool> escrowTransaction(body) async {
    try {
      var escrowUrl = Uri.parse(url + escrow);
      _headers();
      var response = await http.post(escrowUrl, body: body, headers: headers);
      if (response.statusCode == 201) {
        return true;
      } else {
        throw ('Error Sending Funds');
      }
    } catch (e) {
      // print(e.toString());
      throw (e);
    }
  }

  static Future<bool> setNewPassword(body, url) async {
    try {
      var newPasswordUrl = Uri.parse(url);
      print(newPasswordUrl);
      var response = await http.post(newPasswordUrl,
          body: body, headers: {"Content-Type": "application/json"});
      if (response.statusCode == 202) {
        return true;
      } else {
        throw ('Unable to reset password');
      }
    } catch (e) {
      // print(e.toString());
      throw ('Error!');
    }
  }

  static Future<bool> verifyRequest(body, id) async {
    try {
      var verifyUrl = Uri.parse(url + verify + id.toString());
      _headers();
      var response = await http.post(verifyUrl, body: body, headers: headers);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw ('Wrong response code');
      }
    } catch (e) {
      // print(e.toString());
      throw ('Error!');
    }
  }

  static Future<ResetLink> verifyRecoverPasswordRequest(body, username) async {
    try {
      var verifyRecoverPasswordUrl = Uri.parse(url + recover + username);
      var response = await http.post(verifyRecoverPasswordUrl,
          body: body, headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        ResetLink link = resetLinkFromJson(response.body);
        return link;
      } else {
        throw ('Wrong response code');
      }
    } catch (e) {
      // print(e.toString());
      throw ('Error!');
    }
  }

  static Future<bool> recoverPasswordRequest(username) async {
    try {
      var recoverPasswordRequestUrl = Uri.parse(url + recover + username);

      var response = await http.get(recoverPasswordRequestUrl,
          headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        return true;
      } else {
        throw ('Unable to send OTP at the moment');
      }
    } catch (e) {
      throw ('Unable to send OTP at the moment');
    }
  }

  static Future<bool> otpRequest(id) async {
    try {
      var otpRequestUrl = Uri.parse(url + verify + id.toString());

      _headers();
      var response = await http.get(otpRequestUrl, headers: headers);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw ('Unable to send OTP at the moment');
      }
    } catch (e) {
      throw ('Unable to send OTP at the moment');
    }
  }

  static Future<Data> loginRequest(username, password) async {
    try {
      var loginUrl = Uri.parse(url + login);
      var response = await http
          .post(loginUrl, body: {'username': username, 'password': password});
      if (response.statusCode == 200) {
        Data data = dataFromJson(response.body);
        return data;
      } else {
        throw ('invalid user credentials');
      }
    } catch (e) {
      throw (e);
    }
  }

  static Future<bool> logoutRequest() async {
    try {
      var logoutUrl = Uri.parse(url + logout);
      _headers();
      var response = await http.get(logoutUrl, headers: headers);
      if (response.statusCode == 401) {
        return true;
      } else {
        throw ('Unable to logout at the moment');
      }
    } catch (e) {
      throw ('Unable to logout at the moment');
    }
  }
}
