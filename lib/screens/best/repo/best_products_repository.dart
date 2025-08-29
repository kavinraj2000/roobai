import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:roobai/comman/repo/app_api_repository.dart';
import 'package:roobai/comman/repo/storage_repository.dart';
import 'package:roobai/screens/product/model/products.dart';

class BestproductRepository {
  final Apidatabase api = Apidatabase();
  final log = Logger();
  final Dio dio = Dio();

  Future<List<Product>> getDealData() async {
    try {
      final baseUrl = await api.getBaseUrl();
      final url = "$baseUrl/deal/2/1/";
      final response = await dio.get(
        url,
        options: Options(headers: APIS.headers),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        log.d('response::${jsonEncode(data)}');
        log.d('baseUrl::${baseUrl.characters}/deal');

        if (data is List) {
          return data.map<Product>((json) => Product.fromMap(json)).toList();
        }

        if (data is Map && data['data'] is List) {
          final List dataList = data['data'];
          return dataList
              .map<Product>((json) => Product.fromMap(json))
              .toList();
        }

        throw Exception("Unexpected response format: ${jsonEncode(data)}");
      } else {
        throw Exception(
          'Failed to load deal data. Status code: ${response.statusCode}',
        );
      }
    } catch (e, stackTrace) {
      log.e('Exception in getDealData: $e', stackTrace: stackTrace);
      rethrow;
    }
  }

//   Future<void> addlikestatus({
//   required String productId,
//   required String likeStatus,
// }) async {
//   try {
//     final baseUrl = await api.getBaseUrl();
//     final url = "$baseUrl/deal/1/1/"; 
//     final headers = APIS.headers;

//     final data = {
//       'pid': productId,
//       'likeStatus': likeStatus,
//     };

//     Logger().d('POST $url');
//     Logger().d('Headers: $headers');
//     Logger().d('Data: $data');

//     final response = await dio.post(
//       url,
//       data: jsonEncode(data),
//       options: Options(headers: headers),
//     );

//     if (response.statusCode == 200 || response.statusCode == 201) {
//       Logger().i('Like status updated successfully');
//     } else {
//       Logger().e(
//           'Failed with status code: ${response.statusCode}, body: ${response.data}');
//       throw Exception('Failed to update like status');
//     }
//   } on DioException catch (e, stackTrace) {
//     Logger().e('BestproductRepository:addlikestatus::Error::$e',
//         stackTrace: stackTrace);
//     rethrow;
//   }
// }

}
