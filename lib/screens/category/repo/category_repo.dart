import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:roobai/comman/common.dart';
import 'package:roobai/comman/constants/constansts.dart';
import 'package:roobai/comman/model/category_model.dart';
import 'package:roobai/comman/model/product_model.dart';

class CategoryRepository {
  final api = ApiDatabase();
  final dio = Dio();
  final log = Logger();
  final baseurl='https://roo.bi/api/website/v10.1/saledeal/';
  final cat=null;

Future<List<ProductModel>> getCategoryData({
  required String id,
  required int page,
}) async {
  try {
    final url = "$baseurl/product/getcategory/$id/$cat/$page";

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

      // Fallback
      throw Exception("Unexpected response format: ${jsonEncode(data)}");
    } else {
      throw Exception(
        'Failed to load category data. Status code: ${response.statusCode}',
      );
    }
  } catch (e, stackTrace) {
    log.e('Exception in getCategoryData: $e', stackTrace: stackTrace);
    rethrow;
  }
}

}
