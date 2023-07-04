import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:payaboki/screens/login.dart';
import 'package:payaboki/screens/register.dart';
import 'package:payaboki/storage/storage.dart';

class Onboarding extends StatefulWidget {
  static String id = 'onboarding_screen';

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  void initState() {
    _checkOnboarding();
    super.initState();
  }

  void _checkOnboarding() async {
    LocalStorage.isOnboarded().then((value) => {
          if (value == true)
            {
              Navigator.pushNamed(context, Login.id),
            }
        });
  }

  void _onIntroEnd(context) {
    LocalStorage.storeOnboarding();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => Register()),
    );
  }

  // Widget _buildFullscreenImage() {
  //   return Image.asset(
  //     'assets/fullscreen.jpg',
  //     fit: BoxFit.cover,
  //     height: double.infinity,
  //     width: double.infinity,
  //     alignment: Alignment.center,
  //   );
  // }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset(
      '$assetName',
      width: width,
      height: 170,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      autoScrollDuration: 3000,
      globalHeader: Align(
        alignment: Alignment.topCenter,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 0,
              right: 16,
            ),
            child: _buildImage('images/logo.png', 100),
          ),
        ),
      ),
      globalFooter: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
          child: const Text(
            'Let\'s go right away!',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          onPressed: () => _onIntroEnd(context),
        ),
      ),
      pages: [
        PageViewModel(
          title: "Escrow made easy",
          body:
              "Make business transactions easily by letting us stay in between you and your customers funds safely.",
          image: _buildImage('images/img1.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Quick support",
          body: "Enjoy seamless customer support with one click of a button.",
          image: _buildImage('images/img2.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Release on delivery",
          body: "Release transaction upon delivery to your doorstep.",
          image: _buildImage('images/img3.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Track payments",
          body: "Track escrow payments and see when funds have been released.",
          image: _buildImage('images/img4.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Cost effective services",
          body:
              "Enjoy cost effective service while keeping your funds secured.",
          image: _buildImage('images/img5.png'),
          decoration: pageDecoration,
        ),
      ],
      showSkipButton: true,
      skip: const Icon(
        Icons.skip_next,
        color: Colors.deepOrange,
      ),
      next: const Text(
        "Next",
        style: TextStyle(color: Colors.deepOrange),
      ),
      done: const Text("Done",
          style:
              TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.w700)),
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context),
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        activeColor: Colors.deepOrange,
        color: Colors.black26,
        spacing: const EdgeInsets.symmetric(horizontal: 3.0),
        activeShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
    );
  }
}
