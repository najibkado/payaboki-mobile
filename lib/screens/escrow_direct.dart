import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:payaboki/arguments/deposit_argument.dart';
import 'package:payaboki/arguments/escrow_argument.dart';
import 'package:payaboki/constants.dart';
import 'package:payaboki/screens/deposit_acct_info.dart';
import 'package:payaboki/services/services.dart';
import 'package:payaboki/widgets/button.dart';

class EscrowDirect extends StatefulWidget {
  final user_data;
  const EscrowDirect({Key? key, this.user_data}) : super(key: key);

  @override
  State<EscrowDirect> createState() => _EscrowDirectState();
}

class _EscrowDirectState extends State<EscrowDirect> {
  late double _amount;
  late String _email;
  String _name = "";
  late int id;
  bool verified = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    EscrowArgs data = widget.user_data;

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
                  children: [
                    Text(
                      'Direct Escrow',
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
                },
              ),
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
                          if (_amount < 100)
                            {
                              EasyLoading.showError("Minimum amount is 100"),
                            }
                          else
                            {
                              _directEscrowReq(_amount, id, _name),
                            }
                        }
                    : () => {
                          EasyLoading.showError("Confirm User"),
                        },
                text: "Escrow Funds",
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

  void _directEscrowReq(amount, id, name) {
    Services.getVEscrowAcct(amount, id)
        .then((value) => {
              Navigator.pushNamed(context, DepositInfo.id,
                  arguments: DepositArgs(
                    depositVacct: value,
                    escrowData: name.toString(),
                    is_escrow: true,
                  ))
            })
        .catchError((err) => {
              print(err),
              EasyLoading.showError("Unable to fetch account"),
            });
  }
}
