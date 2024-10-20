import 'package:the_movie_box/core/client/api_client.dart';
import 'package:the_movie_box/core/config/api_config.dart';
import 'package:the_movie_box/data/model/cast_and_crew_model.dart';
import 'package:the_movie_box/data/model/movie_details.dart';
import 'package:the_movie_box/data/model/movie_model.dart';
import 'package:the_movie_box/data/model/platform_model.dart';
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

  Future<List<Show>> fetchSimilarMovie(int movieID) async {
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
}
