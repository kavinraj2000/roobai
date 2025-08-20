import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:roobai/core/api/app_api.dart';
import 'package:roobai/core/theme/constants.dart';
import 'package:roobai/screens/product/model/products.dart';

class DealRepository {
  final _logger = Logger();

  Future<List<Product>> getDealData({int pageNumber = 1}) async {
    final String url = "https://roo.bi/api/flutter/v11.0/deal//1/1/";
// final String url = "${APIS.baseurl+APIS.base_api_url}$just_in$pageNumber";
    try {
      final response = await http
          .get(
            Uri.parse(url),
            headers: APIS.headers,
          )
          .timeout(const Duration(seconds: 15));

      _logger.i('GET $url');
      _logger.i('Status: ${response.statusCode}');
      _logger.i('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        if (decoded is List) {
          return decoded.map<Product>((json) => Product.fromMap(json)).toList();
        }

        if (decoded is Map && decoded['data'] is List) {
          final List dataList = decoded['data'];
          return dataList.map<Product>((json) => Product.fromMap(json)).toList();
        }

        throw Exception("Unexpected response format: ${response.body}");
      } else {
        throw Exception(
            'Failed to load deal data. Status code: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      _logger.e(' Exception in getDealData: $e', stackTrace: stackTrace);
      rethrow;
    }
  }
}
