import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:roobai/comman/repos/app_api_repository.dart';
import 'package:roobai/comman/model/base_model.dart';

class Apidatabase {
  final _log = Logger();
  final _storage = const FlutterSecureStorage();

  Future<BaseModel> getPageData() async {
    try {
      final response = await http.get(
        Uri.parse(APIS.mainurl),
        headers: APIS.headers,
      );

      if (response.statusCode == 200) {
        final baseModel = BaseModel.fromJson(jsonDecode(response.body));
        _log.i("Response Code: ${response.statusCode}");

        await _storeData(baseModel);

        return baseModel;
      } else {
        throw Exception(
          ' Failed to fetch PageData: ${response.statusCode} ${response.body}',
        );
      }
    } on SocketException catch (_) {
      _log.e("🚫 No Internet connection");
      rethrow;
    } catch (e, stack) {
      _log.e("Apidatabase::getPageData::$e", stackTrace: stack);
      rethrow;
    }
  }

  Future<String> getBaseUrl() async {
    try {
      final baseModel = await getPageData();

      return Platform.isAndroid
          ? baseModel.baseApiUrl ?? ''
          : baseModel.ios_base_api_url ?? '';
    } catch (e, stack) {
      _log.e("Apidatabase::getBaseUrl::$e", stackTrace: stack);
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
    await _storage.write(
      key: 'banner_url_1',
      value: baseModel.bannerUrl1 ?? '',
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
    await _storage.write(
      key: 'banner_image_1',
      value: baseModel.bannerImage1 ?? '',
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );

    if (Platform.isAndroid) {
      await _storage.write(
        key: 'base_api_url',
        value: baseModel.baseApiUrl ?? '',
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions(),
      );
    } else if (Platform.isIOS) {
      await _storage.write(
        key: 'base_api_url',
        value: baseModel.ios_base_api_url ?? '',
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions(),
      );
    }
  }

  IOSOptions _getIOSOptions() =>
      const IOSOptions(accessibility: KeychainAccessibility.first_unlock);

  AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);
}
