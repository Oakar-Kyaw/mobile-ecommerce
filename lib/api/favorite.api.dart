
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final Dio _dio = Dio();

Future addProductToFavorite(Map<String, dynamic> body) async{
   try {
  //final url = "${dotenv.env['BACKEND_URL']}/api/v1/users";
  final url = "${dotenv.env['PRODUCT_URL']}/api/v1/product/${body["id"]}/favorite";
  print("url $url, body: $body");
  final response = await _dio.post(
      url,
      data: {
        "userId": body["userId"],
        "productId": body["id"]
      },
      options: Options(
        headers: {
         // if (token != null) 'Authorization': 'Bearer $token',
          "Content-Type": "application/json"
        },
      ),
    );

    // response.data contains the actual JSON from backend
    final data = response.data as Map<String, dynamic>;

    return {
      "success": data["success"],
      "data": data["data"],
      "message": data["message"],
    };
  } catch (e) {
    print("Unexpected error: $e");
    return null;
  }
}
