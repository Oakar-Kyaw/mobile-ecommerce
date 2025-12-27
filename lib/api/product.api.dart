
import 'package:dio/dio.dart';
import 'package:ecommerce_mobile/response/product.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ProductApi {

  final Dio _dio = Dio();
  //final url = "${dotenv.env['BACKEND_URL']}/api/v1/products?isDeleted=false";
  
  String productUrl = "${dotenv.env['PRODUCT_URL']}/api/v1";

  Future<List<Product>> getAllProductByTrendingItemApiData() async {
  final url = "$productUrl/products?isDeleted=false";
  
  final response = await _dio.get(url);

  final Map<String, dynamic> data = Map<String, dynamic>.from(response.data as Map);

  if (data["success"] == true) {
    final List<dynamic> items = data["data"] as List<dynamic>;

    // Explicitly type the mapping
    final List<Product> products = items
        .map<Product>((e) => Product.fromJson(Map<String, dynamic>.from(e)))
        .toList();
    return products; 
  }

  throw Exception(data["message"] ?? "Failed to fetch products");
}

  Future<Product> getProductByIdApiData(String id) async {
  final url = "$productUrl/products/$id?isDeleted=false";
  
  final response = await _dio.get(url);

  final Map<String, dynamic> data = Map<String, dynamic>.from(response.data as Map);

  if (data["success"] == true) {
    final  items = data["data"] ;
     // print("product by id: $items");
    // Explicitly type the mapping
    final Product product = Product.fromJson(items);
    return product; 
  }

  throw Exception(data["message"] ?? "Failed to fetch products");
}

}