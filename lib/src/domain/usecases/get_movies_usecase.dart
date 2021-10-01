import 'package:slash_assignment_movies/src/core/params/movie_request_parameter.dart';
import 'package:slash_assignment_movies/src/data/models/movie_data_response_model.dart';
import 'package:slash_assignment_movies/src/data/models/movie_model.dart';
import 'package:slash_assignment_movies/src/domain/repositories/movies_repository.dart';

import '../../core/resources/data_state.dart';
import '../../core/usecase/usecase.dart';

class GetMoviesUseCase
    implements UseCase<DataState<MovieDataResponseModel>, MoviesRequestParams> {
  final MovieRepository _movieRepository;

  GetMoviesUseCase(this._movieRepository);

  @override
  Future<DataState<MovieDataResponseModel>> call(
      {required MoviesRequestParams params}) {
    return _movieRepository.getMovies(params);
  }
}
