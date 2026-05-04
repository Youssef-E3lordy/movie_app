import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/network/api_result.dart';
import 'package:movie_app/features/popular/domain/entities/popular_entity.dart';
import 'package:movie_app/features/popular/domain/use_case/get_popular_movies_use_case.dart';
part 'popular_state.dart';

class PopularCubit extends Cubit<PopularState> {
  PopularCubit(this.getPopularMoviesUseCase) : super(PopularLoading());
  List<Results> popularMovies = [];
  String errorMessage = "Error try again later";
  final GetPopularMoviesUseCase getPopularMoviesUseCase;
  Future<void> getPopularMovies() async {
    emit(PopularLoading());
    var result = await getPopularMoviesUseCase.invoke();
    switch (result) {
      case ApiSuccess():
        popularMovies = result.data.results;
        emit(PopularSuccess());
      case ApiError():
        emit(PopularError());
    }
  }
}
