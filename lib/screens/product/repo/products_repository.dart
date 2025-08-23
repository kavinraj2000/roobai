import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:roobai/core/api/app_api.dart';
import 'package:roobai/features/auth/data/Database.dart';
import 'package:roobai/screens/product/model/products.dart';

class DealRepository {
  final Apidatabase api = Apidatabase();
  final log = Logger();
  final Dio dio = Dio(); // ✅ Create Dio instance

  Future<List<Product>> getDealData() async {
    try {
      final baseUrl = await api.getBaseUrl();
      final url = "$baseUrl/deal//1/1/";

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
          return dataList.map<Product>((json) => Product.fromMap(json)).toList();
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
}
