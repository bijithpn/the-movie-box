class APIConfig {
  static const String baseURL = 'https://api.themoviedb.org/3/';
  static const String imageURL = 'https://image.tmdb.org/t/p/original/';
}

class APIEndPoint {
  static const String discoverMovies = 'discover/movie';
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

  static String reviewMovies(int movieId) {
    return "movie/$movieId/reviews";
  }

  static String videosOfMovies(int movieId) {
    return "movie/$movieId/videos";
  }

  static String searchMovies(String query) {
    return "search/movie?query=$query";
  }

  static String collectionMovies(int movieId) {
    return "collection/$movieId";
  }

//--------------------------------------------------//
//               Series api start
//--------------------------------------------------//
  static const String discoverTV = 'discover/tv';

  static String seriesDetails(int movieId) {
    return "tv/$movieId";
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

  static String seriesSeasonDetails(
      {required int seriesId, required int season}) {
    return "tv/$seriesId/season/$season";
  }

  static String similarSeries(int seriesId) {
    return "tv/$seriesId/similar";
  }

  static String reviewSeries(int seriesId) {
    return "tv/$seriesId/reviews";
  }

  static String videosOfSeries(int seriesId) {
    return "tv/$seriesId/videos";
  }

  static String searchSeries(String query) {
    return "search/tv?query=$query";
  }
}
