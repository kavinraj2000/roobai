import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:roobai/comman/constants/constansts.dart';
import 'package:roobai/comman/model/bannar_model.dart';
import 'package:roobai/comman/model/category_model.dart';
import 'package:roobai/comman/model/product_model.dart';
import 'package:roobai/comman/repo/app_api_repository.dart';
import 'package:roobai/comman/repo/storage_repository.dart';

class HomepageRepository {
  final ApiDatabase api = ApiDatabase();
  final Dio _dio = Dio();
  final Logger log = Logger();

  Future<List<BannerModel>> getBanners() async {
    try {
      final baseUrl = await api.getBannerUrl();
      final url = baseUrl + Constansts.api.bannerlist;
      log.d('getBanners URL: $url');

      final response = await _dio.get(
        url,
        options: Options(headers: APIS.headers),
      );

      log.d('getBanners statusCode: ${response.statusCode}');
      log.d('getBanners data: ${response.data}');

      return _parseListResponse<BannerModel>(
        response,
        (json) => BannerModel.fromJson(json),
      );
    } on DioException catch (e) {
      log.e("DioError getBanners: ${e.message}");
      throw Exception("Network error while fetching banners: ${e.message}");
    } catch (e) {
      log.e("Error getBanners: $e");
      throw Exception("Unexpected error while fetching banners: $e");
    }
  }

  Future<List<ProductModel>> getJustScrollProducts() async {
    try {
      final baseUrl = await api.getBaseUrl();
      final url = baseUrl + Constansts.api.jusinscroll;
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

  Future<List<CategoryModel>> getcategories() async {
    try {
      final baseUrl = await api.getBaseUrl();
      final url = baseUrl + Constansts.api.salecategorylist;
      log.d('getcategories URL: $url');

      final response = await _dio.get(
        url,
        options: Options(headers: APIS.headers),
      );

      log.d('getcategories statusCode: ${response.statusCode}');
      log.d('getcategories data: ${response.data}');

      return _parseListResponse<CategoryModel>(
        response,
        (json) => CategoryModel.fromJson(json),
      );
    } on DioException catch (e) {
      log.e("DioError getcategories: ${e.message}");
      if (e.response?.statusCode == 404) {
        throw Exception("API endpoint not found: ${e.requestOptions.uri}");
      }
      throw Exception("Network error while fetching products: ${e.message}");
    } catch (e) {
      log.e("Error getcategories: $e");
      throw Exception("Unexpected error while fetching products: $e");
    }
  }

  Future<List<ProductModel>> gethorsdeal() async {
    try {
      final baseUrl = await api.getBaseUrl();
      final url = baseUrl + Constansts.api.hourdeals;
      log.d('gethorsdeal URL: $url');

      final response = await _dio.get(
        url,
        options: Options(headers: APIS.headers),
      );

      log.d('gethorsdeal statusCode: ${response.statusCode}');
      log.d('gethorsdeal data: ${response.data}');

      return _parseListResponse<ProductModel>(
        response,
        (json) => ProductModel.fromJson(json),
      );
    } on DioException catch (e) {
      log.e("DioError gethorsdeal: ${e.message}");
      if (e.response?.statusCode == 404) {
        throw Exception("API endpoint not found: ${e.requestOptions.uri}");
      }
      throw Exception("Network error while fetching products: ${e.message}");
    } catch (e) {
      log.e("Error gethorsdeal: $e");
      throw Exception("Unexpected error while fetching products: $e");
    }
  }

  Future<List<ProductModel>> getMobilecategory() async {
    try {
      final baseUrl = await api.getBaseUrl();
      final url = baseUrl + Constansts.api.mobilecategory;
      log.d('getMobilecategory URL: $url');

      final response = await _dio.get(
        url,
        options: Options(headers: APIS.headers),
      );

      log.d('getMobilecategory statusCode: ${response.statusCode}');
      log.d('getMobilecategory data: ${response.data}');

      return _parseListResponse<ProductModel>(
        response,
        (json) => ProductModel.fromJson(json),
      );
    } on DioException catch (e) {
      log.e("DioError getMobilecategory: ${e.message}");
      if (e.response?.statusCode == 404) {
        throw Exception("API endpoint not found: ${e.requestOptions.uri}");
      }
      throw Exception("Network error while fetching products: ${e.message}");
    } catch (e) {
      log.e("Error getMobilecategory: $e");
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
