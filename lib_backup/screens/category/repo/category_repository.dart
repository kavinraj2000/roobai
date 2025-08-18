import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:roobai/core/api/app_api.dart';
import 'package:roobai/features/product/data/model/category_model.dart';


class CategoryRepository {
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await http.get(
        Uri.parse(APIS.main_url),
        headers: APIS.headers,
      );

      Logger().d('CategoryRepository::getCategories response: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((item) => CategoryModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } catch (e) {
      Logger().e('CategoryRepository::getCategories error: $e');
      throw Exception('Network error: $e');
    }
  }
}
