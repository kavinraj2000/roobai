import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:roobai/comman/model/base_model.dart';
import 'package:roobai/comman/repo/app_api_repository.dart';

class ApiDatabase {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: APIS.mainurl,
    headers: APIS.headers,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  final Logger _log = Logger();
  final _storage = const FlutterSecureStorage();

  Future<BaseModel> getPageData() async {
    try {
      final response = await _dio.get(""); // put actual endpoint

      if (response.statusCode == 200) {
        final baseModel = BaseModel.fromJson(response.data);

        _log.i("Response Code: ${response.statusCode}");
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

  Future<String> getBaseUrl() async {
    try {
      final storedBaseUrl = await _storage.read(
        key: 'base_api_url',
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions(),
      );

      if (storedBaseUrl != null && storedBaseUrl.isNotEmpty) {
        _log.i("✅ Using stored BaseUrl: $storedBaseUrl");
        return storedBaseUrl;
      }

      final fallbackUrl =
          Platform.isAndroid ? APIS.mainurl : APIS.mainurl;
      _log.w("⚠️ No stored BaseUrl found, using fallback: $fallbackUrl");
      return fallbackUrl;
    } catch (e, stack) {
      _log.e("ApiDatabase::getBaseUrl::$e", stackTrace: stack);
      rethrow;
    }
  }
  Future<String> getbannerurl() async {
    try {
      final storedBaseUrl = await _storage.read(
        key: 'bannerlist',
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions(),
      );

      if (storedBaseUrl != null && storedBaseUrl.isNotEmpty) {
        _log.i("✅ Using stored BaseUrl: $storedBaseUrl");
        return storedBaseUrl;
      }

      final fallbackUrl =
          Platform.isAndroid ? APIS.mainurl : APIS.mainurl;
      _log.w("⚠️ No stored BaseUrl found, using fallback: $fallbackUrl");
      return fallbackUrl;
    } catch (e, stack) {
      _log.e("ApiDatabase::getBaseUrl::$e", stackTrace: stack);
      rethrow;
    }
  }
  Future<void> _storeData(BaseModel baseModel) async {
    await _storage.write(
      key: 'website',
      value: baseModel.website ?? '',
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
    await _storage.write(
      key: 'ios_version',
      value: baseModel.iosVersion ?? '',
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
    await _storage.write(
      key: 'android_version',
      value: baseModel.androidVersion ?? '',
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
    await _storage.write(
      key: 'giveaway_token',
      value: baseModel.giveawayToken ?? '',
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
    await _storage.write(
      key: 'refcode1',
      value: baseModel.refcode1 ?? '',
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
    await _storage.write(
      key: 'refcode2',
      value: baseModel.refcode2 ?? '',
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
    await _storage.write(
      key: 'reftitle',
      value: baseModel.reftitle ?? '',
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
    await _storage.write(
      key: 'affiliate_disclosure',
      value: baseModel.affiliateDisclosure ?? '',
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
    await _storage.write(
      key: 'banner',
      value: baseModel.banner ?? '',
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );

    final baseUrlToSave = Platform.isAndroid
        ? (baseModel.baseApiUrl ?? APIS.mainurl)
        : (baseModel.ios_base_api_url ?? APIS.mainurl);

    await _storage.write(
      key: 'base_api_url',
      value: baseUrlToSave,
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
    final bannerUrlToSave = Platform.isAndroid
        ? (baseModel.baseApiUrl ?? APIS.bannerurl)
        : (baseModel.ios_base_api_url ?? APIS.bannerurl);
await _storage.write(
      key: 'bannerlist',
      value: bannerUrlToSave,
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
    _log.i("💾 Stored BaseUrl: $baseUrlToSave");
    _log.i("💾 Stored bannerlist: $baseUrlToSave");
  }

  IOSOptions _getIOSOptions() =>
      const IOSOptions(accessibility: KeychainAccessibility.first_unlock);

  AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);
}
