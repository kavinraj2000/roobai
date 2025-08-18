import 'package:flutter/material.dart';
import 'package:roobai/core/theme/constants.dart';


ThemeData theme() {
  return ThemeData(

    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Muli",
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,

    /*primarySwatch: Colors.red,
    primaryColor: isDarkTheme ? Colors.black : Colors.white,

    backgroundColor: isDarkTheme ? Colors.black : Color(0xffF1F5FB),
  
    indicatorColor: isDarkTheme ? Color(0xff0E1D36) : Color(0xffCBDCF8),
    //buttonColor: isDarkTheme ? Color(0xff3B3B3B) : Color(0xffF1F5FB),

    hintColor: isDarkTheme ? Color(0xff280C0B) : Color(0xffEECED3),

    highlightColor: isDarkTheme ? Color(0xff372901) : Color(0xffFCE192),
    hoverColor: isDarkTheme ? Color(0xff3A3A3B) : Color(0xff4285F4),

    focusColor: isDarkTheme ? Color(0xff0B2512) : Color(0xffA8DAB5),
    disabledColor: Colors.grey,
    //textSelectionColor: isDarkTheme ? Colors.white : Colors.black,
    cardColor: isDarkTheme ? Color(0xFF151515) : Colors.white,
    canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
    brightness: isDarkTheme ? Brightness.dark : Brightness.light,
    buttonTheme: Theme.of(context).buttonTheme.copyWith(
        colorScheme: isDarkTheme ? ColorScheme.dark() : ColorScheme.light()),*/
    /*appBarTheme: AppBarTheme(
      elevation: 0.0,
    ),*/

  );
}


InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: const BorderSide(color: textColor),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    // If  you are using latest version of flutter then lable text and hint text shown like this
    // if you r using flutter less then 1.20.* then maybe this is not working properly
    // if we are define our floatingLabelBehavior in our theme then it's not applayed
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: const EdgeInsets.symmetric(horizontal: 42, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}

TextTheme textTheme() {
  return TextTheme(
    bodyLarge: TextStyle(color: textColor),
    bodyMedium: TextStyle(color: textColor),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Colors.white,
    elevation: 0,
   // brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
    ),
      toolbarTextStyle: TextStyle()
     //textTheme: TextTheme(
      // headline6: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
    // ),
  );
}


