import 'package:dio/dio.dart';

import 'package:retrofit/retrofit.dart';
import 'package:slash_assignment_movies/src/core/utils/constants.dart';

part 'movie_api_service.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class MovieApiService {
  factory MovieApiService(Dio dio, {String baseUrl}) = _MovieApiService;

  @GET('/v2/list_movies.json')
  Future<HttpResponse> getMovies(
    @Query("limit") int limit,
    @Query("page") int country,
  );
}
