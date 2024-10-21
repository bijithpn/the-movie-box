import 'package:the_movie_box/core/client/api_client.dart';
import 'package:the_movie_box/core/config/api_config.dart';
import 'package:the_movie_box/data/model/cast_and_crew_model.dart';
import 'package:the_movie_box/data/model/movie_model.dart';
import 'package:the_movie_box/data/model/platform_model.dart';
import 'package:the_movie_box/data/model/review_model.dart';
import 'package:the_movie_box/data/model/series_details.dart';
import 'package:the_movie_box/data/model/series_episodes.dart';
import 'package:the_movie_box/data/model/video_model.dart';
import 'package:the_movie_box/main.dart';

class SeriesRepository {
  SeriesRepository();
  final apiClient = getIt<ApiClient>();
  Future<List<Show>> fetchTVSeriesResults({
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
      final res =
          await apiClient.get(APIEndPoint.discoverTV, queryParameters: body);

      res.data['results']
          .map((e) => movieMovieResultList.add(Show.fromJson(e)))
          .toList();
      return movieMovieResultList;
    } catch (e) {
      rethrow;
    }
  }

  Future<SeriesDetails> fetchSeriesDetails(int seriesId) async {
    try {
      var body = {"language": "en-US"};
      final res = await apiClient.get(APIEndPoint.seriesDetails(seriesId),
          queryParameters: body);
      return SeriesDetails.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchSeriesCredits(int seriesId) async {
    try {
      List<Cast> castList = [];
      List<Crew> crewList = [];
      var body = {"language": "en-US"};
      final res = await apiClient.get(APIEndPoint.seriesCredits(seriesId),
          queryParameters: body);
      res.data['cast'].map((e) => castList.add(Cast.fromJson(e))).toList();
      res.data['crew'].map((e) => crewList.add(Crew.fromJson(e))).toList();
      return {"cast": castList, "crew": crewList};
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Show>> fetchSimilarSeries(int seriesId) async {
    try {
      List<Show> showList = [];
      var body = {"language": "en-US", "page": 1};
      final res = await apiClient.get(APIEndPoint.similarSeries(seriesId),
          queryParameters: body);
      res.data['results'].map((e) => showList.add(Show.fromJson(e))).toList();
      return showList;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Reviews>> fetchSeriesReview(int seriesId) async {
    try {
      List<Reviews> showList = [];
      var body = {"language": "en-US", "page": 1};
      final res = await apiClient.get(APIEndPoint.reviewSeries(seriesId),
          queryParameters: body);
      res.data['results']
          .map((e) => showList.add(Reviews.fromJson(e)))
          .toList();
      return showList;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Buy>> fetchWhereToWatchSeries(int seriesId) async {
    try {
      final res = await apiClient.get(
        APIEndPoint.watchProvidersSeries(seriesId),
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

  Future<List<Videos>> fetchSeriesVideos(int seriesId) async {
    try {
      var body = {"language": "en-US"};
      final res = await apiClient.get(APIEndPoint.videosOfSeries(seriesId),
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

  Future<SeriesEpisodes> fetchSeriesEpisodes(int seriesId, int season) async {
    try {
      final res = await apiClient.get(
        APIEndPoint.seriesSeasonDetails(seriesId: seriesId, season: season),
      );
      return SeriesEpisodes.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Show>> searchSeries(String query) async {
    try {
      var body = {"language": "en-US"};
      final res = await apiClient.get(APIEndPoint.searchSeries(query),
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
}
