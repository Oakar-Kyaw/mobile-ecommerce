
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = new FlutterSecureStorage();

Future<void> saveLoginData(Map<String, dynamic> data) async {
  // Convert map to JSON string
  String jsonString = jsonEncode(data);
  await storage.write(key: "user", value: jsonString);
}

Future getLoginData() async {
  String? jsonString = await storage.read(key: "user");
  if (jsonString != null) {
    return jsonDecode(jsonString);
  }
  return null;
}

Future readUserFullData() async {
  String? jsonString = await storage.read(key: "userFullData");
  if (jsonString != null) {
    return jsonDecode(jsonString);
  }
  return null;
}

Future <void> deleteLoginData() async {
  await storage.delete(key: "userFullData");
  await storage.delete(key: "user");
}