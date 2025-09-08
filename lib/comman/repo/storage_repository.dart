import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:roobai/comman/model/base_model.dart';
import 'package:roobai/comman/repo/app_api_repository.dart';

class ApiDatabase {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: APIS.mainurl,
      headers: APIS.headers,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  final Logger log = Logger();

  // -------------------- API CALLS --------------------

  Future<BaseModel> getPageData() async {
    try {
      final response = await _dio.get("");
      if (response.statusCode == 200) {
        final baseModel = BaseModel.fromJson(response.data);
        log.i("✅ Response Code: ${response.statusCode}");

        // Clear old cache before storing new data
        await clearStoredData();

        // Store new data
        await _storeData(baseModel);

        return baseModel;
      } else {
        throw Exception(
          '❌ Failed to fetch PageData: ${response.statusCode} ${response.data}',
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        log.e("🚫 No Internet connection");
      } else {
        log.e("ApiDatabase::getPageData::${e.message}");
      }
      rethrow;
    } catch (e, stack) {
      log.e("ApiDatabase::getPageData::$e", stackTrace: stack);
      rethrow;
    }
  }

  Future<dynamic> getRequest({
    required String url,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final fullUrl = url;
      log.d("ApiRepository::getRequest::URL: $fullUrl, Query: $queryParams");

      final response = await _dio.get(
        fullUrl,
        queryParameters: queryParams,
      );

      return _handleResponse(response);
    } on DioException catch (dioError) {
      log.e("ApiRepository::getRequest::DioException: ${dioError.message}");
      throw _handleError(dioError);
    }
  }

  dynamic _handleResponse(Response response) {
    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      final data = response.data;
      if (data is Map) {
        return data;
      } else if (data is String) {
        try {
          return jsonDecode(data);
        } catch (error) {
          log.e("ApiRepository::_handleResponse::JSON decode error: $error");
          throw Exception("Failed to decode response JSON: $error");
        }
      } else {
        return data;
      }
    } else {
      log.e(
        "ApiRepository::_handleResponse::HTTP error ${response.statusCode} - ${response.statusMessage}",
      );
      throw Exception(
        "HTTP error: ${response.statusCode} - ${response.statusMessage}",
      );
    }
  }

  Exception _handleError(DioException error) {
    log.e("ApiRepository::_handleError::Error message: ${error.message}");
    String errormessage;
    switch (error.type) {
      case DioExceptionType.connectionError:
        errormessage = "Connection error.";
        break;
      case DioExceptionType.connectionTimeout:
        errormessage = "Connection timed out.";
        break;
      case DioExceptionType.receiveTimeout:
        errormessage = "Receive timeout.";
        break;
      case DioExceptionType.sendTimeout:
        errormessage = "Send timeout.";
        break;
      case DioExceptionType.cancel:
        errormessage = "Request cancelled.";
        break;
      case DioExceptionType.badResponse:
        errormessage =
            "Response Error: ${error.response?.statusCode} - ${error.response?.statusMessage}";
        break;
      case DioExceptionType.unknown:
      default:
        errormessage = "Unknown error: ${error.message}";
    }
    return Exception(errormessage);
  }

  // -------------------- CACHE MANAGEMENT --------------------

  Future<void> _storeData(BaseModel baseModel) async {
    final prefs = await SharedPreferences.getInstance();

    // Store values
    await prefs.setString("website", baseModel.website ?? '');
    await prefs.setString("ios_version", baseModel.iosVersion ?? '');
    await prefs.setString("android_version", baseModel.androidVersion ?? '');
    await prefs.setString("giveaway_token", baseModel.giveawayToken ?? '');
    await prefs.setString("refcode1", baseModel.refcode1 ?? '');
    await prefs.setString("refcode2", baseModel.refcode2 ?? '');
    await prefs.setString("reftitle", baseModel.reftitle ?? '');
    await prefs.setString("affiliate_disclosure", baseModel.affiliateDisclosure ?? '');
    await prefs.setString("banner", baseModel.banner ?? '');

    // Base URL
    final baseUrl = Platform.isAndroid
        ? (baseModel.baseApiUrl ?? APIS.mainurl)
        : (baseModel.iosBaseApiUrl ?? APIS.mainurl);
    await prefs.setString("base_api_url", baseUrl);
    log.i("💾 Stored BaseUrl: $baseUrl");

    // Banner URL
    final bannerUrl = Platform.isAndroid
        ? (baseModel.baseApiUrl ?? APIS.bannerurl)
        : (baseModel.iosBaseApiUrl ?? APIS.bannerurl);
    await prefs.setString("bannerlist", bannerUrl);
    log.i("💾 Stored BannerUrl: $bannerUrl");
  }

  /// Get stored base URL
  Future<String> getBaseUrl() async {
    final prefs = await SharedPreferences.getInstance();
    final url = prefs.getString("base_api_url") ?? APIS.mainurl;
    log.i("✅ Using BaseUrl: $url");
    return url;
  }

  /// Get stored banner URL
  Future<String> getBannerUrl() async {
    final prefs = await SharedPreferences.getInstance();
    final url = prefs.getString("bannerlist") ?? APIS.bannerurl;
    log.i("✅ Using BannerUrl: $url");
    return url;
  }

  /// Clear all stored data
  Future<void> clearStoredData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    log.i("🗑️ Cleared all stored data");
  }

  /// Remove specific cached keys
  Future<void> removeCachedKeys(List<String> keys) async {
    final prefs = await SharedPreferences.getInstance();
    for (var key in keys) {
      if (prefs.containsKey(key)) {
        await prefs.remove(key);
        log.i("🗑️ Removed cached key: $key");
      }
    }
  }

  /// Reset cached data to defaults
  Future<void> resetCachedData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("base_api_url", APIS.mainurl);
    await prefs.setString("bannerlist", APIS.bannerurl);
    log.i("🔄 Reset cached data to defaults");
  }
}
