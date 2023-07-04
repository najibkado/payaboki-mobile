import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:payaboki/constants.dart';
import 'package:payaboki/models/data_model.dart';
import 'package:payaboki/screens/loading.dart';
import 'package:payaboki/screens/register.dart';
import 'package:payaboki/screens/reset.dart';
import 'package:payaboki/services/services.dart';
import 'package:payaboki/storage/storage.dart';
import 'package:payaboki/utils.dart';
import 'package:payaboki/widgets/button.dart';

class Login extends StatefulWidget {
  static String id = "login_screen";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late String _username;
  late String _password;

  // @override
  // void initState() {
  //   LocalStorage.isLoggedIn().then((value) => {
  //         if (value == true)
  //           {
  //             Navigator.pushNamed(context, Home.id),
  //           }
  //       });
  //   super.initState();
  // }

  void _login(username, password) async {
    Services.loginRequest(username, password)
        .then((Data data) async => {
              LocalStorage.storeUserData(data),
              // EasyLoading.showToast("Logged in"),
              EasyLoading.dismiss(),
              // Navigator.pushNamed(context, Home.id, arguments: DataArgs(data)),
              Navigator.pushNamed(context, Loading.id),
            })
        .catchError((onError) {
      EasyLoading.dismiss();
      Utils.errorToast("Invalid user credentials");
    });
  }

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
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: "Email",
                  ),
                  onChanged: (value) => {_username = value},
                ),
                SizedBox(
                  height: 25.0,
                ),
                TextField(
                  obscureText: true,
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: "Password",
                  ),
                  onChanged: (value) => {_password = value},
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
                    else if (_password?.isEmpty ?? true)
                      {
                        Utils.errorToast("Fields can't be empty"),
                      }
                    else if (_username.length < 2 || _password.length < 4)
                      {
                        Utils.errorToast("Fields can't be empty"),
                      }
                    else
                      {
                        EasyLoading.show(status: "Getting your account"),
                        _login(_username, _password),
                      }
                  },
                  text: "Sign In",
                ),
                const SizedBox(
                  height: 25.0,
                ),
                SizedBox(
                  width: 100.0,
                  child: Container(
                    height: 2.0,
                    color: Colors.black12,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                GestureDetector(
                  onTap: () =>
                      {Navigator.pushNamed(context, ForgetPassword.id)},
                  child: Text(
                    'Recover password',
                    style: TextStyle(
                      color: kSecondaryColor,
                      fontSize: 15.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                GestureDetector(
                  onTap: () => {Navigator.pushNamed(context, Register.id)},
                  child: Text(
                    'Don\'t have an account? Sign Up ',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
