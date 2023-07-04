import 'package:flutter/material.dart';

const kBackgroundColor = Color(0xFFFCFDFF);
const kPrimaryColor = Colors.deepOrange;
const kSecondaryColor = Color(0xFF10386F);
const kAccentColor = Color(0xFF273952);

const kTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
  filled: true,
  fillColor: Colors.white,
  hintText: "Email",
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    borderSide: BorderSide(color: kPrimaryColor, width: 0),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    borderSide: BorderSide(color: Colors.black12, width: 2.0),
  ),
);

const kTitleTextDecoration = TextStyle(
  fontSize: 15.0,
  fontWeight: FontWeight.bold,
  color: kPrimaryColor,
);

const kTextStyleDecoration = TextStyle(
  fontSize: 15.0,
  fontWeight: FontWeight.bold,
  color: kAccentColor,
);

const kActiveHeadNavTitleDecoration = TextStyle(
  fontSize: 15.0,
  color: kPrimaryColor,
);

const kHeadNavTitleDecoration = TextStyle(
  fontSize: 15.0,
);

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kTextFieldInputDecoration = InputDecoration(
  hintText: 'Enter a value',
  hintStyle: TextStyle(color: Colors.grey),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
