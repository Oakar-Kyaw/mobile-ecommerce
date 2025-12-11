import 'package:ecommerce_mobile/api/api-service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';


Future register(body) async {
    Map<String, dynamic> responseData = await ApiService().post(
      dotenv.env['BACKEND_URL'] as String,
      body,
    );
    return {
        "success": responseData['success'],
        "message": responseData['message'], 
    };
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
  final url = "${dotenv.env['AUTH_URL']}/api/auth/login";
  print("url $url");
  Map<String, dynamic> responseData = await ApiService().post(url, body);
  return {
     "success": responseData["success"],
     "message": responseData["message"]
  };
} on Exception catch (e) {
  return {
     "success": false,
     "message": "Something went wrong."
  };
}
}