
import 'package:bloc/bloc.dart';
import 'package:movie_app/core/network/api_result.dart';
import 'package:movie_app/features/details/domin/entities/movie_details_entity.dart';
import 'package:movie_app/features/details/domin/entities/similar_movie_entity.dart';
import 'package:movie_app/features/details/domin/use_case/movie_details_use_case.dart';
import 'package:movie_app/features/details/domin/use_case/similar_movies_use_case.dart';
import 'package:movie_app/features/details/presentation/view_model/details_state.dart';

class DetailsCubit extends Cubit<MovieDetailsState> {
  final MovieDetailsUseCase useCase;

  DetailsCubit(this.useCase) : super(MovieDetailsInitialState());

  Future<void> fetchMovieDetails(int movieId) async {
    emit(MovieDetailsLoadingState());

    final result = await useCase.getMovieDetails(movieId);

    switch (result) {
      case ApiSuccess<MovieDetailsEntity>():
        emit(MovieDetailsSuccessState(result.data));
        break;
      case ApiError<MovieDetailsEntity>():
        emit(MovieDetailsErrorState(result.message));
        break;
    }
  }
}


class SimilarMoviesCubit extends Cubit<SimilarMoviesState> {
  final SimilarMoviesUseCase useCase;

  SimilarMoviesCubit(this.useCase)
      : super(SimilarMoviesInitialState());

  Future<void> fetchSimilarMovies(int movieId) async {
    emit(SimilarMoviesLoadingState());

    final result = await useCase.getSimilarMovies(movieId);

    switch (result) {
      case ApiSuccess<List<SimilarMovieEntity>>():
        emit(SimilarMoviesSuccessState(result.data));
        break;
      case ApiError<List<SimilarMovieEntity>>():
        emit(SimilarMoviesErrorState(result.message));
        break;
    }
  }
}
