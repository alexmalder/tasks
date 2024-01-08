import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:videos/models/sign_in_response.dart';
import 'package:videos/services/dio_wrapper.dart';

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
    if (response.statusCode == 200) {
      SignInResponse signInResponse = SignInResponse.fromJson(response.data);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('accessToken', signInResponse.accessToken);
      await prefs.setString('refreshToken', signInResponse.refreshToken);
      await prefs.setInt('expiresIn', signInResponse.expiresIn);
      await prefs.setInt('refreshExpiresIn', signInResponse.refreshExpiresIn);
      return true;
    }
    return response.statusCode == 200;
  }
}
