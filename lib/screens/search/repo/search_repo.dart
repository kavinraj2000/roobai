
import 'package:dio/dio.dart';
import 'package:logger/web.dart';
import 'package:roobai/comman/constants/constansts.dart';
import 'package:roobai/comman/model/product_model.dart';
import 'package:roobai/comman/repo/app_api_repository.dart';
import 'package:roobai/comman/repo/storage_repository.dart';

class Searchrepository {
  final api = ApiDatabase();
  final log = Logger();
  final Dio _dio = Dio();

Future<List<ProductModel>> getJustScrollProducts({required int page}) async {
    try {
      final baseUrl = await api.getBaseUrl();
      final url = '${baseUrl + Constansts.api.jusinscroll}$page/';
      log.d('getJustScrollProducts URL: $url');

      final response = await _dio.get(
        url,
        options: Options(headers: APIS.headers),
      );

      log.d('getJustScrollProducts statusCode: ${response.statusCode}');
      log.d('getJustScrollProducts data: ${response.data}');

      return _parseListResponse<ProductModel>(
        response,
        (json) => ProductModel.fromJson(json),
      );
    } on DioException catch (e) {
      log.e("DioError getJustScrollProducts: ${e.message}");
      if (e.response?.statusCode == 404) {
        throw Exception("API endpoint not found: ${e.requestOptions.uri}");
      }
      throw Exception("Network error while fetching products: ${e.message}");
    } catch (e) {
      log.e("Error getJustScrollProducts: $e");
      throw Exception("Unexpected error while fetching products: $e");
    }
  }
    List<T> _parseListResponse<T>(
    Response response,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    if (response.statusCode == 200) {
      try {
        if (response.data is List) {
          return (response.data as List)
              .map((e) => fromJson(e as Map<String, dynamic>))
              .toList();
        } else if (response.data is Map && response.data["data"] is List) {
          return (response.data["data"] as List)
              .map((e) => fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          log.w('Unexpected response format: ${response.data}');
          throw Exception("Unexpected response format: ${response.data}");
        }
      } catch (e) {
        log.e('Parsing error: $e');
        throw Exception("Failed to parse response: $e");
      }
    } else {
      throw Exception("Failed to load data: ${response.statusCode}");
    }
  }
}

