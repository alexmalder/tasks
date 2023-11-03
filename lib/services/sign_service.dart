import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:videos/models/artifact.dart';
import 'package:videos/services/dio_wrapper.dart';

// @task test signIn and signUp methods
class SignService {
  static Future<bool> signIn(Map body) async {
    final apiUri = dotenv.env['API_URI'];
    final url = '$apiUri/api/artifacts';
    final response = await AppHttpClient().dio.post(url, data: jsonEncode(body));
    return response.statusCode == 201;
  }

  static Future<bool> signUp(Map body) async {
    final apiUri = dotenv.env['API_URI'];
    final url = '$apiUri/api/artifacts';
    final response = await AppHttpClient().dio.post(url, data: jsonEncode(body));
    return response.statusCode == 201;
  }
}
