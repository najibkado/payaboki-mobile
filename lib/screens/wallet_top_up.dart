import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:payaboki/arguments/deposit_argument.dart';
import 'package:payaboki/constants.dart';
import 'package:payaboki/screens/deposit_acct_info.dart';
import 'package:payaboki/services/services.dart';
import 'package:payaboki/widgets/button.dart';

class TopUp extends StatefulWidget {
  const TopUp({Key? key}) : super(key: key);

  @override
  State<TopUp> createState() => _TopUpState();
}

class _TopUpState extends State<TopUp> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    late double _amount;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.black,
        ),
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
                      'Top Up Wallet',
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

              SizedBox(
                height: 25.0,
              ),
              PrimaryButton(
                onPressed: () => {
                  if (_amount.isNaN)
                    {EasyLoading.showError("Enter amount")}
                  else if (_amount < 100)
                    {EasyLoading.showError("Min Topup is 100")}
                  else
                    {
                      _topUpReq(_amount),
                    }
                },
                text: "Top Up",
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _topUpReq(amount) {
    Services.getDepositAcct(amount)
        .then((value) => {
              Navigator.pushNamed(context, DepositInfo.id,
                  arguments: DepositArgs(
                    depositVacct: value,
                    escrowData: {},
                    is_escrow: false,
                  ))
            })
        .catchError((err) => {
              EasyLoading.showError("Unable to fetch account"),
            });
  }
}
