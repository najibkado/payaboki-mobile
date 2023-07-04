import 'package:flutter/material.dart';
import 'package:payaboki/constants.dart';
import 'package:payaboki/screens/wallet_send.dart';
import 'package:payaboki/screens/wallet_top_up.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class Wallet extends StatefulWidget {
  static const String id = "wallet";
  final walletData;
  const Wallet({Key? key, this.walletData}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    var data = widget.walletData;

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
                  data.walletInfo.balance.toString(),
                  style: TextStyle(
                      fontSize: 30.0,
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
                  data.walletInfo.walletId,
                  style: TextStyle(
                    fontSize: 13.0,
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
                title: "Top up",
                onPressed: () {
                  pushNewScreen(
                    context,
                    screen: TopUp(),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                icon: Icon(Icons.download),
              ),
              WalletFunction(
                title: "Send",
                onPressed: () {
                  pushNewScreen(
                    context,
                    screen: WalletSend(
                      user_data: data,
                    ),
                    withNavBar: false, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                icon: Icon(Icons.send),
              ),
              WalletFunction(
                title: "Withdraw",
                onPressed: () {},
                icon: Icon(Icons.upload),
              ),
            ],
          ),
          const SizedBox(
            height: 35.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: Text(
                  "Recent Transactions",
                  style: kTitleTextDecoration,
                ),
              ),
              GestureDetector(
                child: Text("View All"),
                onTap: () {
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
                          // margin: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
                          padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Transactions",
                                    style: kTitleTextDecoration,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.black45,
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                height: height * 0.8,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: data.transactions.length,
                                    itemBuilder: (context, index) {
                                      return TransactionSheet(
                                        me: data.transactions[index]
                                                    .recieverEmail ==
                                                data.me.username
                                            ? true
                                            : false,
                                        reciever:
                                            data.transactions[index].reciever,
                                        amount: data.transactions[index].amount
                                            .toString(),
                                        data: data.transactions[index],
                                      );
                                    }),
                              ),
                            ],
                          ),
                        );
                      });
                },
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            height: height * 0.4,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: data.transactions.length,
                itemBuilder: (context, index) {
                  return TransactionSheet(
                    me: data.transactions[index].recieverEmail ==
                            data.me.username
                        ? true
                        : false,
                    reciever: data.transactions[index].reciever,
                    amount: data.transactions[index].amount.toString(),
                    data: data.transactions[index],
                  );
                }),
          ),
        ],
      ),
    );
  }

  // void _showBottomSheet(data) {
  //   Scaffold.of(context).showBottomSheet(
  //     (context) => AbsorbPointer(
  //       child: Container(
  //         margin: EdgeInsets.all(35.0),
  //         child: Column(
  //           children: [
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text(
  //                   "Transactions",
  //                   style: kTitleTextDecoration,
  //                 ),
  //               ],
  //             ),
  //             ListView.builder(
  //                 shrinkWrap: true,
  //                 itemCount: data.transactions.length,
  //                 itemBuilder: (context, index) {
  //                   return TransactionSheet(
  //                     me: data.transactions[index].reciever == data.me.firstName
  //                         ? true
  //                         : false,
  //                     reciever: data.transactions[index].reciever,
  //                     amount: data.transactions[index].amount.toString(),
  //                     data: data.transactions[index],
  //                   );
  //                 }),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // DraggableScrollableSheet(
  // initialChildSize: 0.7,
  // minChildSize: 0.6,
  // builder:
  // (BuildContext context, ScrollController _controller) {
  // return Container(
  // color: Colors.black,
  // );
  // },
  // );
}

class TransactionSheet extends StatelessWidget {
  //Determines if i am the reciever. if true, then i am the reciever else i am not
  bool me;
  String reciever;
  String amount;
  final data;
  TransactionSheet({
    Key? key,
    required this.me,
    required this.reciever,
    required this.amount,
    required this.data,
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
            this.me
                ? Text(
                    '+ ' + this.amount,
                    style: TextStyle(color: Colors.green, fontSize: 15.0),
                  )
                : Text(
                    '- ' + this.amount,
                    style: TextStyle(color: Colors.red, fontSize: 15.0),
                  ),
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
          padding: EdgeInsets.all(35.0),
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
                height: 20.0,
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
                  me ? 'From' : 'Sent To',
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
                            Text(
                              'Wallet Payment Successful',
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
                      height: 15.0,
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
                      height: 15.0,
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
                      height: 15.0,
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
              Center(
                child: GestureDetector(
                  onTap: () => {
                    Navigator.pop(context),
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
                //offset: Offset(0, 1), // changes position of shadow
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
