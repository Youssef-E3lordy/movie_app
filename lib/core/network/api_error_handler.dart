import 'package:dio/dio.dart';
import 'package:movie_app/core/network/error_message_model.dart';
import 'api_result.dart';

abstract class ApiErrorHandler {
  static ApiError<T> handle<T>(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return  ApiError(
            'Request timed out. Please check your connection.',
          );

        case DioExceptionType.badResponse:
          if (error.response != null && error.response?.data != null) {
            try {
              final errorModel = ErrorMessageModel.fromJson(
                error.response!.data,
              );
              return ApiError(errorModel.statusMessage);
            } catch (_) {
              return ApiError(
                messageFromStatusCode(error.response?.statusCode ?? 0),
              );
            }
          }
          return ApiError(
            messageFromStatusCode(error.response?.statusCode ?? 0),
          );

        case DioExceptionType.cancel:
          return  ApiError('Request was cancelled.');

        case DioExceptionType.connectionError:
          return  ApiError('No internet CONNECTION.');

        default:
          return  ApiError('Something went wrong with the connection.');
      }
    }

    return ApiError(error.toString());
  }

  static String messageFromStatusCode(int statusCode) {
    return switch (statusCode) {
      400 => 'Bad request',
      401 => 'Unauthorized',
      403 => 'Forbidden',
      404 => 'Not found',
      408 => 'Request timed out',
      500 => 'Internal server error',
      503 => 'Service unavailable',
      _ => 'Something went wrong (status: $statusCode)',
    };
  }
}
