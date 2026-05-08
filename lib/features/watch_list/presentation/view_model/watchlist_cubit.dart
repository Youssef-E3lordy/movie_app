import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/local_storage/hive_models/movie_hive_model.dart';
import '../../data/repo/watchlist_repository.dart';
import 'watchlist_state.dart';

class WatchlistCubit extends Cubit<WatchlistState> {
  final WatchlistRepository repository;

  WatchlistCubit(this.repository) : super(WatchlistInitial());

  void loadWatchlist() {
    emit(WatchlistLoading());
    try {
      final movies = repository.getSavedMovies();
      emit(WatchlistSuccess(movies));
    } catch (e) {
      emit(WatchlistError(e.toString()));
    }
  }

  Future<void> toggleWatchlist(MovieHiveModel movie) async {
    try {
      final isSaved = repository.isSaved(movie.id);
      if (isSaved) {
        await repository.removeMovie(movie.id);
      } else {
        await repository.saveMovie(movie);
      }
      loadWatchlist();
    } catch (e) {
      emit(WatchlistError(e.toString()));
    }
  }
}