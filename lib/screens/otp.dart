import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:payaboki/arguments/user_argument.dart';
import 'package:payaboki/constants.dart';
import 'package:payaboki/models/otp_model.dart';
import 'package:payaboki/screens/login.dart';
import 'package:payaboki/services/services.dart';
import 'package:payaboki/storage/storage.dart';
import 'package:payaboki/utils.dart';
import 'package:payaboki/widgets/button.dart';

class OTP extends StatefulWidget {
  static String id = "otp_screen";
  final user;
  const OTP({super.key, this.user});

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  late String _otp;
  late int _user_id;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final activeUser = ModalRoute.of(context)?.settings.arguments as UserArgs;
    _user_id = activeUser.user.userId;

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
                        'Email Verification',
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
                          'A verification code has been sent to your email. Copy and paste it here to verify your email.',
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
                        // _login(_username, _password),
                        // Navigator.pushNamed(context, Success.id)
                        EasyLoading.show(status: "Verifying your account"),
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
                    _requestOTP(),
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

  void _requestOTP() {
    Services.otpRequest(_user_id)
        .then((value) async => {
              if (value) {Utils.successToast("OTP sent to your email")}
            })
        .catchError((onError) {
      Utils.errorToast("Unable to send OTP, Try again!");
    });
  }

  void _verifyCode() {
    OtpModel data = OtpModel(user: _user_id, token: _otp);
    var body = otpModelToJson(data);
    Services.verifyRequest(body, _user_id).then((value) async => {
          if (value)
            {
              EasyLoading.dismiss(),
              EasyLoading.show(status: "Verified"),
              _logout(),
            }
          else
            {Utils.errorToast("Unable verify OTP, Try again!")}
        });
  }

  void _logout() {
    Services.logoutRequest()
        .then((value) => {
              if (value)
                {
                  LocalStorage.clearData(),
                  EasyLoading.dismiss(),
                  Navigator.pushNamed(context, Login.id)
                }
              // ignore: invalid_return_type_for_catch_error
            })
        .catchError((error) async => {
              Utils.errorToast("Unable to logout, try again"),
            });
  }
}
