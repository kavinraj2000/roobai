import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:roobai/comman/constants/constansts.dart';
import 'package:roobai/comman/model/category_model.dart';
import 'package:roobai/comman/repo/app_api_repository.dart';
import 'package:roobai/comman/repo/storage_repository.dart';

class DrawerRepository {
  final ApiDatabase api = ApiDatabase();
  final Dio _dio = Dio();
  final Logger log = Logger();

  Future<List<CategoryModel>> getcategory() async {
    try {
      final baseUrl = await api.getBannerUrl();
      final url = baseUrl + Constansts.api.salecategorylist;
      log.d('getcategory URL: $url');

      final response = await _dio.get(
        url,
        options: Options(headers: APIS.headers),
      );

      log.d('getcategory statusCode: ${response.statusCode}');
      log.d('getcategory data: ${response.data}');

      return _parseListResponse<CategoryModel>(
        response,
        (json) => CategoryModel.fromJson(json),
      );
    } on DioException catch (e) {
      log.e("DioError getcategory: ${e.message}");
      throw Exception("Network error while fetching banners: ${e.message}");
    } catch (e) {
      log.e("Error getcategory: $e");
      throw Exception("Unexpected error while fetching banners: $e");
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
