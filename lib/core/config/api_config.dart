class APIConfig {
  static const String baseURL = 'https://api.themoviedb.org/3/';
  static const String imageURL = 'https://image.tmdb.org/t/p/original/';
}

class APIEndPoint {
  static const String discoverMovies = 'discover/movie';
  static const String discoverTV = 'discover/tv';
  static const String tvSeriesDetails = 'tv';
  static String movieDetails(int movieId) {
    return "movie/$movieId";
  }

  static String movieCredits(int movieId) {
    return "movie/$movieId/credits";
  }

  static String watchProvidersMovies(int movieId) {
    return "movie/$movieId/watch/providers";
  }

  static String externalIdsMovies(int movieId) {
    return "movie/$movieId/external_ids";
  }

  static String similarMovies(int movieId) {
    return "movie/$movieId/similar";
  }

  static String seriesCredits(int seriesId) {
    return "tv/$seriesId/credits";
  }

  static String watchProvidersSeries(int seriesId) {
    return "tv/$seriesId/watch/providers";
  }

  static String externalIdsSeries(int seriesId) {
    return "tv/$seriesId/external_ids";
  }

  static String similarSeries(int seriesId) {
    return "tv/$seriesId/similar";
  }
}
