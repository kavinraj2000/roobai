import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:roobai/comman/constants/color_constansts.dart';
import 'package:roobai/comman/constants/constansts.dart';





final otpInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: (15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular((15)),
    borderSide: BorderSide(color:ColorConstants.textColor),
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
