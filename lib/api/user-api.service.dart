import 'package:dio/dio.dart';
import 'package:ecommerce_mobile/api/api-service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';

final Dio _dio = Dio();

// Future register(body) async {
//     Map<String, dynamic> responseData = await ApiService().post(
//       dotenv.env['BACKEND_URL'] as String,
//       body,
//     );
//     return {
//         "success": responseData['success'],
//         "message": responseData['message'], 
//     };
//   }

Future register(body) async{
   try {
  final url = "${dotenv.env['BACKEND_URL']}/api/v1/users";
 //final url = "${dotenv.env['USER_URL']}/api/v1/users";
  print("url $url, body: $body");
  final response = await _dio.post(
      url,
      data: body,
      options: Options(
        headers: {
         // if (token != null) 'Authorization': 'Bearer $token',
          "Content-Type": "multipart/form-data"
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

Future userRegisterWithGoogleApi() async {
   try {
    final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
    await _googleSignIn.initialize();
    final user = await _googleSignIn.authenticate();
    final code = user.authentication.idToken;
    print("code $user");
    if (code == null) return {"success": false, "message": "User cancelled the login."};
    final responseData = await ApiService().get('${dotenv.env['BACKEND_URL']}/api/v1/users/register/google/mobile?code=$code');
    return {
        "success": responseData['success'],
        "message": responseData['message'], 
    };
    }
   catch (e) {
    print('Google Sign-In failed: $e');
    return {
        "success": false,
        "message": "Something went wrong."
      };
  }
}


Future loginUser(body) async{
   try {
  final url = "${dotenv.env['BACKEND_URL']}/api/auth/login";
  //final url = "${dotenv.env['AUTH_URL']}/api/auth/login";
  print("url $url");
  Map<String, dynamic> responseData = await ApiService().post(url, body);
  return {
     "success": responseData["success"],
     "data": responseData["data"],
     "message": responseData["message"]
  };
} on Exception catch (e) {
  return {
     "success": false,
     "message": "Something went wrong."
  };
}
}

Future<Map<String, dynamic>?> getUserData(int id, {String? token}) async {
  try {
    final url = "${dotenv.env['BACKEND_URL']}/api/v1/users/$id";
  // final url = "${dotenv.env['USER_URL']}/api/v1/users/$id";
    print("url $url");

    final response = await _dio.get(
      url,
      options: Options(
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
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

Future<Map<String, dynamic>?> updateUserData(int id, body, {String? token}) async {
  try {
   final url = "${dotenv.env['BACKEND_URL']}/api/v1/users/$id";
  // final url = "${dotenv.env['USER_URL']}/api/v1/users/$id";
    print("url $url");

    final response = await _dio.patch(
      url,
      data: body,
      options: Options(
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          "Content-Type": "multipart/form-data"
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

Future<Map<String, dynamic>?> changePassword(String id, String password, {String? token}) async {
  try {
   final url = "${dotenv.env['BACKEND_URL']}/api/v1/users/password/change";
   //final url = "${dotenv.env['USER_URL']}/api/v1/users/password/change";
    print("url $url, body, $password");

    final response = await _dio.patch(
      url,
      data: {
        "id": id,
        "password": password
      },
      options: Options(
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
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