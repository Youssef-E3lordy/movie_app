import 'package:dio/dio.dart';
import 'package:movie_app/core/network/api_constant.dart';
import 'package:movie_app/core/network/api_error_handler.dart';
import 'package:movie_app/core/network/api_result.dart';
import 'package:movie_app/core/network/dio_factory.dart';
import 'package:movie_app/features/details/data/model/movie_details_model.dart';
import 'package:movie_app/features/details/data/model/similar_movie_model.dart';





class MovieDetailsApi {
  final Dio dio;
 
  MovieDetailsApi(this.dio);
  
  Future<ApiResult<MovieDetailsDto>> getMovieDetails(int movieId) async {
    try {
      final response = await dio.get(
        ApiConstants.getMovieDetails(movieId),
      );

      return ApiSuccess(MovieDetailsDto.fromJson(response.data));

    } catch (error) {
      return ApiErrorHandler.handle(error);
    }
  }

  Future<ApiResult<List<SimilarMovieDto>>> getSimilarMovies(int movieId) async {
    try {
      final response = await dio.get(
        ApiConstants.getMovieSimilars(movieId),
      );

      final results = (response.data["results"] as List?) ?? [];

      final movies = results
          .map((e) => SimilarMovieDto.fromJson(e))
          .toList();

      return ApiSuccess(movies);

    } catch (error) {
      return ApiErrorHandler.handle(error);
    }
  }
}
MovieDetailsApi getMovieDetailsApiInjectable() {
  return MovieDetailsApi(DioFactory.getDio());
}




