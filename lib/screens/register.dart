import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:payaboki/arguments/user_argument.dart';
import 'package:payaboki/constants.dart';
import 'package:payaboki/models/register.dart';
import 'package:payaboki/screens/login.dart';
import 'package:payaboki/screens/otp.dart';
import 'package:payaboki/services/services.dart';
import 'package:payaboki/storage/storage.dart';
import 'package:payaboki/utils.dart';
import 'package:payaboki/widgets/button.dart';

class Register extends StatefulWidget {
  static String id = "register_screen";

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late String _password;
  late String _email;
  late String _phone;
  late String _name;

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
                  hintText: "Name",
                ),
                onChanged: (value) => {_name = value},
              ),
              SizedBox(
                height: 25.0,
              ),
              TextField(
                decoration: kTextFieldDecoration.copyWith(
                  hintText: "Email",
                ),
                onChanged: (value) => {_email = value},
              ),
              SizedBox(
                height: 25.0,
              ),
              TextField(
                decoration: kTextFieldDecoration.copyWith(
                  hintText: "Phone",
                ),
                onChanged: (value) => {_phone = value},
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
                  if (_name?.isEmpty ?? true)
                    {
                      Utils.errorToast("Fields can't be empty"),
                    }
                  else if (_password?.isEmpty ?? true)
                    {
                      Utils.errorToast("Fields can't be empty"),
                    }
                  else if (_email?.isEmpty ?? true)
                    {
                      Utils.errorToast("Fields can't be empty"),
                    }
                  else if (_phone?.isEmpty ?? true)
                    {
                      Utils.errorToast("Fields can't be empty"),
                    }
                  else if (_name.length < 4 || _password.length < 4)
                    {
                      Utils.errorToast("Fields can't be empty"),
                    }
                  else
                    {
                      EasyLoading.show(status: "Setting up your account"),
                      _register(),
                    }
                },
                text: "Sign Up",
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
              Text(
                'By clicking Sign up, you agree to our terms and conditions, and Privacy policies.',
                style: TextStyle(
                  color: kSecondaryColor,
                  fontSize: 15.0,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 5.0,
              ),
              GestureDetector(
                onTap: () => {Navigator.pushNamed(context, Login.id)},
                child: Text(
                  'Already have an account? Sign In ',
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
    ));
  }

  void _register() async {
    RegisterModel register = RegisterModel(
        username: _email,
        firstName: _name,
        lastName: _phone,
        password: _password,
        email: _email);

    var body = registerToJson(register);

    Services.postRegister(body)
        .then((user) async => {
              LocalStorage.storeUser(user),
              EasyLoading.dismiss(),
              Navigator.pushNamed(context, OTP.id, arguments: UserArgs(user)),
            })
        .catchError((onError) {
      EasyLoading.dismiss();
      Utils.errorToast("Error, Please try again.");
    });
  }
}
