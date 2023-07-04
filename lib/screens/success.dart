import 'package:flutter/material.dart';
import 'package:payaboki/screens/loading.dart';
import 'package:payaboki/widgets/button.dart';

class Success extends StatefulWidget {
  static const String id = "success_screen";

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
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
                const SizedBox(
                  height: 90.0,
                ),
                const SizedBox(
                  child: CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.lightGreen,
                    child: CircleAvatar(
                      backgroundColor: Color(0xFF1CB758),
                      radius: 90,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 65.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 35.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Transaction Successful',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                const SizedBox(
                  height: 250.0,
                ),
                PrimaryButton(
                  onPressed: () => {Navigator.pushNamed(context, Loading.id)},
                  text: "Done",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void _getUpdate() {
  //   Services.userUpdate()
  //       .then((data) => {
  //             // print(value),
  //             pushNewScreen(
  //               context,
  //               screen: Wallet(
  //                 walletData: WalletUpdateArgs(data.user, data.user.user,
  //                     data.walletInfo, data.transactions),
  //               ),
  //               withNavBar: true, // OPTIONAL VALUE. True by default.
  //               pageTransitionAnimation: PageTransitionAnimation.cupertino,
  //             )
  //           })
  //       .catchError((error) async => {print(error.toString())});
  // }
}
