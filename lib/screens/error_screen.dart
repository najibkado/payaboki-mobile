import 'package:flutter/material.dart';

class ErrorScreen extends StatefulWidget {
  static const String id = "error_screen";
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Error'),
    );
  }
}
