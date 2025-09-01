import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:roobai/comman/repo/app_api_repository.dart';
import 'package:roobai/comman/repo/storage_repository.dart';
import 'package:roobai/screens/product/model/products.dart';

class DealRepository {
  final ApiDatabase api = ApiDatabase();
  final Logger log = Logger();
  final Dio dio = Dio();

  Future<List<Product>> getDealData() async {
    try {
      final baseUrl = await api.getBaseUrl();
      final url = "$baseUrl/deal/1/1/";

      log.d('DealRepository:getDealData URL: $url');

      final response = await dio.get(url, options: Options(headers: APIS.headers));

      final data = response.data;

      if (data == null) return [];

      if (data is List) {
        return data.map<Product>((json) => Product.fromMap(json)).toList();
      }

      if (data is Map && data['data'] is List) {
        return (data['data'] as List).map<Product>((json) => Product.fromMap(json)).toList();
      }

      log.w("Unexpected response format: ${jsonEncode(data)}");
      return [];
    } catch (e, stackTrace) {
      log.e("DealRepository::getDealData::$e", stackTrace: stackTrace);
      return [];
    }
  }

  Future<void> addLikeStatus({required String productId, required String likeStatus}) async {
    try {
      final baseUrl = await api.getBaseUrl();
      final url = "$baseUrl/deal/1/1/";
      final data = {'pid': productId, 'likeStatus': likeStatus};

      log.d('POST $url');
      log.d('Data: $data');

      final response = await dio.post(url, data: jsonEncode(data), options: Options(headers: APIS.headers));

      if (response.statusCode != 200 && response.statusCode != 201) {
        log.e('Failed to update like status: ${response.data}');
      }
    } catch (e, stackTrace) {
      log.e('DealRepository::addLikeStatus::$e', stackTrace: stackTrace);
    }
  }
}
