import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:roobai/features/product/data/model/deal_model.dart';

class DealRepository {
  final _logger = Logger();

  Future<DealModel> getDealData({required String dealType}) async {
    try {
      if (dealType.isEmpty) {
        throw Exception('Deal type is empty');
      }

      final String url = 'https://roo.bi/api/flutter/v12.0/deal_finder/$dealType/';

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return DealModel.fromJson(json);
      } else {
        _logger.e('Failed to fetch data. Status code: ${response.statusCode}');
        throw Exception('Failed to load deal data. Status code: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      _logger.e('Exception in getDealData: $e', stackTrace:  stackTrace);
      rethrow;
    }
  }
}
