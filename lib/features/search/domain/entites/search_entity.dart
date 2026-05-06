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
    16: "Animation",
    35: "Comedy",
    80: "Crime",
    99: "Documentary",
    18: "Drama",
    10751: "Family",
    14: "Fantasy",
    36: "History",
    27: "Horror",
    10402: "Music",
    9648: "Mystery",
    10749: "Romance",
    878: "Science Fiction",
    10770: "TV Movie",
    53: "Thriller",
    10752: "War",
    37: "Western",
  };

  String get genreNames {
    if (genreIds.isEmpty) return "Unknown";

    return genreMap[genreIds.first] ?? "Unknown";
  }
}
