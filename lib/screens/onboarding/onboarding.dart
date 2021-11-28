import 'package:ajopay/utils/utils.dart';
import 'package:ajopay/widgets/app_button/app_button.dart';
import 'package:flutter/material.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              AppButton(
                  onPressed: () {},
                  textColor: baseLightColor,
                  buttonColor: primaryColor,
                  buttonText: "Sign Up"),
              const SizedBox(
                height: 20,
              ),
              AppButton(
                  onPressed: () {},
                  textColor: primaryColor,
                  buttonColor: greyColor,
                  buttonText: "Login"),
            ],
          ),
        ),
      ),
    );
  }
}
