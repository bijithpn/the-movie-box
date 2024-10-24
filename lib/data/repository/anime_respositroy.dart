import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:the_movie_box/core/client/graphql_client.dart';

import '../model/model.dart';

class AnimeRepository {
  final graphql = GraphqlAPIClient();
  Future<List<Anime>> fetchAnime({
    int page = 1,
    int limit = 30,
  }) async {
    List<Anime> animeList = [];
    try {
      var query = """
      {
        animes(limit: $limit, page:$page) {
          id
          malId
          english
          poster {
            originalUrl
            mainUrl
          }
        }
      }
      """;
      final res = await graphql.client.query(
        QueryOptions(
          document: gql(query),
        ),
      );
      res.data?['animes'].map((e) => animeList.add(Anime.fromJson(e))).toList();
    } catch (e) {
      rethrow;
    }
    return animeList;
  }

  Future<AnimeDetails> fetchAnimeDetails(String animeId) async {
    try {
      var query = """
      {
        animes(ids:"$animeId" ,limit: 1,){
    id
    malId
    english
    japanese
    synonyms
    kind
    rating
    score
    status
    episodes
    episodesAired
    duration
    releasedOn {
      year
    }
    url
    poster {
      originalUrl
      mainUrl
    }
    genres {
      id
      name
    }
    studios {
      id
      name
    }

    externalLinks {
      id
      kind
      url
      createdAt
      updatedAt
    }

    personRoles {
      id
      rolesEn
      person {
        id
        name
        poster {
          mainUrl
          originalUrl
        }
      }
    }
    characterRoles {
      id
      rolesEn
      character {
        id
        name
        poster {
          mainUrl
          originalUrl
        }
      }
    }

    related {
      id
      anime {
        id
        name
        poster {
          mainUrl
          originalUrl
          
        }
      }
    }

    videos {
      id
      url
      name
      kind
      playerUrl
      imageUrl
    }
    screenshots {
      id
      originalUrl
      x166Url
      x332Url
    }

    scoresStats {
      score
      count
    }
    statusesStats {
      status
      count
    }
    description
  }
}
      """;
      final res = await graphql.client.query(
        QueryOptions(
          document: gql(query),
        ),
      );
      return AnimeDetails.fromJson(res.data?['animes'][0]);
    } catch (e) {
      rethrow;
    }
  }
}
