import 'package:dio/dio.dart';
import 'package:movie_app/core/network/api_constant.dart';
import 'package:movie_app/core/network/api_result.dart';
import 'package:movie_app/features/popular/data/model/popular_model_dto.dart';

class GetPopularMoviesApi {
  Future<ApiResult<PopularModelDto>> getPopularMovies() async {
    try {
      Dio dio = Dio();
      var response = await dio.get(
        ApiConstants.baseUrl + ApiConstants.popularEndpoint,
        queryParameters: {"api_key": ApiConstants.apiKey},
      );
      if ((response.statusCode ?? 400) >= 200 &&
          (response.statusCode ?? 400) < 300) {
        Map<String, dynamic> json = response.data;

        return ApiSuccess<PopularModelDto>(PopularModelDto.fromJson(json));
      } else {
        return ApiError<PopularModelDto>("Error");
      }
    } catch (e) {
      return ApiError<PopularModelDto>(e.toString());
    }
  }
}
