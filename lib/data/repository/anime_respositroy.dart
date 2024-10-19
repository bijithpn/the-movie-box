import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:the_movie_box/core/client/api_client.dart';
import 'package:the_movie_box/core/client/graphql_client.dart';
import 'package:the_movie_box/data/model/anime_model.dart';
import 'package:the_movie_box/main.dart';

class AnimeRespositroy {
  final graphql = GraphqlAPIClient();
  Future<List<Animes>> fetchAnime({
    int page = 1,
  }) async {
    List<Animes> animeList = [];
    try {
      var query = """
{
  Page {
    media {
      id
      coverImage {
        large
      }
    }
  }
}
""";
      final res = await graphql.client.query(
        QueryOptions(
          document: gql(query),
        ),
      );

      print(jsonEncode(res.data?['Page']['media']));
      res.data?['Page']['media']
          .map((e) => animeList.add(Animes.fromJson(e)))
          .toList();
    } catch (e) {
      rethrow;
    }
    return animeList;
  }

  // Future<MovieDetails> fetchAnimeDetails(int movieID) async {
  //   try {
  //     var body = {"language": "en-US"};
  //     final res = await apiClient.get("${APIEndPoint.movieDetails}/$movieID",
  //         queryParameters: body);
  //     return MovieDetails.fromJson(res.data);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
