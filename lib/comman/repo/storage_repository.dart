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

  final Logger _log = Logger();

  Future<BaseModel> getPageData() async {
    try {
      final response = await _dio.get("");
      if (response.statusCode == 200) {
        final baseModel = BaseModel.fromJson(response.data);
        _log.i("✅ Response Code: ${response.statusCode}");

        // Store important values
        await _storeData(baseModel);

        return baseModel;
      } else {
        throw Exception(
          '❌ Failed to fetch PageData: ${response.statusCode} ${response.data}',
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        _log.e("🚫 No Internet connection");
      } else {
        _log.e("ApiDatabase::getPageData::${e.message}");
      }
      rethrow;
    } catch (e, stack) {
      _log.e("ApiDatabase::getPageData::$e", stackTrace: stack);
      rethrow;
    }
  }

  /// Store important values in SharedPreferences
  Future<void> _storeData(BaseModel baseModel) async {
    final prefs = await SharedPreferences.getInstance();

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
    _log.i("💾 Stored BaseUrl: $baseUrl");

    // Banner URL
    final bannerUrl = Platform.isAndroid
        ? (baseModel.baseApiUrl ?? APIS.bannerurl)
        : (baseModel.iosBaseApiUrl ?? APIS.bannerurl);
    await prefs.setString("bannerlist", bannerUrl);
    _log.i("💾 Stored BannerUrl: $bannerUrl");
  }

  /// Get Base URL
  Future<String> getBaseUrl() async {
    final prefs = await SharedPreferences.getInstance();
    final url = prefs.getString("base_api_url") ?? APIS.mainurl;
    _log.i("✅ Using BaseUrl: $url");
    return url;
  }

  /// Get Banner URL
  Future<String> getBannerUrl() async {
    final prefs = await SharedPreferences.getInstance();
    final url = prefs.getString("bannerlist") ?? APIS.bannerurl;
    _log.i("✅ Using BannerUrl: $url");
    return url;
  }

  /// Optional: Clear stored data
  Future<void> clearStoredData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _log.i("🗑️ Cleared all stored data");
  }
}
