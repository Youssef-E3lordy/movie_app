import 'package:movie_app/core/local_storage/hive_models/movie_hive_model.dart';
import 'package:movie_app/core/local_storage/hive_service.dart';

class WatchlistRepository {
  List<MovieHiveModel> getSavedMovies() {
    return HiveService.getAllMovies();
  }

  Future<void> saveMovie(MovieHiveModel movie) async {
    await HiveService.saveMovie(movie);
  }

  Future<void> removeMovie(int movieId) async {
    await HiveService.removeMovie(movieId);
  }

  bool isSaved(int movieId) {
    return HiveService.isMovieSaved(movieId);
  }
}