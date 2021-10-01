import 'package:slash_assignment_movies/src/core/params/movie_request_parameter.dart';
import 'package:slash_assignment_movies/src/core/resources/data_state.dart';
import 'package:slash_assignment_movies/src/data/models/movie_data_response_model.dart';
import 'package:slash_assignment_movies/src/data/models/movie_model.dart';

abstract class MovieRepository {
  Future<DataState<MovieDataResponseModel>> getMovies(
      MoviesRequestParams params);
}
