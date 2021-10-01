import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:slash_assignment_movies/src/core/bloc/bloc_with_state.dart';
import 'package:slash_assignment_movies/src/core/params/movie_request_parameter.dart';
import 'package:slash_assignment_movies/src/core/resources/data_state.dart';
import 'package:slash_assignment_movies/src/data/models/movie_model.dart';
import 'package:slash_assignment_movies/src/domain/usecases/get_movies_usecase.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends BlocWithState<MoviesEvent, MoviesState> {
  final GetMoviesUseCase _getmoviesUseCase;

  MoviesBloc(this._getmoviesUseCase) : super(const MoviesLoading());

  final List<MovieModel> _movies = [];
  int _page = 1;
  static int _pageSize = 20;
  int _totalMovieCount = 0;

  @override
  Stream<MoviesState> mapEventToState(MoviesEvent event) async* {
    if (event is GetMoviesEvent) yield* _getBreakingNewsArticle(event);
  }

  Stream<MoviesState> _getBreakingNewsArticle(MoviesEvent event) async* {
    yield* runBlocProcess(() async* {
      if (event.fetchMore) {
        yield MoviesFetchingNextPage(_movies);
      } else {
        yield const MoviesLoading();
      }

      final dataState = await _getmoviesUseCase(
          params: MoviesRequestParams(page: _page, limit: 5));

      if (dataState is DataSuccess) {
        _pageSize = dataState.data?.movieCount ?? 20;
        final movies = dataState.data?.movies;
        final noMoreData = movies!.length > _pageSize;
        _movies.addAll(movies);
        _page++;
        yield MoviesLoadingDone(_movies, noMoreData: noMoreData);
      }
      if (dataState is DataFailed) {
        yield MoviesLoadingError(dataState.error!);
      }
    });
  }
}
