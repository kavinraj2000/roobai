import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:roobai/comman/common.dart';
import 'package:roobai/comman/constants/constansts.dart';
import 'package:roobai/comman/model/category_model.dart';

class CategoryRepository {
  final api = Apidatabase();
  final dio = Dio();
  final log = Logger();

  Future<List<CategoryModel>> getCategoryData() async {
    try {
      final baseUrl = await api.getBaseUrl(); 
      final url = '$baseUrl/${Constansts.api.categoryList}';

      log.d('CategoryRepository:getCategoryData::Requesting URL: $url');

      final response = await dio.get(
        url,
        options: Options(headers: APIS.headers),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        log.d('Response Data: ${jsonEncode(data)}');

        if (data is List) {
          return data
              .map<CategoryModel>((json) => CategoryModel.fromJson(json))
              .toList();
        }

        if (data is Map && data['data'] is List) {
          final List dataList = data['data'];
          return dataList
              .map<CategoryModel>((json) => CategoryModel.fromJson(json))
              .toList();
        }

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
