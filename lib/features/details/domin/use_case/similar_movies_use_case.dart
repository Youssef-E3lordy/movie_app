import 'package:movie_app/core/network/api_result.dart';
import 'package:movie_app/features/details/data/repo/repository/movie_detailse_reository_imp.dart';

import 'package:movie_app/features/details/domin/entities/similar_movie_entity.dart';
import 'package:movie_app/features/details/domin/repo/repository/movie_details_repository.dart';

class SimilarMoviesUseCase {
  final MovieDetailsRepository repository;

  SimilarMoviesUseCase(this.repository);

 

  Future<ApiResult<List<SimilarMovieEntity>>> getSimilarMovies(int movieId) {
    return repository.getSimilarMovies(movieId);
  }
}
SimilarMoviesUseCase getSimilarMoviesUseCaseInjector() {
  return SimilarMoviesUseCase(getMovieDetailsRepositoryInjectable());
}