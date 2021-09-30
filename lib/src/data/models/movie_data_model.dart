import 'movie_model.dart';

class Data {
  int? movieCount;
  int? limit;
  int? pageNumber;
  List<Movies>? movies;

  Data({this.movieCount, this.limit, this.pageNumber, this.movies});

  Data.fromJson(Map<String, dynamic> json) {
    movieCount = json['movie_count'];
    limit = json['limit'];
    pageNumber = json['page_number'];
    if (json['movies'] != null) {
      movies = [];
      json['movies'].forEach((v) {
        movies?.add(Movies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['movie_count'] = this.movieCount;
    data['limit'] = this.limit;
    data['page_number'] = this.pageNumber;
    if (this.movies != null) {
      data['movies'] = this.movies?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
