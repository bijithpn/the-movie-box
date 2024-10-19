import 'package:the_movie_box/core/client/api_client.dart';
import 'package:the_movie_box/core/config/api_config.dart';
import 'package:the_movie_box/data/model/movie_model.dart';
import 'package:the_movie_box/main.dart';

class MovieRepository {
  MovieRepository();
  final apiClient = getIt<ApiClient>();
  Future<List<MovieResult>> getMovieResults({
    String? includeTags,
    String? excludeTags,
  }) async {
    try {
      List<MovieResult> movieMovieResultList = [];
      final res = await apiClient.get(APIEndPoint.trending);
      print(res.data);
      res.data['results']
          .map((e) => movieMovieResultList.add(MovieResult.fromJson(e)))
          .toList();
      return movieMovieResultList;
    } catch (e) {
      rethrow;
    }
  }
}
