import 'dart:async';

import 'package:dio/dio.dart';
import 'package:sentry_dio/sentry_dio.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:uuid/uuid.dart';

class AppHttpClient {
  late Dio _dio;
  final String _traceId = const Uuid().v4().toString();

  Dio get dio => _dio;

  AppHttpClient() {
    _dio = Dio(BaseOptions(
      //baseUrl: Environment.apiUrl,
      contentType: 'application/json',
      headers: <String, dynamic>{
        'Content-Type': 'application/json',
        'X-Request-Id': _traceId,
        'Accept': 'application/json',
      },
    ));

    // debug logs interceptor
    /*
    _dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true),
    );
    */

    _dio.addSentry(
      failedRequestStatusCodes: [
        SentryStatusCode(400),
        SentryStatusCode(401),
        SentryStatusCode(403),
        SentryStatusCode(404),
        SentryStatusCode(500),
      ],
    );
    Sentry.configureScope((scope) => scope.setTag('X-Request-Id', _traceId));
  }
}
