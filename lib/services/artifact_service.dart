import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:videos/models/artifact.dart';
import 'package:videos/services/dio_wrapper.dart';

class ArtifactService {
  static Future<bool> add(Map body) async {
    const url = '/api/v1/feed';
    final response = await AppHttpClient().dio.post(url, data: jsonEncode(body));
    return response.statusCode == 201;
  }

  static Future<List<Artifact>> fetch() async {
    const url = '/api/v1/feed';
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');

    final response = await AppHttpClient().dio.get(url, options: Options(
      headers: {"Authorization": "Bearer ${accessToken!}"},
    ));
    if (response.statusCode == 200) {
      //final Map<String, dynamic> responseDecoded = response.data;
      //final List<Artifact> data = responseDecoded['data'];
      List<Artifact> listArtifact;
      return (response.data['data'] as List)
          .map((x) => Artifact.fromJson(x))
          .toList();
      //final result = response.data['data'].map((data) => Artifact.fromJson(data)).toList();
      //return result;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<Artifact> fetchOne(Uuid uuid) async {
    final url = '/v1/feed/$uuid';
    final response = await AppHttpClient().dio.get(url);
    if (response.statusCode == 200) {
      return Artifact.fromJson(response.data);
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<bool> update(Uuid uuid, Map body) async {
    final url = '/api/v1/feed/$uuid';
    final response = await AppHttpClient().dio.put(
      url,
      data: jsonEncode(body),
    );
    return response.statusCode == 200;
  }

  static Future<bool> deleteById(Uuid uuid) async {
    final url = '/api/v1/feed/$uuid';
    final response = await AppHttpClient().dio.delete(url);
    return response.statusCode == 200;
  }
}
