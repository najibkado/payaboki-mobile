import 'package:flutter/material.dart';
import 'package:payaboki/constants.dart';

class PrimaryButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String text;

  PrimaryButton({required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45.0,
      child: RawMaterialButton(
        fillColor: kPrimaryColor,
        splashColor: kSecondaryColor,
        onPressed: onPressed,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15.0),
          ),
        ),
      ),
    );
  }
}
