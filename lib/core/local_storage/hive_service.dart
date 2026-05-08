import 'package:hive_flutter/hive_flutter.dart';
import 'hive_models/movie_hive_model.dart';

class HiveService {
  static const String watchlistBoxName = 'watchlist_box';

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(MovieHiveModelAdapter());
    await Hive.openBox<MovieHiveModel>(watchlistBoxName);
  }

  static Box<MovieHiveModel> get watchlistBox => Hive.box<MovieHiveModel>(watchlistBoxName);

  static Future<void> saveMovie(MovieHiveModel movie) async {
    await watchlistBox.put(movie.id, movie);
  }

  static Future<void> removeMovie(int movieId) async {
    await watchlistBox.delete(movieId);
  }

  static List<MovieHiveModel> getAllMovies() {
    return watchlistBox.values.toList();
  }

  static bool isMovieSaved(int movieId) {
    return watchlistBox.containsKey(movieId);
  }
}