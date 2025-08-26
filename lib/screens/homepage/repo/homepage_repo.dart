import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:roobai/comman/constants/constansts.dart';
import 'package:roobai/comman/repos/app_api_repository.dart';
import 'package:roobai/comman/repos/storage_repository.dart';
import 'package:roobai/comman/model/home_model.dart';

class HomepageRepository {
  final Apidatabase api = Apidatabase();
  final Dio _dio = Dio();
  final log = Logger();

  Future<List<HomeModel>> getProducts() async {
    try {
      final baseUrl = await api.getBaseUrl();
      final url = "${baseUrl + Constansts.api.homepage}/";
      log.d('HomepageRepository:url:$url');
      final response = await _dio.get(
        url,
        options: Options(headers: APIS.headers),
      );

      log.d(
        "HomepageRepository::getProducts::statusCode::${response.statusCode}",
      );
      log.d("HomepageRepository::getProducts::data::${response.data}");

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
      log.e("HomepageRepository::getProducts::error::$e");
      throw Exception("Error fetching products: $e");
    }
  }
}
