
import 'package:dio/dio.dart';
import 'package:ecommerce_mobile/response/shipping-data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final Dio _dio = Dio();

Future shippingAddressInfoApi(ShippingAddressInfo body) async{
   try {
  //final url = "${dotenv.env['BACKEND_URL']}/api/v1/users";
  final url = "${dotenv.env['ORDER_URL']}/api/v1/shipping-address";
  print("url $url, body: ${body.address}");
  final response = await _dio.post(
      url,
      data: {
        ...body.toJson(),
        "userId": 58
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

Future getShippingAddressInfoApi() async{
   try {
  //final url = "${dotenv.env['BACKEND_URL']}/api/v1/users";
  final url = "${dotenv.env['ORDER_URL']}/api/v1/shipping-address?userId=58";
  print("url $url");
  final response = await _dio.get(
      url,
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

Future updateDefaultShippingAddressInfoApi(String id, int userId) async{
   try {
  //final url = "${dotenv.env['BACKEND_URL']}/api/v1/users";
  final url = "${dotenv.env['ORDER_URL']}/api/v1/shipping-address/$id/default";
  print("url $url");
  final response = await _dio.patch(
      url,
      data: {
        "userId": userId
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
