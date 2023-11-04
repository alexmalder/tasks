import 'package:dio/dio.dart';
import 'package:videos/services/dio_wrapper.dart';

// @task need jwt token storage setter[api]
class SignService {
  static Future<bool> signIn(Map body) async {
    //final apiUri = dotenv.env['API_URI'];
    const url = '/api/v1/auth/sign-in';
    var formData = {
      "username": body['username'] as String,
      "password": body['password'] as String,
      "grant_type": "password",
      "client_id": "admin-rest-client"
    };
    final response = await AppHttpClient().dio.post(url, data: formData, options: Options(
      validateStatus: (status) {
        return status! < 415 && status! != 400;
      },
    ));
    return response.statusCode == 200;

  }
}
