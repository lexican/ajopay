import 'package:ajopay/screens/auth/sign_in.dart';
import 'package:ajopay/screens/auth/sign_up.dart';
import 'package:ajopay/utils/utils.dart';
import 'package:ajopay/widgets/app_button/app_button.dart';
import 'package:ajopay/widgets/onboarding_card/onboarding_card.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController pageViewController = PageController();
  var pageLength = 3;
  var currentIndexPage = 0;

  void updatePage(index) {
    setState(() {
      currentIndexPage = index;
    });
  }

  void navigateToLogin() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignIn()));
  }

  void navigateToRegister() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignUp()));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: PageView(
                physics: const BouncingScrollPhysics(),
                controller: pageViewController,
                onPageChanged: (index) {
                  updatePage(index);
                },
                children: const <Widget>[
                  OnBoardingCard(
                    assetImage: "assets/svg/onboarding_icon_1.svg",
                    title: "Gain total control of your money",
                    description:
                        "Become your own money manager and make every cent count",
                  ),
                  OnBoardingCard(
                    assetImage: "assets/svg/onboarding_icon_2.svg",
                    title: "Know where your money goes",
                    description:
                        "Track your transaction easily, with categories and financial report",
                  ),
                  OnBoardingCard(
                    assetImage: "assets/svg/onboarding_icon_3.svg",
                    title: "Planning ahead",
                    description:
                        "Setup your budget for each category so you in control",
                  )
                ],
              )),
              const SizedBox(
                height: 20,
              ),
              DotsIndicator(
                dotsCount: pageLength,
                position: currentIndexPage.toDouble(),
                decorator: const DotsDecorator(
                  color: greyColor, // Inactive color
                  activeColor: primaryColor,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AppButton(
                    onPressed: navigateToRegister,
                    textColor: baseLightColor,
                    buttonColor: primaryColor,
                    buttonText: "Sign Up"),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AppButton(
                    onPressed: navigateToLogin,
                    textColor: primaryColor,
                    buttonColor: greyColor,
                    buttonText: "Login"),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
