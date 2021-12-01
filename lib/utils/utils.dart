import 'package:flutter/material.dart';

const primaryColor = Color(0xFF7F3DFF);
const baseLightColor = Color(0xFFFCFCFC);
const greyColor = Color(0xFFEEE5FF);
const backgroundColor = Color(0xFFFFFFFF);
const baseBlack = Color(0xFF212325);
const baseBlackLight = Color(0XFF91919F);

bool isEmail(String email) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(p);

  return regExp.hasMatch(email);
}
