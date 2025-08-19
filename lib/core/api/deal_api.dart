import 'package:roobai/core/api/app_api.dart';
import 'package:roobai/core/theme/constants.dart';

class DealApi {
  static const String base_api_url = "base_api_url";
  // static const String defaultCategory = 'deal/';
  static const int defaultPageNumber = 1;

  /// Build a clean URL with no double slashes
  static var dealurl = '${APIS.baseurl + base_api_url}/$just_in/$defaultPageNumber';

  static final header = APIS.header;
  static final headers = APIS.headers;
}
