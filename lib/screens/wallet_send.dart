import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:payaboki/constants.dart';
import 'package:payaboki/models/transaction_model.dart';
import 'package:payaboki/screens/error_screen.dart';
import 'package:payaboki/screens/success.dart';
import 'package:payaboki/services/services.dart';
import 'package:payaboki/widgets/button.dart';

class WalletSend extends StatefulWidget {
  static const String id = "wallet_send";
  final user_data;

  const WalletSend({Key? key, this.user_data}) : super(key: key);

  @override
  State<WalletSend> createState() => _WalletSendState();
}

class _WalletSendState extends State<WalletSend> {
  late String _email;
  late double _amount;
  bool verified = false;
  String _name = "";
  late int id;
  bool _balance_low = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var data = widget.user_data;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: Container(
        height: height,
        width: width,
        color: Colors.white,
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
                  if (_amount <= data.walletInfo.balance)
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
              TextField(
                decoration: kTextFieldDecoration.copyWith(
                  hintText: "Email",
                ),
                onChanged: (value) => {
                  _email = value,
                  _verifyUser(_email),
                },
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
                  : SizedBox(
                      height: 5.0,
                    ),

              SizedBox(
                height: 25.0,
              ),
              PrimaryButton(
                onPressed: verified
                    ? () => {
                          //TODO: Code to send funds
                          //TODO: Model data to get user id
                          _sendRequest(data.userAuth.userId, id, _amount),
                        }
                    : () => {
                          EasyLoading.showError("Confirm User"),
                        },
                text: "Send",
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _verifyUser(uasename) {
    Services.confirmUser(uasename)
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
        Transaction(sender: sender, reciever: recv, amount: amount, method: 1);
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
