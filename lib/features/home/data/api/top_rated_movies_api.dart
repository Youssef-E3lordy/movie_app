import 'package:dio/dio.dart';
import 'package:movie_app/core/network/api_constant.dart';
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
      if ((response.statusCode ?? 400) >= 200 &&
          (response.statusCode ?? 400) < 300) {
        Map<String, dynamic> json = response.data;

        return ApiSuccess<HomeModelDto>(HomeModelDto.fromJson(json));
      } else {
        return ApiError<HomeModelDto>("Error");
      }
    } catch (e) {
      return ApiError<HomeModelDto>(e.toString());
    }
  }
}
