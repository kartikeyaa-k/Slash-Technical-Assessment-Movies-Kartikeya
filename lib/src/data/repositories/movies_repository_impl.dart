import 'dart:io';

import 'package:dio/dio.dart';
import 'package:slash_assignment_movies/src/core/params/movie_request_parameter.dart';
import 'package:slash_assignment_movies/src/core/utils/constants.dart';
import 'package:slash_assignment_movies/src/data/datasources/remote/movie_api_service.dart';
import 'package:slash_assignment_movies/src/data/models/movie_data_response_model.dart';
import 'package:slash_assignment_movies/src/domain/repositories/movies_repository.dart';

import '../../core/resources/data_state.dart';

class MoviesRepositoryImpl implements MovieRepository {
  final MovieApiService _newsApiService;

  const MoviesRepositoryImpl(this._newsApiService);

  @override
  Future<DataState<MovieDataResponseModel>> getMovies(
    MoviesRequestParams params,
  ) async {
    try {
      final httpResponse =
          await _newsApiService.getMovies(params.limit, params.page);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(
            MovieDataResponseModel.fromJson(httpResponse.data['data']));
      }

      return DataFailed(
        DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: kBaseUrl),
        ),
      );
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }
}
