import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


const primaryColor = Color(0xFF5824c9);
const offerColor = Color(0xFF22ddb9);
const textGreen = Color(0xFF33a072);
const textGreenShade = Color(0xFFe0f8eb);
const dayBack = Color(0xFFf1faff);
const secondaryColor = Color(0xFF2CB7DE);
const white = Color(0xFFFFFFFF);
const black = Color(0xFF000000);
const layBack = Color(0xFFF2F5FA);
const textColor = Color(0xFF28306E);
const textDarkColor = Color(0xFF151C4F);
const textAsh = Color(0xFF919296);
const cat_back = Color(0xFFCBCBCB);
const listBorder = Color(0xFFE7EEF6);
const menuText = Color(0xFFD8E5ED);
const menuText1 = Color(0xFFa1a9b9);
const strighthrough = Color(0xFF8b9ca7);
const low = Color(0xFFff7f56);
const clip_color = Color(0xFF798388);
const what_color = Color(0xFF2cb641);
const face_color = Color(0xFF4064ad);
const tele_color = Color(0xFF027cb9);
const twit_color = Color(0xFF1c9deb);

const medium = Color(0xFFfe5621);
const high = Color(0xFFee2b19);
const flip = Color(0xFF2874f0);

const discount1 = Color(0xFFffc000);
const discount2 = Color(0xFFff7f56);
const discount3 = Color(0xFFee2b19);
const discount4 = Color(0xFF2874f0);

const lay_bg = Color(0xFFEDF1F4);
const gjsonDecodeAnimationDuration = Duration(milliseconds: 200);
const just_in = '/deal/1/';
const cat_list = '/salecategory/1/';
const homepage = '/homepage/';
const deal_finder = '/deal_finder/';
const best = '/deal/2/';
const allcmt = 'allcmt/';
const productcmt = 'productcmt/';
const postcmt = 'postcmt/';
const banner = 'bannerlist/1/';

// Form Error
final RegExp emailValidatorRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String EmailNullError = "Please Enter your email";
const String InvalidEmailError = "Please Enter Valid Email";
const String PassNullError = "Please Enter your password";
const String ShortPassError = "Password is too short";
const String MatchPassError = "Passwords don't match";
const String NamelNullError = "Please Enter your name";
const String PhoneNumberNullError = "Please Enter your phone number";
const String AddressNullError = "Please Enter your address";

final otpInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: (15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular((15)),
    borderSide: const BorderSide(color: textColor),
  );
}

Future<String> getCountry() async {
  const storage = FlutterSecureStorage();
  String? value = await storage.read(key: 'countryCode');

  if (value != null && value.isNotEmpty) {
    return value;
  } else {
    return 'US';
  }
}

Future<String> getuserName() async {
  const storage = FlutterSecureStorage();
  String? value = await storage.read(key: 'userName');

  if (value != null) {
    return value;
  } else {
    return '';
  }
}

Future<String> getuserLastName() async {
  const storage = FlutterSecureStorage();
  String? value = await storage.read(key: 'userLastName');

  if (value != null) {
    return value;
  } else {
    return '';
  }
}

Future<String> getuserEmail() async {
  const storage = FlutterSecureStorage();
  String? value = await storage.read(key: 'userEmail');

  if (value != null) {
    return value;
  } else {
    return '';
  }
}

Future<String> getuserPhoneCode() async {
  const storage = FlutterSecureStorage();
  String? value = await storage.read(key: 'userPhoneCode');

  if (value != null && value.isNotEmpty) {
    return value;
  } else {
    return '+1';
  }
}

Future<String> getuserPhone() async {
  const storage = FlutterSecureStorage();
  String? value = await storage.read(key: 'userPhone');

  if (value != null) {
    return value;
  } else {
    return '';
  }
}

Future<String> getcountryCode() async {
  const storage = FlutterSecureStorage();
  String? value = await storage.read(key: 'countryCode');

  if (value != null && value.isNotEmpty) {
    return value;
  } else {
    return 'US';
  }
}

Future<String> getCountryCode_login() async {
  const storage = FlutterSecureStorage();
  String? value = await storage.read(key: 'countryCode_login');

  if (value != null && value.isNotEmpty) {
    return value;
  } else {
    return 'US';
  }
}

Future<String> getUserId() async {
  const storage = FlutterSecureStorage();
  String? value = await storage.read(key: 'id');

  if (value != null) {
    return value;
  } else {
    return '';
  }
}

IOSOptions _getIOSOptions() => const IOSOptions(
      accountName: 'roobai',
    );

AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );

Future<void> setcountryCode(String countryCode) async {
  const storage = FlutterSecureStorage();
  await storage.write(key: 'countryCode', value: countryCode, iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
}

Future<bool> getLogin() async {
  bool aa = false;
  const storage = FlutterSecureStorage();
  await storage.read(key: 'login_signup').then((value) {
    if (value != null && value == 'yes') {
      aa = true;
    } else {
      aa = false;
    }
  });
  return aa;
}

Future<String> getTokenUserId() async {
  String aa = "";
  const storage = FlutterSecureStorage();

  await storage.read(key: 'fcm_token', iOptions: _getIOSOptions(), aOptions: _getAndroidOptions()).then((value) {
    if (value != null) {
      aa = value.toString();
      var newString = aa.substring(aa.length - 10);
      aa = newString;
    } else {
      aa = "";
    }
  });
  return aa;
}

void showLoader1(BuildContext context) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (
          BuildContext context,
          StateSetter setStat /*You can rename this!*/,
        ) {
          return Column(
            children: [
              const Spacer(),
              SizedBox(
                width: 24,
                height: 24,
                child: GestureDetector(
                  child: const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red)),
                ),
              ),
              const Spacer()
            ],
          );
        });
      }).then((value) {});
}

Future<bool> getConnectivity() async {
  bool aa = true;
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      aa = true;
    }
  } on SocketException catch (_) {
    aa = false;
  }
  return aa;
}
