

import 'package:movie_app/features/details/domin/entities/movie_details_entity.dart';

class MovieDetailsDto {
  final String backdropPath;
  final String posterPath;    
  final String title;
  final String releaseDate;
  final double voteAverage;
  final int runtime;
  final String overview;
  final List<String> genres;




  const MovieDetailsDto({
    required this.backdropPath,
    required this.posterPath,
    required this.title,
    required this.releaseDate,
    required this.voteAverage,
    required this.runtime,
    required this.overview,
    required this.genres,
  });

  factory MovieDetailsDto.fromJson(Map<String, dynamic> json) {
    return MovieDetailsDto(
      backdropPath: json["backdrop_path"] ?? "",
      posterPath: json["poster_path"] ?? "",
      title: json["title"] ?? "",
      releaseDate: json["release_date"] ?? "",
      voteAverage: (json["vote_average"] as num?)?.toDouble() ?? 0,
      runtime: json["runtime"] ?? 0,
      overview: json["overview"] ?? "",
      genres: List<String>.from(json["genres"].map((e) => e["name"])),
    );
  }

  MovieDetailsEntity toEntity() {
    return MovieDetailsEntity(
      backdropPath: backdropPath,
      posterPath: posterPath,
      title: title,
      releaseDate: releaseDate,
      voteAverage: voteAverage,
      runtime: runtime,
      overview: overview,
      genres: genres,
    );
  }

}