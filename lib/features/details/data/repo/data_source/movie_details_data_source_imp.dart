import 'package:movie_app/core/network/api_result.dart';

import 'package:movie_app/features/details/data/api/movie_details_api.dart';
import 'package:movie_app/features/details/domin/entities/movie_details_entity.dart';
import 'package:movie_app/features/details/domin/entities/similar_movie_entity.dart';
import 'package:movie_app/features/details/domin/repo/data_source/movie_details_data_source.dart';

class MovieDetailsDataSourceImp implements MovieDetailsDataSource {
  final MovieDetailsApi detailsApi;

  MovieDetailsDataSourceImp({required this.detailsApi});

  @override
  Future<ApiResult<MovieDetailsEntity>> getMovieDetails(int movieId) async {
    final result = await detailsApi.getMovieDetails(movieId);

    switch (result) {
      case ApiSuccess():
        return ApiSuccess(result.data.toEntity());

      case ApiError():
        return ApiError(result.message);
    }
  }

  @override
  Future<ApiResult<List<SimilarMovieEntity>>> getSimilarMovies(
    int movieId,
  ) async {
    final result = await detailsApi.getSimilarMovies(movieId);

    switch (result) {
      case ApiSuccess():
        return ApiSuccess(
          result.data.map((e) => e.toEntity()).toList(),
        );

      case ApiError():
        return ApiError(result.message);
    }
  }
}
MovieDetailsDataSource getMovieDetailsDataSourceInjectable() {
  return MovieDetailsDataSourceImp(detailsApi: getMovieDetailsApiInjectable());
}
