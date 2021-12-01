// ignore: library_prefixes
import 'package:ajopay/models/user.dart' as modelUser;
import 'package:ajopay/screens/auth/forget_password.dart';
import 'package:ajopay/screens/auth/sign_up.dart';
import 'package:ajopay/utils/utils.dart';
import 'package:ajopay/widgets/app_button/app_button.dart';
import 'package:ajopay/widgets/input_text_field/input_text_field.dart';
import 'package:ajopay/widgets/password_text_field/password_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

final usersRef = FirebaseFirestore.instance.collection('users');

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late modelUser.User currentUser;

  bool isChecked = false;
  bool   _obscurePassword = false;

  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  String? validateEmail(String email) {
    if (!isEmail(email)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validateInput(String text, String label) {
    if (text.isEmpty) {
      return 'Please enter ' + label;
    }
    return null;
  }

  void navigateToRegister() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignUp()));
  }

  void navigateToForgetPassword() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ForgetPassword()));
  }

  void validateAndSubmit() async {
    setState(() {
      isLoading = true;
    });

    final form = _formKey.currentState;
    form?.save();
    if (validateAndSave()) {
      print("emailController.text  " + emailController.text);
      print("passwordController.text  " + passwordController.text);
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        if (userCredential.user != null) {
          print("New Sign in: " + userCredential.user!.uid);
          DocumentSnapshot doc =
              await usersRef.doc(userCredential.user!.uid).get();
          currentUser = modelUser.User.fromSnapshot(doc);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('auth', true);

          prefs.setString('email', currentUser.email);
          prefs.setString('displayName', currentUser.displayName);
          prefs.setString('photoUrl', currentUser.photoUrl);
          prefs.setString('id', currentUser.id);
          prefs.setString('username', currentUser.username);

          setState(() {
            isLoading = false;
          });
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          //print('No user found for that email.');
          showCenterShortToast("User does not exist.");
        } else if (e.code == 'wrong-password') {
          //print('Wrong password provided for that user.');
          showCenterShortToast("Invalid username or password");
        }
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  void showCenterShortToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        timeInSecForIosWeb: 1);
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    form?.save();
    if (form!.validate()) {
      print("Valid form");
      return true;
    } else {
      print("Invalid form");
    }
    return false;
  }

  void setObscurePassword() {
    setState(() {
        _obscurePassword = !  _obscurePassword;
    });
  }

  @override
  void initState() {
    super.initState();
      _obscurePassword = true;
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

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
          "Login",
          style: TextStyle(
              color: baseBlack,
              fontSize: 18,
              fontFamily: "Inter",
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
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
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: PasswordInputTextField(
                    controller: passwordController,
                    hintText: "Password",
                    autofocus: false,
                    obsecureText: _obscurePassword,
                    setObscureText: setObscurePassword,
                    validator: (value) => validateInput(value!, "Password"),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: AppButton(
                      onPressed: validateAndSubmit,
                      textColor: baseLightColor,
                      buttonColor: primaryColor,
                      buttonText: "Login"),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 30),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        navigateToForgetPassword();
                      },
                      child: const Text(
                        "Forget Password",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF7F3DFF)),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                        text: TextSpan(
                            text: "Don't have an account yet? ",
                            style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF91919F)),
                            children: [
                          TextSpan(
                              text: "Sign Up",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  navigateToRegister();
                                },
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: primaryColor,
                              ))
                        ])),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
