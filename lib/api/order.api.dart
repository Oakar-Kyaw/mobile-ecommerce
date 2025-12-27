import 'package:dio/dio.dart';
import 'package:ecommerce_mobile/response/order.dart';
import 'package:ecommerce_mobile/response/orderDetail.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

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

Future<List<OrderDetail>> getAllOrderByUserIdApi() async {
  final url = "${dotenv.env['BACKEND_URL']}/api/v1/orders/details?userId=58";

  final response = await _dio.get(
    url,
    options: Options(
      headers: {"Content-Type": "application/json"},
    ),
  );
  print("order de $url");
  
  final Map<String, dynamic> data = Map<String, dynamic>.from(response.data as Map);
  
  if (data["success"] == true) {
     final List items = data["data"] as List; 
    return items.map((e) {
      Map<String, dynamic> map = Map<String, dynamic>.from(e as Map);

     debugPrint("Print is: ${map}, type of");
     print(response.data.runtimeType);
    print(data["data"].runtimeType);
    print(e.runtimeType);
      return OrderDetail.fromJson(map);
  }
  ).toList();
  }

  throw Exception(data["message"] ?? "Failed to fetch order");
}


Future<OrderDetail?> getOrderByIdApi(String id) async {
  final url = "${dotenv.env['ORDER_URL']}/api/v1/orders/detail/$id";

  final response = await _dio.get(
    url,
    options: Options(
      headers: {"Content-Type": "application/json"},
    ),
  );

  final data = response.data as Map<String, dynamic>;
  if (data["success"] == true) {
    return OrderDetail.fromJson(data["data"]);
  }

  throw Exception(data["message"] ?? "Failed to fetch order");
}

