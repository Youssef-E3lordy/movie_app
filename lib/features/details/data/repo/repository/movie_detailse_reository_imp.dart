import 'package:movie_app/core/network/api_result.dart';
import 'package:movie_app/features/details/data/repo/data_source/movie_details_data_source_imp.dart';
import 'package:movie_app/features/details/domin/entities/movie_details_entity.dart';
import 'package:movie_app/features/details/domin/entities/similar_movie_entity.dart';
import 'package:movie_app/features/details/domin/repo/data_source/movie_details_data_source.dart';
import 'package:movie_app/features/details/domin/repo/repository/movie_details_repository.dart';

class MovieDetailsRepositoryImp implements MovieDetailsRepository {
  final MovieDetailsDataSource dataSource;

  MovieDetailsRepositoryImp({required this.dataSource});

  @override
  Future<ApiResult<MovieDetailsEntity>> getMovieDetails(int movieId) async {
    return await dataSource.getMovieDetails(movieId);
  }

  @override
  Future<ApiResult<List<SimilarMovieEntity>>> getSimilarMovies(int movieId) async {
    return await dataSource.getSimilarMovies(movieId);
  }
}


MovieDetailsRepository getMovieDetailsRepositoryInjectable() {
  return MovieDetailsRepositoryImp(dataSource: getMovieDetailsDataSourceInjectable());
}
