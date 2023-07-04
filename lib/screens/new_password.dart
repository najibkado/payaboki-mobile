import 'package:flutter/material.dart';
import 'package:payaboki/constants.dart';
import 'package:payaboki/models/new_password_model.dart';
import 'package:payaboki/models/reset_link.dart';
import 'package:payaboki/screens/login.dart';
import 'package:payaboki/services/services.dart';
import 'package:payaboki/utils.dart';
import 'package:payaboki/widgets/button.dart';

class NewPassword extends StatefulWidget {
  static const String id = "new_password";
  final link;
  NewPassword({Key? key, this.link}) : super(key: key);

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  late String _conf_password;
  late String _password;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final link = ModalRoute.of(context)?.settings.arguments as ResetLink;

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
                        'Reset Password',
                        style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: kSecondaryColor),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                // Padding(
                //   padding: const EdgeInsets.all(1.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: [
                //       Text('Signup to enjoy our services', style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.w400,), textAlign: TextAlign.start,),
                //     ],
                //   ),
                // ),
                //
                // SizedBox(
                //   height: 50.0,
                // ),
                TextField(
                  obscureText: true,
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: "New Password",
                  ),
                  onChanged: (value) => {_password = value},
                ),
                SizedBox(
                  height: 25.0,
                ),
                TextField(
                  obscureText: true,
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: "Confirm Password",
                  ),
                  onChanged: (value) => {_conf_password = value},
                ),
                SizedBox(
                  height: 25.0,
                ),
                PrimaryButton(
                  onPressed: () => {
                    if (_password?.isEmpty ?? true)
                      {
                        Utils.errorToast("Fields can't be empty"),
                      }
                    else if (_conf_password?.isEmpty ?? true)
                      {
                        Utils.errorToast("Fields can't be empty"),
                      }
                    else if (_conf_password.length < 6 || _password.length < 6)
                      {
                        Utils.errorToast(
                            "Password Should be longer than 6 Characters"),
                      }
                    else
                      {
                        _new_password(link.resetLink),
                      }
                  },
                  text: "Submit",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _new_password(url) {
    NewPasswordModel pass = NewPasswordModel(newPassword: _password);
    var body = newPasswordModelToJson(pass);
    Services.setNewPassword(body, url)
        .then((value) => {
              if (value)
                {
                  Utils.successToast("Password Successfully Set"),
                  Navigator.pushNamed(context, Login.id),
                }
            })
        .catchError((onError) {
      Utils.errorToast("Unable to reset password");
      // Navigator.pushNamed(context, Login.id);
    });
  }
}
