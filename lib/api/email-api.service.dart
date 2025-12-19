import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final Dio _dio = Dio();

Future<Map<String, dynamic>?> sendOtp(String email, String mode) async {
  try {
   // final url = "${dotenv.env['USER_URL']}/api/v1/users/otp/send";
    final url = "${dotenv.env['BACKEND_URL']}/api/v1/users/otp/send";
    print("email apis: $url, $email");
    final response = await _dio.post(
      url, 
      data: {
        "email": email,
        "mode": mode
      },
      options: Options(
        headers: {
         // if (token != null) 'Authorization': 'Bearer $token',
          "Content-Type": "application/json"
        },
      ),
    );
    final data = response.data as Map<String, dynamic>;
    print("data of email is: $data");
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

Future<Map<String, dynamic>?> verifyOtp(String email, String mode, String otp) async {
  try {
    //final url = "${dotenv.env['USER_URL']}/api/v1/users/otp/verify";
    final url = "${dotenv.env['BACKEND_URL']}/api/v1/users/otp/verify";
    print("email apis: $url, $email, $otp");
    final response = await _dio.post(
      url, 
      data: {
        "email": email,
        "mode": mode,
        "otp": otp
      },
      options: Options(
        headers: {
         // if (token != null) 'Authorization': 'Bearer $token',
          "Content-Type": "application/json"
        },
      ),
    );
    final data = response.data as Map<String, dynamic>;
    print("data of email is: $data");
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

