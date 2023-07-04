import 'package:flutter/material.dart';
import 'package:payaboki/constants.dart';
import 'package:payaboki/screens/recoverOTP.dart';
import 'package:payaboki/services/services.dart';
import 'package:payaboki/utils.dart';
import 'package:payaboki/widgets/button.dart';

class ForgetPassword extends StatefulWidget {
  static const String id = "forget_password";

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  late String _username;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
              // Padding(
              //   padding: const EdgeInsets.all(1.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Text('Get started',style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold, color: kSecondaryColor),),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 50.0,
              ),
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Recover your password',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 50.0,
              ),
              TextField(
                decoration: kTextFieldDecoration.copyWith(
                  hintText: "Email",
                ),
                onChanged: (value) => {_username = value},
              ),
              SizedBox(
                height: 25.0,
              ),
              SizedBox(
                height: 25.0,
              ),
              PrimaryButton(
                onPressed: () => {
                  if (_username?.isEmpty ?? true)
                    {
                      Utils.errorToast("Fields can't be empty"),
                    }
                  else if (_username.length < 2)
                    {
                      Utils.errorToast("Fields can't be empty"),
                    }
                  else
                    {
                      _recoverPasswordRequest(),
                    }
                },
                text: "Send Code",
              ),
              const SizedBox(
                height: 25.0,
              ),
            ],
          ),
        ),
      ),
    ));
  }

  void _recoverPasswordRequest() {
    Services.recoverPasswordRequest(_username)
        .then((value) async => {
              if (value)
                {
                  Utils.successToast("OTP sent to your email"),
                  Navigator.pushNamed(context, RecoverOTP.id,
                      arguments: _username),
                }
            })
        .catchError((onError) {
      Utils.errorToast("Unable to send OTP, Try again!");
    });
  }
}
