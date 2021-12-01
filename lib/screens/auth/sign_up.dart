import 'package:ajopay/screens/auth/sign_in.dart';
import 'package:ajopay/screens/home/home.dart';
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

final DateTime timestamp = DateTime.now();

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isChecked = false;
  bool _obscurePassword = false;
  bool _obscureConfirmPassword = false;
  bool isLoading = false;
  var err = '';

  final _formKey = GlobalKey<FormState>();

  String validateEmail(String email) {
    if (!isEmail(email)) {
      return 'Please enter a valid email';
    }
    return '';
  }

  String validateInput(String text, String label) {
    if (text.isEmpty) {
      return 'Please enter ' + label;
    }
    return '';
  }

  void navigateToLogin() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignIn()));
  }

  void setObscurePassword() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void setObscureConfirmPassword() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    form?.save();
    if (form!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    err = "";
    setState(() {
      isLoading = true;
    });
    final form = _formKey.currentState;
    form?.save();
    if (validateAndSave()) {
      if (passwordController.text == confirmPasswordController.text) {
        FirebaseFirestore.instance
            .collection('users')
            .where('phoneNumber', isEqualTo: phoneNumberController.text)
            .get()
            .then((QuerySnapshot querySnapshot) => {
                  if (querySnapshot.size > 0)
                    {
                      err = "Phone number already exist.",
                      showCenterShortToast("Phone number already exist"),
                    }
                  else
                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text)
                        .then((currentUser) => FirebaseFirestore.instance
                            .collection("users")
                            .doc(currentUser.user!.uid)
                            .set({
                              "id": currentUser.user!.uid,
                              "phoneNumber": phoneNumberController.text,
                              "photoUrl": "",
                              "email": emailController.text,
                              "displayName": lastNameController.text +
                                  " " +
                                  firstNameController.text,
                              "bio": "",
                              "timestamp": timestamp,
                            })
                            .then((result) => {
                                  prefs.setBool('auth', true),
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Home()),
                                      (_) => false),
                                  form?.reset()
                                })
                            .catchError((err) => {
                                  showCenterShortToast("Email already exist"),
                                }))
                        .catchError((err) => {
                              showCenterShortToast("Email already exist"),
                            })
                });
      } else {
        showCenterShortToast("Password must match");
      }
    } else {}
    setState(() {
      isLoading = false;
    });
  }

  void showCenterShortToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white);
  }

  Widget showCircularProgress() {
    if (isLoading == true) {
      return const Center(child: CircularProgressIndicator());
    }
    return const SizedBox();
  }

  String? emailValidator(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern, caseSensitive: false);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String? pwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _obscurePassword = true;
    _obscureConfirmPassword = true;
  }

  Widget _signInButton() {
    return GestureDetector(
      onTap: () {
        //login();
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFF1F1FA),
            style: BorderStyle.solid,
            width: 1.0,
          ),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Image(image: AssetImage("assets/images/google.jpg"), height: 30.0),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Sign Up with Google',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: baseBlack,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return primaryColor;
      }
      return primaryColor;
    }

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
                    controller: firstNameController,
                    hintText: "First Name",
                    autofocus: false,
                    validator: (value) => validateInput(value!, "First Name"),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: InputTextField(
                    controller: lastNameController,
                    hintText: "Last Name",
                    autofocus: false,
                    validator: (value) => validateInput(value!, "Last Name"),
                  ),
                ),
                const SizedBox(
                  height: 20,
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
                    setObscureText: setObscurePassword,
                    controller: passwordController,
                    hintText: "Password",
                    autofocus: false,
                    validator: (value) => validateInput(value!, "Password"),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: PasswordInputTextField(
                    setObscureText: setObscureConfirmPassword,
                    controller: confirmPasswordController,
                    hintText: "Confirm Password",
                    autofocus: false,
                    validator: (value) =>
                        validateInput(value!, "Confirm Password"),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                      Expanded(
                        child: RichText(
                            text: TextSpan(
                                text: "By signing up, you agree to the ",
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                                children: [
                              TextSpan(
                                  text: "Terms of Service and Privacy Policy",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {},
                                  style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: primaryColor))
                            ])),
                      ),
                    ],
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
                      buttonText: "Sign Up"),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                    child: Text("Or with"),
                  ),
                ),
                _signInButton(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                        text: TextSpan(
                            text: "Already have an account? ",
                            style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF91919F)),
                            children: [
                          TextSpan(
                              text: "Login",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  navigateToLogin();
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
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
