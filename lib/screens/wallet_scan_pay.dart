import 'package:flutter/material.dart';
import 'package:payaboki/arguments/wallet_scan_pay_args.dart';
import 'package:payaboki/constants.dart';
import 'package:payaboki/models/transaction_model.dart';
import 'package:payaboki/screens/error_screen.dart';
import 'package:payaboki/screens/loading.dart';
import 'package:payaboki/screens/success.dart';
import 'package:payaboki/services/services.dart';
import 'package:payaboki/widgets/button.dart';

class WalletScanPay extends StatefulWidget {
  static const String id = "wallet_scan_pay";
  final user_data;

  const WalletScanPay({Key? key, this.user_data}) : super(key: key);

  @override
  State<WalletScanPay> createState() => _WalletScanPayState();
}

class _WalletScanPayState extends State<WalletScanPay> {
  late String _email;
  late double _amount;
  bool verified = false;
  String _name = "";
  late int id;
  bool _balance_low = false;

  // @override
  // void initState() {
  //   _verifyUser(widget.user_data.rcv);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final userData = ModalRoute.of(context)?.settings.arguments as ScanPayArgs;
    _email = userData.rcv;
    // _verifyUser(_email);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: Colors.white,
        height: height,
        width: width,
        padding: EdgeInsets.all(35),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Send Funds',
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: kSecondaryColor),
                    ),
                  ],
                ),
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
              SizedBox(
                height: 50.0,
              ),
              TextField(
                decoration: kTextFieldDecoration.copyWith(
                  hintText: "Amount",
                ),
                onChanged: (value) => {
                  _amount = double.parse(value),
                  if (_amount <= userData.user_data.walletInfo.balance)
                    {
                      setState(() {
                        _balance_low = false;
                      }),
                    }
                  else
                    {
                      setState(() {
                        _balance_low = true;
                      }),
                    }
                },
              ),
              _balance_low
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: [
                            Text(
                              'Insufficient Balance',
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Container(),
              SizedBox(
                height: 25.0,
              ),
              Container(
                color: Colors.black12,
                height: 40.0,
                width: double.infinity,
                padding: EdgeInsets.all(10.0),
                child: Text(_email),
              ),
              verified
                  ? Column(
                      children: [
                        SizedBox(
                          height: 25.0,
                        ),
                        Container(
                          color: Colors.black12,
                          height: 40.0,
                          width: double.infinity,
                          padding: EdgeInsets.all(10.0),
                          child: Text(_name),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: 25.0,
                        ),
                        Container(
                          color: Colors.black12,
                          height: 40.0,
                          width: double.infinity,
                          padding: EdgeInsets.all(10.0),
                          child: Text("Yet to verify user"),
                        ),
                      ],
                    ),

              SizedBox(
                height: 25.0,
              ),
              verified
                  ? PrimaryButton(
                      onPressed: () => {
                        _sendRequest(
                            userData.user_data.userAuth.userId, id, _amount),
                      },
                      text: "Send",
                    )
                  : OutlinedButton(
                      onPressed: () => {
                        _verifyUser(_email),
                      },
                      child: Text(
                        "Verify Receiver",
                        style: TextStyle(color: Colors.deepOrange),
                      ),
                    ),
              SizedBox(
                height: 25.0,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Loading.id);
                },
                child: Text(
                  "Cancel Transaction",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _verifyUser(username) {
    Services.confirmUser(username)
        .then((value) => (setState(() {
              _name = value.user;
              verified = true;
              id = value.id;
            })))
        .catchError((err) => {
              setState(() {
                verified = false;
              }),
            });
  }

  void _sendRequest(sender, recv, amount) {
    Transaction data =
        Transaction(sender: sender, reciever: recv, amount: amount, method: 3);
    var body = transactionToJson(data);
    Services.sendTransaction(body)
        .then((value) => {
              if (value)
                {
                  Navigator.pushNamed(context, Success.id),
                }
              else
                {
                  Navigator.pushNamed(context, ErrorScreen.id),
                }
            })
        .catchError((err) => {
              Navigator.pushNamed(context, ErrorScreen.id),
            });
  }
}
