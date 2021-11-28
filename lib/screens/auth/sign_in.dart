import 'package:ajopay/utils/utils.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
          "Sign Up",
          style: TextStyle(color: baseBlack, fontSize: 18, fontFamily: "Inter", fontWeight: FontWeight.bold),
        ),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(),
        ),
      ),
    );
  }
}
