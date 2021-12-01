import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Function onPressed;
  final String buttonText;
  final Color textColor;
  final Color buttonColor;
  const AppButton(
      {Key? key,
      required this.onPressed,
      required this.textColor,
      required this.buttonColor,
      required this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.0)),
                  primary: buttonColor,
                  backgroundColor: buttonColor),
              child: Text(buttonText,
                  style: TextStyle(
                    fontSize: 18,
                    color: textColor,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600
                  )),
              onPressed: () {
                onPressed();
              }),
        ),
      ],
    );
  }
}
