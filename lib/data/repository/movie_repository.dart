import 'package:the_movie_box/core/client/api_client.dart';
import 'package:the_movie_box/core/config/api_config.dart';
import 'package:the_movie_box/data/model/cast_and_crew_model.dart';
import 'package:the_movie_box/data/model/collection_model.dart';
import 'package:the_movie_box/data/model/external_id_model.dart';
import 'package:the_movie_box/data/model/movie_details.dart';
import 'package:the_movie_box/data/model/movie_model.dart';
import 'package:the_movie_box/data/model/platform_model.dart';
import 'package:the_movie_box/data/model/review_model.dart';
import 'package:the_movie_box/data/model/video_model.dart';
import 'package:the_movie_box/main.dart';

class MovieRepository {
  MovieRepository();
  final apiClient = getIt<ApiClient>();
  Future<List<Show>> fetchMovieResults({
    int page = 1,
  }) async {
    try {
      List<Show> movieMovieResultList = [];
      var body = {
        "include_adult": false,
        "include_video": false,
        "language": "en-US",
        "page": page,
        "sort_by": "popularity.desc"
      };
      final res = await apiClient.get(APIEndPoint.discoverMovies,
          queryParameters: body);
      res.data['results']
          .map((e) => movieMovieResultList.add(Show.fromJson(e)))
          .toList();
      return movieMovieResultList;
    } catch (e) {
      rethrow;
    }
  }

  Future<MovieDetails> fetchMovieDetails(int movieID) async {
    try {
      var body = {"language": "en-US"};
      final res = await apiClient.get(APIEndPoint.movieDetails(movieID),
          queryParameters: body);
      return MovieDetails.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchMovieCredits(int movieID) async {
    try {
      List<Cast> castList = [];
      List<Crew> crewList = [];
      var body = {"language": "en-US"};
      final res = await apiClient.get(APIEndPoint.movieCredits(movieID),
          queryParameters: body);
      res.data['cast'].map((e) => castList.add(Cast.fromJson(e))).toList();
      res.data['crew'].map((e) => crewList.add(Crew.fromJson(e))).toList();
      return {"cast": castList, "crew": crewList};
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Show>> fetchSimilarMovies(int movieID) async {
    try {
      List<Show> showList = [];
      var body = {"language": "en-US", "page": 1};
      final res = await apiClient.get(APIEndPoint.similarMovies(movieID),
          queryParameters: body);
      res.data['results'].map((e) => showList.add(Show.fromJson(e))).toList();
      return showList;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Reviews>> fetchMoviesReview(int movieID) async {
    try {
      List<Reviews> showList = [];
      var body = {"language": "en-US", "page": 1};
      final res = await apiClient.get(APIEndPoint.reviewMovies(movieID),
          queryParameters: body);
      res.data['results']
          .map((e) => showList.add(Reviews.fromJson(e)))
          .toList();
      return showList;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Buy>> fetchWhereToWatchMovie(int movieID) async {
    try {
      final res = await apiClient.get(
        APIEndPoint.watchProvidersMovies(movieID),
      );
      List<Buy> buyers = [];
      (res.data['results']['CA']?['buy'] ?? [])
          .map((e) => buyers.add(Buy.fromJson(e)))
          .toList();
      return buyers;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Videos>> fetchMoviesVideos(int movieID) async {
    try {
      var body = {"language": "en-US"};
      final res = await apiClient.get(APIEndPoint.videosOfMovies(movieID),
          queryParameters: body);
      List<Videos> videos = [];
      (res.data['results'] ?? [])
          .map((e) => videos.add(Videos.fromJson(e)))
          .toList();
      return videos;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Show>> searchMovies(String query) async {
    try {
      var body = {"language": "en-US"};
      final res = await apiClient.get(APIEndPoint.searchMovies(query),
          queryParameters: body);
      List<Show> searchResult = [];
      (res.data['results'] ?? [])
          .map((e) => searchResult.add(Show.fromJson(e)))
          .toList();
      return searchResult;
    } catch (e) {
      rethrow;
    }
  }

  Future<Collection> fetchCollectionOfMovies(int movieId) async {
    try {
      var body = {"language": "en-US"};
      final res = await apiClient.get(APIEndPoint.collectionMovies(movieId),
          queryParameters: body);
      return Collection.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<ExternalIds> fetchExternalLinkForMovies(int movieId) async {
    try {
      final res = await apiClient.get(
        APIEndPoint.externalIdforMovies(movieId),
      );
      return ExternalIds.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }
}
