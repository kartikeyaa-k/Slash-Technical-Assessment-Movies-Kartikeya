import 'movie_model.dart';

class MovieDataResponseModel {
  int? movieCount;
  int? limit;
  int? pageNumber;
  List<MovieModel>? movies;

  MovieDataResponseModel(
      {this.movieCount, this.limit, this.pageNumber, this.movies});

  factory MovieDataResponseModel.fromJson(Map<String, dynamic> json) {
    return MovieDataResponseModel(
      movieCount: json['movie_count'],
      limit: json['limit'],
      pageNumber: json['page_number'],
      movies: List<MovieModel>.from(
        (json['movies'] as List<dynamic>).map(
          (e) => MovieModel.fromJson(e as Map<String, dynamic>),
        ),
      ),
    );
  }
}
