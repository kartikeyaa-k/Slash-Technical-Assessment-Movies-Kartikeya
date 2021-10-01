part of 'movies_bloc.dart';

abstract class MoviesEvent extends Equatable {
  final bool fetchMore;
  const MoviesEvent({required this.fetchMore});
  @override
  List<Object> get props => [];
}

class GetMoviesEvent extends MoviesEvent {
  const GetMoviesEvent({required bool fetchMore}) : super(fetchMore: fetchMore);
}
