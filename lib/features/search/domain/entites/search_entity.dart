class SearchEntity {
  int page;
  List<MovieEntity> results;
  int totalPages;
  int totalResults;

  SearchEntity({
    this.page = 0,
    this.results = const [],
    this.totalPages = 0,
    this.totalResults = 0,
  });
}

class MovieEntity {
  bool adult;
  List<int> genreIds;
  int id;
  String title;
  double popularity;
  String posterPath;
  String releaseDate;
  double voteAverage;

  MovieEntity({
    this.adult = false,
    this.genreIds = const [],
    this.id = 0,
    this.title = "",
    this.popularity = 0,
    this.posterPath = "",
    this.releaseDate = "",
    this.voteAverage = 0,
  });

  static const Map<int, String> genreMap = {
    28: "Action",
    12: "Adventure",
    878: "Sci-Fi",
    18: "Drama",
    35: "Comedy",
  };

  List<String> get genreNames {
    return genreIds.map((id) => genreMap[id] ?? "Unknown").toList();
  }
}
