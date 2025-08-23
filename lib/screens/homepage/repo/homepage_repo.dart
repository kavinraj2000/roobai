

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:roobai/core/api/app_api.dart';
import 'package:roobai/features/auth/data/Database.dart';
import 'package:roobai/features/data/model/home_model.dart';
import 'package:roobai/features/data/model/product_model.dart';

class HomepageRepository {
    final Apidatabase api = Apidatabase();

  Future<List<HomeModel>> getProducts() async {
     final baseUrl = await api.getBaseUrl();
      final url = "$baseUrl/homepage/"; 
    try {
      // final baseUrl = 'https://roo.bi/api/flutter/v11.0/deal//1/1/';

      final response = await http.get(
        Uri.parse(url),
        headers: APIS.headers,
      );
      Logger().d('HomepageRepository::getProducts::response:::$response');
      if (response.statusCode == 200) {
        final List responseJson = json.decode(response.body);
        Logger().d('HgetProducts::response.body:${response.body}');
        Logger().d('HgetProducts::responseJson::$responseJson');
        return responseJson.map((json) => HomeModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
}
