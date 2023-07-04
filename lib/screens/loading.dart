import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:payaboki/arguments/data_argument.dart';
import 'package:payaboki/screens/home.dart';
import 'package:payaboki/screens/login.dart';
import 'package:payaboki/services/services.dart';
import 'package:payaboki/storage/storage.dart';
import 'package:payaboki/utils.dart';

class Loading extends StatefulWidget {
  static const String id = "loading_screen";
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    Services.userUpdate()
        .then((value) => {
              Navigator.pushNamed(context, Home.id, arguments: DataArgs(value)),
            })
        .catchError((onError) {
      EasyLoading.showError("Unable to load user data");
      _logout();
    });
    super.initState();
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
              EasyLoading.dismiss(),
              Utils.errorToast("Unable to logout, try again"),
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitPulse(
          color: Colors.deepOrange,
          size: 50.0,
        ),
      ),
    );
  }
}
