import 'package:dio/dio.dart';
import 'package:ecommerce_mobile/response/order.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final Dio _dio = Dio();

Future createOrderApi(Order body) async{
   try {
  //final url = "${dotenv.env['BACKEND_URL']}/api/v1/users";
  final url = "${dotenv.env['ORDER_URL']}/api/v1/orders";
  print("url $url , ${body.toJson()}");
  final response = await _dio.post(
      url,
      data: body,
      options: Options(
        headers: {
         // if (token != null) 'Authorization': 'Bearer $token',
          "Content-Type": "application/json"
        },
      ),
    );

    // response.data contains the actual JSON from backend
    final data = response.data as Map<String, dynamic>;
    print("data is: $data");

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
