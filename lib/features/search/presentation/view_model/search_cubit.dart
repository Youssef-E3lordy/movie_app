import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/search/domain/repo/search_repo.dart';
import 'package:movie_app/features/search/presentation/view_model/search_state.dart';
@injectable
class SearchCubit extends Cubit<SearchState> {
  SearchCubit({required this.searchRepo}) : super(InitialState());
  final SearchRepo searchRepo;
  Future<void> searchMovie(String query) async {
    emit(LoadingState());
    try {
      final result = await searchRepo.searchMovies(query);
      emit(SuccessState(movies: result.results));
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }
}
