import 'package:movie_app/features/search/data/models/search_model_dto.dart';
import 'package:movie_app/features/search/domain/entites/search_entity.dart';

extension SearchMapper on SearchModelDto {
  SearchEntity toEntity() {
    return SearchEntity(
      page: page??0,
      totalPages: totalPages??0,
      totalResults: totalResults??0,
      results: results?.map((movie) => movie.toEntity()).toList()??[],
    );
  }
}
extension MovieMapper on MovieModel {
  MovieEntity toEntity() {
    return MovieEntity(
      adult: adult??false,
      genreIds: genreIds??[],
      id: id??0,
      title: title??"",
      popularity: popularity??0,
      posterPath: posterPath??"",
      releaseDate: releaseDate??"",
      voteAverage: voteAverage??0,
    );
  }
}












  // String title;
  // double popularity;
  // String posterPath;
  // String releaseDate;
  // double voteAverage;