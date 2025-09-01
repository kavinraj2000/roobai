import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/web.dart';
import 'package:roobai/comman/constants/api_contstansts.dart';
import 'package:roobai/comman/constants/constansts.dart';
import 'package:roobai/comman/model/home_model.dart';
import 'package:roobai/comman/repo/app_api_repository.dart';
import 'package:roobai/comman/repo/storage_repository.dart';
import 'package:roobai/screens/product/model/products.dart';

class Searchrepository {
  final api = ApiDatabase();
  final log = Logger();
  final Dio dio = Dio();

  Future<List<Product>> getProductdata() async {
    try {
      final baseUrl = await api.getBaseUrl();
      final url = "$baseUrl/deal/1/1/";
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

  Future<List<HomeModel>> gethomepagedata() async {
    try {
      final baseUrl = await api.getBaseUrl();
      final url = "${baseUrl + Constansts.api.salecategorylist}/";
      log.d('HomepageRepository:gethomepagedata:url:$url');
      final response = await dio.get(
        url,
        options: Options(headers: APIS.headers),
      );

      log.d(
        "HomepageRepository::gethomepagedata::statusCode::${response.statusCode}",
      );
      log.d("HomepageRepository::gethomepagedata::data::${response.data}");

      if (response.statusCode == 200) {
        if (response.data is List) {
          return (response.data as List)
              .map((json) => HomeModel.fromJson(json as Map<String, dynamic>))
              .toList();
        } else if (response.data is Map && response.data["data"] is List) {
          return (response.data["data"] as List)
              .map((json) => HomeModel.fromJson(json as Map<String, dynamic>))
              .toList();
        } else {
          throw Exception("Unexpected response format: ${response.data}");
        }
      } else {
        throw Exception("Failed to load products: ${response.statusCode}");
      }
    } catch (e) {
      log.e("HomepageRepository::gethomepagedata::error::$e");
      throw Exception("Error fetching products: $e");
    }
  }
}
