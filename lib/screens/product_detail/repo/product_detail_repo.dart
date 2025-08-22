import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:roobai/core/api/app_api.dart';
import 'package:roobai/features/auth/data/Database.dart';
import 'package:roobai/screens/product/model/products.dart';

class ProductdetailRepository {
  final Apidatabase api = Apidatabase();
  final log = Logger();


  Future<List<Product>> getProductData() async {
    try {
      final baseUrl = await api.getBaseUrl();
      final url = "$baseUrl/deal//1/1/"; 

      final response = await http.get(Uri.parse(url), headers: APIS.headers);
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
      log.d('response::${response.body}::');

        if (decoded is List) {
          return decoded.map<Product>((json) => Product.fromMap(json)).toList();
        }

        if (decoded is Map && decoded['data'] is List) {
          final List dataList = decoded['data'];
          return dataList
              .map<Product>((json) => Product.fromMap(json))
              .toList();
        }

        throw Exception("Unexpected response format: ${response.body}");
      } else {
        throw Exception(
          'Failed to load deal data. Status code: ${response.statusCode}',
        );
      }
    } catch (e, stackTrace) {
      log.e(' Exception in getProductData: $e', stackTrace: stackTrace);
      rethrow;
    }
  }
}