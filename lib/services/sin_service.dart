import 'dart:convert';

import 'package:http/http.dart' as http;

// all todo api calls
class ArtifactService {
  static Future<bool> deleteById(String id) async {
    // Delete the item
    final url = 'https://api.vnmntn.com/api/sins?id=$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    return response.statusCode == 200;
  }

  static Future<List?> fetchArtifacts() async {
    const url = 'https://api.vnmntn.com/api/sins';
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
    final url = 'https://api.vnmntn.com/api/sins?id=$id';
    final uri = Uri.parse(url);
    final response = await http.put(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
    return response.statusCode == 200;
  }

  static Future<bool> addArtifact(Map body) async {
    const url = 'https://api.vnmntn.com/api/sins';
    final uri = Uri.parse(url);
    final response = await http.post(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    return response.statusCode == 201;
  }
}
