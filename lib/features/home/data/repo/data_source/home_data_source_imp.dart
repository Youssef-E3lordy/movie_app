import 'package:movie_app/core/network/api_result.dart';
import 'package:movie_app/features/home/data/api/popular_movies_api.dart';
import 'package:movie_app/features/home/data/api/release_movie_api.dart';
import 'package:movie_app/features/home/data/api/top_rated_movies_api.dart';
import 'package:movie_app/features/home/data/model/home_model_dto.dart';
import 'package:movie_app/features/home/domain/entities/home_entity.dart';
import 'package:movie_app/features/home/domain/repo/data_source/home_data_source.dart';

class HomeDataSourceImp implements HomeDataSource {
  HomeDataSourceImp({
    required this.getPopularMovies,
    required this.getTopRatedMovies,
    required this.getReleaseMovies,
  });
  final PopularMoviesApi getPopularMovies;
  final TopRatedMoviesApi getTopRatedMovies;
  final ReleaseMovieApi getReleaseMovies;

  @override
  Future<ApiResult<HomeEntity>> getPopularMovie() async {
    try {
      var result = await getPopularMovies.getPopularMovies();
      switch (result) {
        case ApiSuccess<HomeModelDto>():
          return ApiSuccess<HomeEntity>(result.data.toEntity());
        case ApiError<HomeModelDto>():
          return ApiError<HomeEntity>(result.message);
      }
    } catch (e) {
      return ApiError<HomeEntity>(e.toString());
    }
  }

  @override
  Future<ApiResult<HomeEntity>> getTopRatedMovie() async {
    try {
      var result = await getTopRatedMovies.getTopRatedMovies();
      switch (result) {
        case ApiSuccess<HomeModelDto>():
          return ApiSuccess<HomeEntity>(result.data.toEntity());
        case ApiError<HomeModelDto>():
          return ApiError<HomeEntity>(result.message);
      }
    } catch (e) {
      return ApiError<HomeEntity>(e.toString());
    }
  }

  @override
  Future<ApiResult<HomeEntity>> getReleasedMovie() async {
    try {
      var result = await getReleaseMovies.getReleaseMovies();
      switch (result) {
        case ApiSuccess<HomeModelDto>():
          return ApiSuccess<HomeEntity>(result.data.toEntity());
        case ApiError<HomeModelDto>():
          return ApiError<HomeEntity>(result.message);
      }
    } catch (e) {
      return ApiError<HomeEntity>(e.toString());
    }
  }
}

HomeDataSource homeDataSourceInjectable() => HomeDataSourceImp(
  getPopularMovies: PopularMoviesApi(),
  getTopRatedMovies: TopRatedMoviesApi(),
  getReleaseMovies: ReleaseMovieApi(),
);
