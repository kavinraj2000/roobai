import 'package:flutter/material.dart';

class AppConstants {
  const AppConstants();

  static final RegExp emailValidatorRegExp = RegExp(
    r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  final String emailNullError = "Please enter your email";
  final String invalidEmailError = "Please enter a valid email";
  final String passNullError = "Please enter your password";
  final String shortPassError = "Password is too short";
  final String matchPassError = "Passwords don't match";
  final String nameNullError = "Please enter your name";
  final String phoneNumberNullError = "Please enter your phone number";
  final String addressNullError = "Please enter your address";

  static const TextStyle headerblack = TextStyle(
    fontFamily: 'Figtree',
    fontSize: 12,

    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );
  static const TextStyle headerwhite = TextStyle(
    fontFamily: 'Figtree',
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static const TextStyle textblack = TextStyle(
    fontFamily: 'Figtree',
    fontSize: 11,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );
  static const TextStyle textwhite = TextStyle(
    fontFamily: 'Figtree',
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );
  static const TextStyle offer = TextStyle(
    fontFamily: 'Figtree',
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: Color.fromARGB(255, 96, 94, 94),
    decoration: TextDecoration.lineThrough,
    decorationThickness: 2,
    decorationColor: Color(0xFF000000),
  );
}
