import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:payaboki/constants.dart';
import 'package:payaboki/screens/escrow_direct.dart';
import 'package:payaboki/screens/escrow_wallet.dart';
import 'package:payaboki/screens/loading.dart';
import 'package:payaboki/services/services.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class Escrow extends StatefulWidget {
  const Escrow({Key? key, this.escrowData}) : super(key: key);
  final escrowData;

  @override
  State<Escrow> createState() => _EscrowState();
}

class _EscrowState extends State<Escrow> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    var data = widget.escrowData;

    return Container(
      color: Colors.white,
      width: width,
      height: height,
      padding: EdgeInsets.all(35),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to PayAboki Escrow!',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.deepOrange),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Escrow from wallet and direct to bank',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              WalletFunction(
                title: "Wallet Escrow",
                onPressed: () {
                  pushNewScreen(
                    context,
                    screen: EscrowWallet(
                      user_data: data,
                    ),
                    withNavBar: false, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                icon: Icon(Icons.wallet),
              ),
              WalletFunction(
                title: "Direct Escrow",
                onPressed: () {
                  pushNewScreen(
                    context,
                    screen: EscrowDirect(
                      user_data: data,
                    ),
                    withNavBar: false, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                icon: Icon(Icons.send),
              ),
            ],
          ),
          const SizedBox(
            height: 35.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Escrow",
                style: kTitleTextDecoration,
              ),
              GestureDetector(
                child: Text("View All"),
                onTap: () {
                  //_showBottomSheet();
                  showBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              topRight: Radius.circular(15.0),
                            ),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 5,
                                //offset: Offset(0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Escrows",
                                    style: kTitleTextDecoration,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Icon(Icons.close,
                                        color: Colors.black45),
                                  ),
                                ],
                              ),
                              Container(
                                height: height * 0.8,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: data.escrowTransactions.length,
                                    itemBuilder: (context, index) {
                                      return EscrowSheet(
                                        approved: data.escrowTransactions[index]
                                            .approved!,
                                        me: data.escrowTransactions[index]
                                                    .recieverEmail ==
                                                data.me.username
                                            ? true
                                            : false,
                                        reciever: data
                                            .escrowTransactions[index].reciever,
                                        amount: data
                                            .escrowTransactions[index].amount
                                            .toString(),
                                        data: data.escrowTransactions[index],
                                        escrowPk: data
                                            .escrowTransactions[index].escrowId,
                                      );
                                    }),
                              )
                            ],
                          ),
                        );
                      });
                },
              )
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            height: height * 0.4,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: data.escrowTransactions.length,
                itemBuilder: (context, index) {
                  return EscrowSheet(
                    approved: data.escrowTransactions[index].approved!,
                    me: data.escrowTransactions[index].recieverEmail ==
                            data.me.username
                        ? true
                        : false,
                    reciever: data.escrowTransactions[index].reciever,
                    amount: data.escrowTransactions[index].amount.toString(),
                    data: data.escrowTransactions[index],
                    escrowPk: data.escrowTransactions[index].escrowId,
                  );
                }),
          )
        ],
      ),
    );
  }
}

class EscrowSheet extends StatelessWidget {
  bool approved;
  bool me;
  String amount;
  String reciever;
  int escrowPk;
  final data;
  EscrowSheet({
    Key? key,
    required this.approved,
    required this.me,
    required this.reciever,
    required this.amount,
    required this.data,
    required this.escrowPk,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showTransaction(context);
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
        height: 70.0,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                this.me
                    ? Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(2.0)),
                          color: Color(0xFFFFFBF8),
                          //border: Border.all(color: Colors.deepOrange),
                        ),
                        child: Icon(
                          Icons.download,
                          color: Colors.green,
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(2.0)),
                          color: Color(0xFFFFFBF8),
                          //border: Border.all(color: Colors.deepOrange),
                        ),
                        child: Icon(
                          Icons.upload,
                          color: Colors.red,
                        ),
                      ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  me ? data.sender : this.reciever,
                  style: TextStyle(fontSize: 15.0),
                ),
              ],
            ),
            Row(
              children: [
                approved
                    ? Text("")
                    : Icon(
                        Icons.lock,
                        size: 16.0,
                        color: Colors.red,
                      ),
                SizedBox(
                  width: 10.0,
                ),
                me
                    ? Text(
                        '+ ' + this.amount,
                        style: TextStyle(color: Colors.green, fontSize: 15.0),
                      )
                    : Text(
                        '- ' + this.amount,
                        style: TextStyle(color: Colors.red, fontSize: 15.0),
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showTransaction(context) {
    Scaffold.of(context).showBottomSheet((context) => Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(35),
          child: ListView(
            children: [
              CircleAvatar(
                radius: 20.0,
                child: Text(
                  me ? data.sender[0].toUpperCase() : reciever[0].toUpperCase(),
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.deepOrange,
              ),
              SizedBox(
                height: 25.0,
              ),
              Center(
                child: Text(
                  data.amount.toString() + ' NGN',
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: Text(
                  me ? 'Escrow From' : 'Escrow To',
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: Text(
                  me ? data.sender : data.reciever,
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: Text(
                  'on',
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: Text(
                  data.date.toString(),
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 10.0,
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
                          approved ? Icons.check_circle : Icons.lock_clock,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            data.method == 1
                                ? Text(
                                    'Wallet Escrow Successful',
                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 15.0),
                                  )
                                : Text(
                                    'Direct Escrow Successful',
                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 15.0),
                                  ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              data.date.toString(),
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
                              'From:' + '  ' + data.sender,
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 15.0),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              data.senderEmail,
                              style: TextStyle(color: Colors.black87),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'To:' + '  ' + data.reciever,
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 15.0),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              data.recieverEmail,
                              style: TextStyle(color: Colors.black87),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Transaction Charges',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 15.0),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              '20 NGN',
                              style: TextStyle(color: Colors.black87),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Transaction Reference',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 15.0),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              data.ref,
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
                height: 25.0,
              ),
              me
                  ? OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: Colors.deepOrange,
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Dispute',
                        style: TextStyle(color: Colors.deepOrange),
                      ),
                    )
                  : approved
                      ? SizedBox.shrink() //NOTE: We can add a dispute button to add dispute on a closed transaction
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: Colors.deepOrange,
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                'Dispute',
                                style: TextStyle(color: Colors.deepOrange),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.deepOrange, // background
                                onPrimary: Colors.white, // foreground
                              ),
                              onPressed: () {
                                _approveEsc(context, escrowPk);
                              },
                              child: Text('Approve'),
                            )
                          ],
                        ),
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Click here to close',
                    style: TextStyle(color: Colors.black45),
                  ),
                ),
              ),
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
        ));
  }

  void _approveEsc(context, id) {
    Services.approveEsc(id)
        .then((value) => {
              if (value == true)
                {
                  EasyLoading().backgroundColor = Colors.green,
                  EasyLoading.showToast("Funds Successfully Released",
                      duration: Duration(seconds: 5)),
                  Navigator.pushNamed(context, Loading.id),
                }
            })
        .catchError((err) {
      EasyLoading().backgroundColor = Colors.red;
      EasyLoading.showError("Unable to release funds",
          duration: Duration(seconds: 5));
      Navigator.pushNamed(context, Loading.id);
    });
  }
}

class WalletFunction extends StatelessWidget {
  String title;
  GestureTapCallback onPressed;
  Icon icon;

  WalletFunction(
      {Key? key,
      required this.title,
      required this.onPressed,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: Color(0xFFFFFBF8),
            //border: Border.all(color: Colors.deepOrange),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: IconButton(
            onPressed: onPressed,
            icon: icon,
            color: Colors.deepOrange,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.deepOrange,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }
}
