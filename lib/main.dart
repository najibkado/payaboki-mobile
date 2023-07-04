import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:payaboki/screens/chat.dart';
import 'package:payaboki/screens/deposit_acct_info.dart';
import 'package:payaboki/screens/error_screen.dart';
import 'package:payaboki/screens/home.dart';
import 'package:payaboki/screens/loading.dart';
import 'package:payaboki/screens/login.dart';
import 'package:payaboki/screens/new_password.dart';
import 'package:payaboki/screens/onboarding.dart';
import 'package:payaboki/screens/otp.dart';
import 'package:payaboki/screens/recoverOTP.dart';
import 'package:payaboki/screens/register.dart';
import 'package:payaboki/screens/reset.dart';
import 'package:payaboki/screens/success.dart';
import 'package:payaboki/screens/wallet.dart';
import 'package:payaboki/screens/wallet_scan_pay.dart';
import 'package:payaboki/screens/wallet_send.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: EasyLoading.init(),
      // ignore: missing_return
      onGenerateRoute: (settings) {
        if (settings.name == Onboarding.id) {
          final args = settings.arguments;
          return MaterialPageRoute(
            builder: (context) {
              return Onboarding();
            },
          );
        }
        if (settings.name == Home.id) {
          final args = settings.arguments;
          return MaterialPageRoute(
            builder: (context) {
              return Home(userData: args);
            },
          );
        }
        if (settings.name == Register.id) {
          final args = settings.arguments;
          return MaterialPageRoute(
            builder: (context) {
              return Register();
            },
          );
        }
        if (settings.name == Login.id) {
          final args = settings.arguments;
          return MaterialPageRoute(
            builder: (context) {
              return Login();
            },
          );
        }
        if (settings.name == OTP.id) {
          final args = settings.arguments;
          return MaterialPageRoute(
            builder: (context) {
              return OTP(user: args);
            },
          );
        }
        if (settings.name == Success.id) {
          final args = settings.arguments;
          return MaterialPageRoute(
            builder: (context) {
              return Success();
            },
          );
        }
        if (settings.name == ForgetPassword.id) {
          final args = settings.arguments;
          return MaterialPageRoute(
            builder: (context) {
              return ForgetPassword();
            },
          );
        }
        if (settings.name == RecoverOTP.id) {
          final args = settings.arguments;
          return MaterialPageRoute(
            builder: (context) {
              return RecoverOTP(username: args);
            },
          );
        }
        if (settings.name == NewPassword.id) {
          final args = settings.arguments;
          return MaterialPageRoute(
            builder: (context) {
              return NewPassword(link: args);
            },
          );
        }
        if (settings.name == WalletSend.id) {
          final args = settings.arguments;
          return MaterialPageRoute(
            builder: (context) {
              return WalletSend();
            },
          );
        }
        if (settings.name == ErrorScreen.id) {
          final args = settings.arguments;
          return MaterialPageRoute(
            builder: (context) {
              return ErrorScreen();
            },
          );
        }
        if (settings.name == Wallet.id) {
          final args = settings.arguments;
          return MaterialPageRoute(
            builder: (context) {
              return Wallet(walletData: args);
            },
          );
        }
        if (settings.name == Loading.id) {
          final args = settings.arguments;
          return MaterialPageRoute(
            builder: (context) {
              return Loading();
            },
          );
        }
        if (settings.name == DepositInfo.id) {
          final args = settings.arguments;
          return MaterialPageRoute(
            builder: (context) {
              return DepositInfo(transaction_data: args);
            },
          );
        }
        if (settings.name == WalletScanPay.id) {
          final args = settings.arguments;
          return MaterialPageRoute(
            builder: (context) {
              return WalletScanPay(user_data: args);
            },
          );
        }
        if (settings.name == ChatScreen.id) {
          final args = settings.arguments;
          return MaterialPageRoute(
            builder: (context) {
              return ChatScreen();
            },
          );
        }
      },
      initialRoute: Onboarding.id,
      routes: {
        Onboarding.id: (context) => Onboarding(),
        Home.id: (context) => Home(),
        Register.id: (context) => Register(),
        Login.id: (context) => Login(),
        Success.id: (context) => Success(),
        ErrorScreen.id: (context) => ErrorScreen(),
        OTP.id: (context) => OTP(),
        ForgetPassword.id: (context) => ForgetPassword(),
        RecoverOTP.id: (context) => RecoverOTP(),
        NewPassword.id: (context) => NewPassword(),
        WalletSend.id: (context) => WalletSend(),
        Wallet.id: (context) => Wallet(),
        Loading.id: (context) => Loading(),
        DepositInfo.id: (context) => DepositInfo(),
        WalletScanPay.id: (context) => WalletScanPay(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}
