
import 'package:movie_app/features/details/domin/entities/movie_details_entity.dart';
import 'package:movie_app/features/details/domin/entities/similar_movie_entity.dart';

abstract class MovieDetailsState {}

class MovieDetailsInitialState extends MovieDetailsState {}

class MovieDetailsLoadingState extends MovieDetailsState {}

class MovieDetailsSuccessState extends MovieDetailsState {
  final MovieDetailsEntity data;
  MovieDetailsSuccessState(this.data);
}


class MovieDetailsErrorState extends MovieDetailsState {
  final String error;
  MovieDetailsErrorState(this.error);
}


abstract class SimilarMoviesState {}

class SimilarMoviesInitialState extends SimilarMoviesState {}

class SimilarMoviesLoadingState extends SimilarMoviesState {}

class SimilarMoviesSuccessState extends SimilarMoviesState {
  final List<SimilarMovieEntity> data;
  SimilarMoviesSuccessState(this.data);
}

class SimilarMoviesErrorState extends SimilarMoviesState {
  final String error;
  SimilarMoviesErrorState(this.error);
}