import 'package:dio/dio.dart';
import 'package:ecommerce_mobile/response/category.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final Dio _dio = Dio();

Future<List<Category>> getAllCategoriesApiData() async {
  final url = "${dotenv.env['BACKEND_URL']}/api/v1/categories?isDeleted=false";
  
  //final url = "${dotenv.env['PRODUCT_URL']}/api/v1/categories?isDeleted=false";
  final response = await _dio.get(url);

  final Map<String, dynamic> data = Map<String, dynamic>.from(response.data as Map);

  if (data["success"] == true) {
    final List<dynamic> items = data["data"] as List<dynamic>;

    // Explicitly type the mapping
    final List<Category> categories = items
        .map<Category>((e) => Category.fromJson(Map<String, dynamic>.from(e)))
        .toList();

    return categories; // ✅ This is now explicitly List<Category>
  }

  throw Exception(data["message"] ?? "Failed to fetch categories");
}
