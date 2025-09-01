import 'package:logger/logger.dart';

class APIS {
  static var mainurl = "https://roo.bi/api/flutter/v13.0/";
  static var bannerurl='https://roo.bi/api/website/v10.1/';
  // static var header = {
  //   "Content-Type": "application/json",
  //   "AppMode": "flutter",
  //   "Access-Control-Allow-Origin": "*",
  //   "Access-Control-Allow-Credentials": "true",
  //   "Access-Control-Allow-Headers":
  //       "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
  //   "Access-Control-Allow-Methods": "POST, OPTIONS",
  // };

  static var headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    "Accept": "application/json",
    "AppMode": "android",
    "Token": "2304d5f65a9273202dce611154ba0c93",
  };

 
}
