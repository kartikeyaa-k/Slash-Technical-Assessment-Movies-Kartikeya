class MoviesRequestParams {
  final int limit;
  final int page;

  const MoviesRequestParams({
    this.limit = 10,
    this.page = 1,
  });
}
