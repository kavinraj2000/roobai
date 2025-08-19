// import 'package:http/http.dart' as http;
// import 'package:roobai_app/core/api/app_api.dart';
// import 'package:roobai_app/features/product/data/model/product_model.dart';

// class HomepageRepository {
//   final baseurl=APIS.main_url;
//   Future<List<ProductModel>> getProducts(int page) async {
//     try {
//       final baseUrl = await getBaseUrl();
//       if (baseUrl == null || baseUrl.isEmpty) {
//         throw Exception('Base URL not found');
//       }

//       final response = await http.get(
//         Uri.parse("$baseUrl$just_in$page/"),
//         headers: APIS.headers,
//       );

//       if (response.statusCode == 200) {
//         final List responseJson = json.decode(response.body);
//         return responseJson.map((json) => ProductModel.fromJson(json)).toList();
//       } else {
//         throw Exception('Failed to load products: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Error fetching products: $e');
//     }
//   }
// }
