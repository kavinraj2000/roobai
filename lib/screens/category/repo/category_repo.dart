import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:roobai/comman/common.dart';
import 'package:roobai/comman/constants/constansts.dart';
import 'package:roobai/comman/model/product_model.dart';

class CategoryRepository {
  final api = ApiDatabase();
  final dio = Dio();
  final log = Logger();

  /// Get products for a category
  Future<List<ProductModel>> getCategoryData({
    required String id,
    String? subCategory, // instead of hardcoded `cat = null`
    required int page,
  }) async {
    try {
      final url =
          "https://roo.bi/api/website/v10.1/product/getcategory/$id/${subCategory ?? 'null'}/$page/";

      log.d('CategoryRepository:getCategoryData::Requesting URL: $url');

      final response = await dio.get(
        url,
        options: Options(headers: APIS.headers),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        log.d('Response Data: ${jsonEncode(data)}');

        // Case 1: Direct List
        if (data is List) {
          return data
              .map<ProductModel>((json) => ProductModel.fromJson(json))
              .toList();
        }

        // Case 2: Wrapped inside { data: [...] }
        if (data is Map && data['data'] is List) {
          final List dataList = data['data'];
          return dataList
              .map<ProductModel>((json) => ProductModel.fromJson(json))
              .toList();
        }

        throw Exception("Unexpected response format: ${jsonEncode(data)}");
      } else {
        throw Exception(
          'Failed to load category data. Status code: ${response.statusCode}',
        );
      }
    } on DioException catch (e, stackTrace) {
      log.e(
        'DioException in getCategoryData: ${e.message}',
        stackTrace: stackTrace,
      );
      throw Exception("Network error: ${e.message}");
    } catch (e, stackTrace) {
      log.e('Exception in getCategoryData: $e', stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getSaleDeals({
    required String cid,
    String? subCategory,
    required int page,
  }) async {
    try {
      final url =
          "https://roo.bi/api/website/v10.1/product/getcategory/$cid/${subCategory ?? 'null'}/$page/";
      log.d("CategoryRepository:getSaleDeals::Requesting URL: $url");

      final res = await api.getRequest(url: url);

      if (res is List) {
        return List<Map<String, dynamic>>.from(res);
      } else if (res is Map && res.containsKey("data")) {
        return List<Map<String, dynamic>>.from(res["data"]);
      } else {
        log.w("CategoryRepository:getSaleDeals::Unexpected response $res");
        return [];
      }
    } on DioException catch (e) {
      log.e("DioException in getSaleDeals: ${e.message}");
      throw Exception("Network error: ${e.message}");
    } catch (e) {
      log.e("Exception in getSaleDeals: $e");
      throw Exception("Unexpected error: $e");
    }
  }
}
