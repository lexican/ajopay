import 'package:ajopay/screens/splash_screen.dart';
import 'package:ajopay/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0XFFF1F1FA)),
                borderRadius: BorderRadius.circular(10.0)),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0XFFDFDFDF)),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Color(0xFF0F77F0),
              ),
            ),
            fillColor: const Color(0xFFECF1F4)),
      ),
      home: const SplashScreen(),
    );
  }
}
