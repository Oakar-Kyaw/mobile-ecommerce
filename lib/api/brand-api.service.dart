import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final Dio _dio = Dio();

Future<Map<String, dynamic>?> getAllBrandApiData() async {
  try {
    //final url = "${dotenv.env['USER_URL']}/api/v1/brands?isDeleted=false";
    final url = "${dotenv.env['BACKEND_URL']}/api/v1/brands?isDeleted=false";
    final response = await _dio.get(url);
    final data = response.data as Map<String, dynamic>;
    //print("brand $data");
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

