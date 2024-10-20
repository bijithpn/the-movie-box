// To parse this JSON data, do
//
//     final seriesEpisodes = seriesEpisodesFromJson(jsonString);

import 'dart:convert';

SeriesEpisodes seriesEpisodesFromJson(String str) =>
    SeriesEpisodes.fromJson(json.decode(str));

String seriesEpisodesToJson(SeriesEpisodes data) => json.encode(data.toJson());

class SeriesEpisodes {
  String id;
  DateTime airDate;
  List<Episode> episodes;
  String name;
  String overview;
  int seriesEpisodesId;
  String posterPath;
  int seasonNumber;
  double voteAverage;

  SeriesEpisodes({
    required this.id,
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.seriesEpisodesId,
    required this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });

  factory SeriesEpisodes.fromJson(Map<String, dynamic> json) => SeriesEpisodes(
        id: json["_id"],
        airDate: DateTime.parse(json["air_date"]),
        episodes: List<Episode>.from(
            json["episodes"].map((x) => Episode.fromJson(x))),
        name: json["name"],
        overview: json["overview"],
        seriesEpisodesId: json["id"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
        voteAverage: json["vote_average"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "air_date":
            "${airDate.year.toString().padLeft(4, '0')}-${airDate.month.toString().padLeft(2, '0')}-${airDate.day.toString().padLeft(2, '0')}",
        "episodes": List<dynamic>.from(episodes.map((x) => x.toJson())),
        "name": name,
        "overview": overview,
        "id": seriesEpisodesId,
        "poster_path": posterPath,
        "season_number": seasonNumber,
        "vote_average": voteAverage,
      };
}

class Episode {
  DateTime airDate;
  int episodeNumber;
  String episodeType;
  int id;
  String name;
  String overview;
  int runtime;
  int seasonNumber;
  String stillPath;
  double voteAverage;
  int? showId;

  Episode({
    required this.airDate,
    required this.episodeNumber,
    required this.episodeType,
    required this.id,
    required this.name,
    required this.overview,
    required this.runtime,
    required this.seasonNumber,
    required this.stillPath,
    required this.voteAverage,
    this.showId,
  });

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
        airDate: DateTime.parse(json["air_date"]),
        episodeNumber: json["episode_number"],
        episodeType: json["episode_type"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        runtime: json["runtime"],
        seasonNumber: json["season_number"],
        stillPath: json["still_path"],
        voteAverage: json["vote_average"]?.toDouble(),
        showId: json["show_id"],
      );

  Map<String, dynamic> toJson() => {
        "air_date":
            "${airDate.year.toString().padLeft(4, '0')}-${airDate.month.toString().padLeft(2, '0')}-${airDate.day.toString().padLeft(2, '0')}",
        "episode_number": episodeNumber,
        "episode_type": episodeType,
        "id": id,
        "name": name,
        "overview": overview,
        "runtime": runtime,
        "season_number": seasonNumber,
        "still_path": stillPath,
        "vote_average": voteAverage,
        "show_id": showId,
      };
}
