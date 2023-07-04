import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:payaboki/arguments/data_argument.dart';
import 'package:payaboki/arguments/escrow_argument.dart';
import 'package:payaboki/arguments/wallet_argument.dart';
import 'package:payaboki/constants.dart';
import 'package:payaboki/models/user_update_model.dart';
import 'package:payaboki/screens/chat.dart';
import 'package:payaboki/screens/escrow.dart';
import 'package:payaboki/screens/login.dart';
import 'package:payaboki/screens/wallet.dart';
import 'package:payaboki/screens/wallet_scan.dart';
import 'package:payaboki/services/services.dart';
import 'package:payaboki/storage/storage.dart';
import 'package:payaboki/utils.dart';
import 'package:payaboki/widgets/button.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class Home extends StatefulWidget {
  static String id = 'home_screen';
  final userData;

  Home({super.key, this.userData});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late PersistentTabController _controller;
  late bool _hideNavBar;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;
  }

  List<Widget> _buildScreens(Update data) {
    return [
      Wallet(
        walletData: WalletArgs(
            data.user, data.user.user, data.walletInfo, data.transactions),
      ),
      Escrow(
        escrowData: EscrowArgs(
            data.user, data.user.user, data.walletInfo, data.escrowInfo.trans),
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.wallet),
        title: "Wallet",
        activeColorPrimary: Colors.deepOrange,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        // routeAndNavigatorSettings: RouteAndNavigatorSettings(
        //   initialRoute: Wallet.id,
        //   routes: {
        //     Wallet.id: (context) => Wallet(),
        //     WalletSend.id: (context) => WalletSend(),
        //   },
        // ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.lock_clock),
        title: "Escrow",
        activeColorPrimary: Colors.deepOrange,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        // routeAndNavigatorSettings: RouteAndNavigatorSettings(
        //   initialRoute: Home.id,
        //   routes: {
        //     WalletSend.id: (context) => WalletSend(),
        //     Wallet.id: (context) => Wallet(),
        //   },
        // ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final userData = ModalRoute.of(context)?.settings.arguments as DataArgs;
    final data = userData.userData;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, ChatScreen.id);
              },
              icon: Icon(
                Icons.headset_mic,
                color: Colors.grey,
              )),
          IconButton(
              onPressed: () {
                pushNewScreen(context,
                    screen: WalletScan(
                      walletInfo: WalletArgs(data.user, data.user.user,
                          data.walletInfo, data.transactions),
                    ));
              },
              icon: Icon(
                Icons.qr_code_scanner,
                color: Colors.grey,
              )),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: height * 0.8,
                      margin: EdgeInsets.all(35.0),
                      child: ListView(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "",
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.close, color: Colors.red),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                    backgroundColor: Colors.deepOrange,
                                    radius: 25.0,
                                  ),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Text(
                                    data.profile.name,
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ],
                              ),
                              CircleAvatar(
                                child: IconButton(
                                  onPressed: () {
                                    _showQRCode(data.profile.username,
                                        data.profile.name);
                                  },
                                  icon: Icon(
                                    Icons.qr_code,
                                    color: Colors.blue,
                                  ),
                                ),
                                backgroundColor: Colors.grey[200],
                                radius: 20.0,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            height: 1.0,
                            width: width,
                            color: Colors.black12,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            data.profile.name,
                            style: TextStyle(fontSize: 15.0),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            data.profile.username,
                            style: TextStyle(fontSize: 15.0),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            data.profile.phone,
                            style: TextStyle(fontSize: 15.0),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            height: 1.0,
                            width: width,
                            color: Colors.black12,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          PrimaryButton(
                            onPressed: () => {
                              EasyLoading.show(status: "Logging Out"),
                              _logout(),
                            },
                            text: "Logout",
                          ),
                        ],
                      ),
                    );
                  });
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 15.0, 30.0, 15.0),
              child: CircleAvatar(
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                backgroundColor: Colors.deepOrange,
                radius: 15.0,
              ),
            ),
          )
        ],
      ),
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(data),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style2, // Choose the nav bar style with this property.
      ),
    );
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

  void _showQRCode(username, name) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.deepOrange),
            margin: EdgeInsets.all(35.0),
            padding: EdgeInsets.all(15.0),
            height: 400.0,
            child: Column(
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       "",
                //     ),
                //     GestureDetector(
                //       onTap: () {
                //         Navigator.pop(context);
                //       },
                //       child: Icon(Icons.close, color: Colors.white),
                //     ),
                //   ],
                // ),
                Text(
                  "PayAboki QR Send",
                  style: kTitleTextDecoration.copyWith(
                      color: Colors.white, fontSize: 20.0),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  color: Colors.white,
                  height: 200,
                  width: 200,
                  child: SfBarcodeGenerator(
                    value: username,
                    symbology: QRCode(),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Scan to pay",
                        style: kTitleTextDecoration.copyWith(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        name,
                        style: TextStyle(fontSize: 25.0, color: Colors.white),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Swipe down to close",
                        style: TextStyle(fontSize: 15.0, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
