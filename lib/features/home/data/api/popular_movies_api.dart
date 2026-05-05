import 'package:dio/dio.dart';
import 'package:movie_app/core/network/api_constant.dart';
import 'package:movie_app/core/network/api_result.dart';
import 'package:movie_app/features/home/data/model/home_model_dto.dart';

class PopularMoviesApi {
  Future<ApiResult<HomeModelDto>> getPopularMovies() async {
    try {
      Dio dio = Dio();
      var response = await dio.get(
        ApiConstants.baseUrl + ApiConstants.popularEndpoint,
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
