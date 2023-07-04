import 'package:flutter/material.dart';
import 'package:payaboki/arguments/deposit_argument.dart';
import 'package:payaboki/screens/loading.dart';
import 'package:payaboki/widgets/button.dart';

class DepositInfo extends StatefulWidget {
  static const String id = 'deposit_info_screen';
  final transaction_data;
  const DepositInfo({Key? key, this.transaction_data}) : super(key: key);

  @override
  State<DepositInfo> createState() => _DepositInfoState();
}

class _DepositInfoState extends State<DepositInfo> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final data = ModalRoute.of(context)?.settings.arguments as DepositArgs;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          color: Colors.white,
          padding: EdgeInsets.all(35),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  'Transfer',
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  data.depositVacct.amount + ' NGN',
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 15.0,
                ),

                // SizedBox(
                //   height: 15.0,
                // ),
                // Text(
                //   me ? data.sender : data.reciever,
                //   style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w400),
                // ),
                Text(
                  'To',
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 15.0,
                ),
                data.is_escrow
                    ? Text(
                        "Escrow funds to " + data.escrowData,
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.w400),
                      )
                    : Text(
                        "Top Up your payaboki wallet",
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.w400),
                      ),
                SizedBox(
                  height: 5.0,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: Color(0xFFFFFBF8),
                    //border: Border.all(color: Colors.deepOrange),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        //offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              data.is_escrow
                                  ? Text(
                                      'Direct Escrow Request',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 15.0),
                                    )
                                  : Text(
                                      'Deposit Account Request',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 15.0),
                                    ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                data.depositVacct.createdOn.toString(),
                                style: TextStyle(color: Colors.black87),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Divider(
                        color: Colors.black45,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Bank:',
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 15.0),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                data.depositVacct.bankname,
                                style: TextStyle(color: Colors.black87),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Account Number:',
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 15.0),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                '0078669803',
                                style: TextStyle(color: Colors.black87),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Account Expiry Date and Time',
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 15.0),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                data.depositVacct.expiryDate.toString(),
                                style: TextStyle(color: Colors.black87),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Deposit Request Reference',
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 15.0),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                data.depositVacct.orderRef,
                                style: TextStyle(color: Colors.black87),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 35.0,
                ),
                PrimaryButton(
                    onPressed: () => {Navigator.pushNamed(context, Loading.id)},
                    text: "Completed")
                // SizedBox(
                //   height: 5.0,
                // ),
                // Text(
                //   'or',
                //   style: TextStyle(color: Colors.black45),
                // ),
                // SizedBox(
                //   height: 5.0,
                // ),
                // Text(
                //   'Close',
                //   style: TextStyle(color: Colors.red),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
