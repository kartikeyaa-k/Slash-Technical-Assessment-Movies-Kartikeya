part of 'movies_bloc.dart';

abstract class MoviesState extends Equatable {
  final List<MovieModel>? movies;
  final bool? noMoreData;

  final DioError? error;

  const MoviesState({this.movies, this.noMoreData, this.error});

  @override
  List<Object> get props => [movies ?? [], noMoreData ?? '', error ?? ""];
}

class MoviesLoading extends MoviesState {
  const MoviesLoading();
}

class MoviesLoadingDone extends MoviesState {
  const MoviesLoadingDone(List<MovieModel> movies, {bool noMoreData = false})
      : super(movies: movies, noMoreData: noMoreData);
}

class MoviesLoadingError extends MoviesState {
  const MoviesLoadingError(DioError error) : super(error: error);
}

class MoviesFetchingNextPage extends MoviesState {
  const MoviesFetchingNextPage(List<MovieModel> movies) : super(movies: movies);
}
