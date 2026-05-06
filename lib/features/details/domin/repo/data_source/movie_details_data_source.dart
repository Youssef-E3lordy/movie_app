import 'package:movie_app/core/network/api_result.dart';
import 'package:movie_app/features/details/domin/entities/movie_details_entity.dart';
import 'package:movie_app/features/details/domin/entities/similar_movie_entity.dart';


abstract interface class MovieDetailsDataSource {
  Future<ApiResult<MovieDetailsEntity>> getMovieDetails(int movieId);
  Future<ApiResult<List<SimilarMovieEntity>>> getSimilarMovies(int movieId);
}