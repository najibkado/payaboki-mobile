import 'package:flutter/material.dart';
import 'package:payaboki/constants.dart';
import 'package:payaboki/models/otp_model.dart';
import 'package:payaboki/screens/new_password.dart';
import 'package:payaboki/services/services.dart';
import 'package:payaboki/utils.dart';
import 'package:payaboki/widgets/button.dart';

class RecoverOTP extends StatefulWidget {
  static const String id = "recover_otp";

  final username;

  RecoverOTP({super.key, this.username});

  @override
  State<RecoverOTP> createState() => _RecoverOTPState();
}

class _RecoverOTPState extends State<RecoverOTP> {
  late String _otp;
  late String _username;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    _username = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: height,
          width: width,
          margin: EdgeInsets.all(35),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50.0,
                ),
                Container(
                  width: width * 0.45,
                  height: height * 0.05,
                  child: Image.asset(
                    'images/logo.png',
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  height: 35.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Password Recovery',
                        style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: kSecondaryColor),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'A verification code has been sent to your email. Copy and paste it here to recover your password.',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  maxLength: 6,
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: "OTP",
                  ),
                  onChanged: (value) => {_otp = value},
                ),
                SizedBox(
                  height: 25.0,
                ),
                PrimaryButton(
                  onPressed: () => {
                    if (_otp?.isEmpty ?? true)
                      {
                        Utils.errorToast("OTP can't be empty"),
                      }
                    else if (_otp.length < 4)
                      {
                        Utils.errorToast("OTP can't be empty"),
                      }
                    else
                      {
                        _verifyCode(),
                      }
                  },
                  text: "Verify",
                ),
                SizedBox(
                  height: 25.0,
                ),
                SizedBox(
                  width: 100.0,
                  child: Container(
                    height: 2.0,
                    color: Colors.black12,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                GestureDetector(
                  onTap: () => {
                    _recoverPasswordRequest(),
                  },
                  child: Text(
                    'Resend code',
                    style: TextStyle(
                      color: kSecondaryColor,
                      fontSize: 15.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _recoverPasswordRequest() {
    Services.recoverPasswordRequest(_username)
        .then((value) async => {
              if (value)
                {
                  Utils.successToast("OTP sent to your email"),
                  // Navigator.pushNamed(context, RecoverOTP.id,
                  //     arguments: _username),
                }
            })
        .catchError((onError) {
      Utils.errorToast("Unable to send OTP, Try again!");
    });
  }

  void _verifyCode() {
    OtpModel data = OtpModel(user: _username, token: _otp);
    var body = otpModelToJson(data);
    Services.verifyRecoverPasswordRequest(body, _username)
        .then((value) async =>
            {Navigator.pushNamed(context, NewPassword.id, arguments: value)})
        .catchError((onError) {
      Utils.errorToast("Unable to Verify OTP");
    });
  }
}
