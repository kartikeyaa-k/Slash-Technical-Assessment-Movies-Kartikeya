import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:slash_assignment_movies/src/data/datasources/remote/movie_api_service.dart';
import 'package:slash_assignment_movies/src/data/repositories/movies_repository_impl.dart';
import 'package:slash_assignment_movies/src/domain/repositories/movies_repository.dart';
import 'package:slash_assignment_movies/src/domain/usecases/get_movies_usecase.dart';
import 'package:slash_assignment_movies/src/presentation/blocs/movies_bloc.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio client
  injector.registerSingleton<Dio>(Dio());

  // Dependencies
  injector.registerSingleton<MovieApiService>(MovieApiService(injector()));
  injector.registerSingleton<MovieRepository>(MoviesRepositoryImpl(injector()));

  // UseCases
  injector.registerSingleton<GetMoviesUseCase>(GetMoviesUseCase(injector()));

  // Blocs
  injector.registerFactory<MoviesBloc>(() => MoviesBloc(injector()));
}
