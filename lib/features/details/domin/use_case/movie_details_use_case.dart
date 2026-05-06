import 'package:movie_app/core/network/api_result.dart';
import 'package:movie_app/features/details/data/repo/repository/movie_detailse_reository_imp.dart';
import 'package:movie_app/features/details/domin/entities/movie_details_entity.dart';

import 'package:movie_app/features/details/domin/repo/repository/movie_details_repository.dart';

class MovieDetailsUseCase {
  final MovieDetailsRepository repository;

  MovieDetailsUseCase(this.repository);

  Future<ApiResult<MovieDetailsEntity>> getMovieDetails(int movieId) {
    return repository.getMovieDetails(movieId);
  }


}

MovieDetailsUseCase getMovieDetailsUseCaseInjector() {
  return MovieDetailsUseCase(getMovieDetailsRepositoryInjectable());
}
