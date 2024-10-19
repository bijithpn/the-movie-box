import 'package:the_movie_box/core/client/api_client.dart';
import 'package:the_movie_box/core/config/api_config.dart';
import 'package:the_movie_box/data/model/movie_model.dart';
import 'package:the_movie_box/data/model/series_details.dart';
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
      final res = await apiClient.get(
          "${APIEndPoint.tvSeriesDetails}/$seriesId",
          queryParameters: body);
      return SeriesDetails.fromJson(res.data);
    } catch (e, stackTrace) {
      print(stackTrace);
      rethrow;
    }
  }
}
