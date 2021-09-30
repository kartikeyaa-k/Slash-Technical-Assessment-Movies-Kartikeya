class MoviesRequestParams {
  final int limit;
  final int page;

  const MoviesRequestParams({
    this.limit = 20,
    this.page = 1,
  });
}
