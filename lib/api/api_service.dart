import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final _client = http.Client();

  //post method
  Future<Map<String, dynamic>> post(
    String url,
    Map<String, dynamic> body,
  ) async {
    try {
      Uri uri = Uri.parse(url);
      final response = await _client.post(
        uri,
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ',
        },
      );
      debugPrint('Data is: ${jsonDecode(response.body)}');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body);
      } else {
        throw HttpException(
          'Failed: ${response.statusCode} - ${response.body}',
          uri: uri,
        );
      }
    } catch (e) {
      debugPrint('Post Error: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> get(
    String url, {
    Map<String, String>? headers,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      final combinedHeaders = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ',
        if (headers != null) ...headers,
      };
      final response = await _client.get(uri, headers: combinedHeaders);
      debugPrint('Data is: ${response.body}');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw HttpException(
          'Failed: ${response.statusCode} - ${response.body}',
          uri: uri,
        );
      }
    } catch (e) {
      debugPrint('Get Error: $e');
      rethrow;
    }
  }
}
