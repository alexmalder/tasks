import 'dart:convert';
import 'dart:ffi';
import 'package:dio/dio.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:videos/services/dio_wrapper.dart';
//import 'package:videos/models/task.dart';

// all todo api calls
class ArtifactService {
  static Future<bool> deleteById(int id) async {
    final apiUri = dotenv.env['API_URI'];
    final url = '$apiUri/api/artifacts/$id';
    final response = await AppHttpClient().dio.delete(url);
    return response.statusCode == 200;
  }

  static Future<List?> fetchArtifacts() async {
    final apiUri = dotenv.env['API_URI'];
    final url = '$apiUri/api/artifacts';
    final response = await AppHttpClient().dio.get(url);
    final Map<String, dynamic> responseDecoded = response.data;
    if (response.statusCode == 200) {
      //final data = responseDecoded['data'] as List;
      //return data;
      final List<dynamic> data = responseDecoded['data'];
      print(data);
      return data;

    } else {
      return null;
    }
  }

  static Future<bool> updateArtifact(String id, Map body) async {
    final apiUri = dotenv.env['API_URI'];
    final url = '$apiUri/api/artifacts/$id';
    final response = await AppHttpClient().dio.put(
      url,
      data: jsonEncode(body),
    );
    return response.statusCode == 200;
  }

  static Future<bool> addArtifact(Map body) async {
    final apiUri = dotenv.env['API_URI'];
    final url = '$apiUri/api/artifacts';
    final response = await AppHttpClient().dio.post(url, data: jsonEncode(body));
    return response.statusCode == 201;
  }
}
