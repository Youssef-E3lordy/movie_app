import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/core/network/api_constant.dart';

class DioFactory {
  static Dio? _dio;

  static Dio getDio() {
    if (_dio != null) return _dio!;

    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    _dio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.queryParameters['api_key'] = ApiConstants.apiKey;
          return handler.next(options);
        },
      ),
    );
      //debug interceptor 
    if (kDebugMode) {
      _dio!.interceptors.add(
        LogInterceptor(
          request: true,
          requestHeader: false,
          requestBody: true,
          responseHeader: false,
          responseBody: true,
          error: true,
        ),
      );
    }

    return _dio!;
  }
}

