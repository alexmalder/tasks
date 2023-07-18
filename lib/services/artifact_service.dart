import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

// all todo api calls
class ArtifactService {
  static Future<bool> deleteById(String id) async {
    // Delete the item
    final apiUri = dotenv.env['API_URI'];
    final url = '$apiUri/api/artifacts/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    return response.statusCode == 200;
  }

  static Future<List?> fetchArtifacts() async {
    final apiUri = dotenv.env['API_URI'];
    final url = '$apiUri/api/artifacts';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body) as List;
      return responseJson;
    } else {
      return null;
    }
  }

  static Future<bool> updateArtifact(String id, Map body) async {
    final apiUri = dotenv.env['API_URI'];
    final url = '$apiUri/api/artifacts/$id';
    final uri = Uri.parse(url);
    final response = await http.put(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
    return response.statusCode == 200;
  }

  static Future<bool> addArtifact(Map body) async {
    final apiUri = dotenv.env['API_URI'];
    final url = '$apiUri/api/sins';
    final uri = Uri.parse(url);
    final response = await http.post(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    return response.statusCode == 201;
  }
}
