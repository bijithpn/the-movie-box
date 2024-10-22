// To parse this JSON data, do
//
//     final externalIds = externalIdsFromJson(jsonString);

import 'dart:convert';

ExternalIds externalIdsFromJson(String str) =>
    ExternalIds.fromJson(json.decode(str));

String externalIdsToJson(ExternalIds data) => json.encode(data.toJson());

class ExternalIds {
  String imdbId;
  String wikidataId;
  String facebookId;
  String instagramId;
  String twitterId;

  ExternalIds({
    required this.imdbId,
    required this.wikidataId,
    required this.facebookId,
    required this.instagramId,
    required this.twitterId,
  });

  factory ExternalIds.fromJson(Map<String, dynamic> json) => ExternalIds(
        imdbId: json["imdb_id"] ?? "",
        wikidataId: json["wikidata_id"] ?? "",
        facebookId: json["facebook_id"] ?? "",
        instagramId: json["instagram_id"] ?? "",
        twitterId: json["twitter_id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "imdb_id": imdbId,
        "wikidata_id": wikidataId,
        "facebook_id": facebookId,
        "instagram_id": instagramId,
        "twitter_id": twitterId,
      };
}
