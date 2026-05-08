import 'package:hive/hive.dart';

part 'movie_hive_model.g.dart';

@HiveType(typeId: 0)
class MovieHiveModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String posterPath;

  @HiveField(3)
  final double rating;

  @HiveField(4)
  final String genre;

  @HiveField(5)
  final String releaseYear;

  @HiveField(6)
  final String runtime;

  MovieHiveModel({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.rating,
    required this.genre,
    required this.releaseYear,
    required this.runtime,
  });
}