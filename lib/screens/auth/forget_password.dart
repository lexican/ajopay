import 'package:ajopay/utils/utils.dart';
import 'package:ajopay/widgets/app_button/app_button.dart';
import 'package:ajopay/widgets/input_text_field/input_text_field.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController emailController = TextEditingController();

  String validateEmail(String email) {
    if (!isEmail(email)) {
      return 'Please enter a valid email';
    }
    return '';
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back,
            color: baseBlack,
            size: 30,
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Forget Password",
          style: TextStyle(
              color: baseBlack,
              fontSize: 18,
              fontFamily: "Inter",
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding:
                  EdgeInsets.only(top: 40, bottom: 30, left: 20, right: 20),
              child: Text(
                "Don’t worry Enter your email and we’ll send you a link to reset your password.",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: baseBlack),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InputTextField(
                controller: emailController,
                hintText: "Email",
                autofocus: false,
                validator: (value) => validateEmail(value!),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AppButton(
                  onPressed: () {},
                  textColor: baseLightColor,
                  buttonColor: primaryColor,
                  buttonText: "Continue"),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
