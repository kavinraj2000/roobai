
class APIS {
  static var main_url = 'https://roobai.com/api/android/giveaway11/';
  

  static var header = {
   
    "Content-Type": "application/json",
    "AppMode": "flutter",
    "Access-Control-Allow-Origin": "*", // Required for CORS support to work
    //"Access-Control-Allow-Credentials": true, // Required for cookies, authorization headers with HTTPS
    "Access-Control-Allow-Headers":
        "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
    "Access-Control-Allow-Methods": "POST, OPTIONS"
  };

  static var headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    "Accept": "application/json",
    "AppMode": "android",
    "Token": "2304d5f65a9273202dce611154ba0c93"
  };
  
}
