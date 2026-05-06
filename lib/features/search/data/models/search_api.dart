import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
@singleton
class ApiSearchService {
  final Dio dio;

  ApiSearchService(this.dio);

  Future<Response> get({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio.get(endpoint, queryParameters: queryParameters);
  }
}
