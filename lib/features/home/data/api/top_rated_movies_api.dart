import 'package:dio/dio.dart';
import 'package:movie_app/core/network/api_constant.dart';
import 'package:movie_app/core/network/api_error_handler.dart';
import 'package:movie_app/core/network/api_result.dart';
import 'package:movie_app/features/home/data/model/home_model_dto.dart';

class TopRatedMoviesApi {
  Future<ApiResult<HomeModelDto>> getTopRatedMovies() async {
    try {
      Dio dio = Dio();
      final response = await dio.get(
        ApiConstants.baseUrl + ApiConstants.topRatedEndpoint,
        queryParameters: {"api_key": ApiConstants.apiKey},
      );

      Map<String, dynamic> json = response.data;
      return ApiSuccess<HomeModelDto>(HomeModelDto.fromJson(json));
    } catch (e) {
      return ApiErrorHandler.handle(e);
    }
  }
}
