import 'package:movie_app/core/network/api_result.dart';
import 'package:movie_app/features/popular/data/api/get_popular_movies_api.dart';
import 'package:movie_app/features/popular/data/model/popular_model_dto.dart';
import 'package:movie_app/features/popular/domain/entities/popular_entity.dart';
import 'package:movie_app/features/popular/domain/repo/data_source/popular_movie_data_source.dart';

class PopularMovieDataSourceImp implements PopularMovieDataSource {
  PopularMovieDataSourceImp(this.getPopularMovies);
  final GetPopularMoviesApi getPopularMovies;

  @override
  Future<ApiResult<PopularEntity>> getPopularMovie() async {
    try {
      var result = await getPopularMovies.getPopularMovies();
      switch (result) {
        case ApiSuccess<PopularModelDto>():
          return ApiSuccess<PopularEntity>(result.data.toEntity());
        case ApiError<PopularModelDto>():
          return ApiError<PopularEntity>(result.message);
      }
    } catch (e) {
      return ApiError<PopularEntity>(e.toString());
    }
  }
}
