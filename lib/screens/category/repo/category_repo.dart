import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:roobai/comman/common.dart';
import 'package:roobai/comman/constants/constansts.dart';
import 'package:roobai/comman/model/product_model.dart';

class CategoryRepository {
  final api = ApiDatabase();
  final log = Logger();

  static const String _baseUrl = "https://roo.bi/api/website/v10.1";

  Future<List<ProductModel>> getCategoryData({
    required String id,
    String? subCategory,
    required int page,
  }) async {
    final url = "$_baseUrl/product/getcategory/$id/${subCategory ?? 'null'}/$page/";
    log.i("➡️ CategoryRepository:getCategoryData::Requesting URL: $url");

    try {
      final response = await api.getRequest(url: url, queryParams: APIS.headers);

      if (response is List) {
        return response.map<ProductModel>((json) => ProductModel.fromJson(json)).toList();
      }

      if (response is Map && response['data'] is List) {
        final List dataList = response['data'];
        return dataList.map<ProductModel>((json) => ProductModel.fromJson(json)).toList();
      }

      throw Exception("Unexpected response format: ${jsonEncode(response)}");
    } on DioException catch (e, stackTrace) {
      log.e(" DioException in getCategoryData: ${e.message}, "
          "status: ${e.response?.statusCode}, data: ${e.response?.data}",
          stackTrace: stackTrace);
      throw Exception("Network error: ${e.response?.statusCode} - ${e.message}");
    } catch (e, stackTrace) {
      log.e(" Exception in getCategoryData: $e", stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<List<ProductModel>> getSaleDeals({
    required String cid,
    String? subCategory,
    required int page,
  }) async {
    final url = "$_baseUrl/saledeal/$cid/${subCategory ?? 'null'}/$page/";
    log.i("CategoryRepository:getSaleDeals::Requesting URL: $url");

    try {
      final res = await api.getRequest(url: url, queryParams: APIS.headers);

      if (res is List) {
        return res.map<ProductModel>((json) => ProductModel.fromJson(json)).toList();
      } else if (res is Map && res.containsKey("data")) {
        return (res["data"] as List)
            .map<ProductModel>((json) => ProductModel.fromJson(json))
            .toList();
      } else {
        log.w(" CategoryRepository:getSaleDeals::Unexpected response $res");
        return [];
      }
    } on DioException catch (e, stackTrace) {
      log.e(" DioException in getSaleDeals: ${e.message}, "
          "status: ${e.response?.statusCode}, data: ${e.response?.data}",
          stackTrace: stackTrace);
      throw Exception("Network error: ${e.response?.statusCode} - ${e.message}");
    } catch (e, stackTrace) {
      log.e(" Exception in getSaleDeals: $e", stackTrace: stackTrace);
      throw Exception("Unexpected error: $e");
    }
  }
}
