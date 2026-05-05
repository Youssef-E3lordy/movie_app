class ApiConstants {
  static const String baseUrl = "https://api.themoviedb.org/3";
  static const String apiKey = "9d7f94be913eddf2db40e317d2f12f36";

  // Search
  static const String searchMoviesEndpoint = "/search/movie";

  // Details
  static String getMovieDetails(int movieId) => "/movie/$movieId";
  static String getMovieSimilars(int movieId) => "/movie/$movieId/similar";

  // Home endpoints
  static const String releasesEndpoint = "/movie/now_playing";
  static const String popularEndpoint = "/movie/popular";
  static const String topRatedEndpoint = "/movie/top_rated";

  // Image Urls
  static const String prefixImageUrl = "https://image.tmdb.org/t/p/w500";
  static String getFullImageUrl(String imagePath) => "$prefixImageUrl$imagePath";
}
//https://api.themoviedb.org/3/search/movie&apiKey=9d7f94be913eddf2db40e317d2f12f36