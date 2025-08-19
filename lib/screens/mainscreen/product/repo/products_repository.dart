import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:roobai/core/api/app_api.dart';
import 'package:roobai/core/api/deal_api.dart';
import 'package:roobai/core/theme/constants.dart';
import 'package:roobai/screens/mainscreen/product/model/products.dart';

class DealRepository {
  final _logger = Logger();

  Future<List<Product>> getDealData() async {
    const String base_api_url = "base_api_url"; 
    const int pagenumber = 1; 
    try {
      final response = await http.get(
        Uri.parse('${APIS.baseurl}/$base_api_url$just_in$pagenumber'),
        headers: APIS.headers,
      );

      _logger.i('GET ${DealApi.dealurl} → Status: ${response.statusCode}');
      _logger.i('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Product.fromMap(json)).toList();
      } else {
        throw Exception(
          'Failed to load deal data. Status code: ${response.statusCode}',
        );
      }
    } catch (e, stackTrace) {
      _logger.e('Exception in getDealData: $e', stackTrace: stackTrace);
      rethrow;
    }
  }
}
