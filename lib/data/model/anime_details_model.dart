import 'anime_model.dart';

class AnimeDetails {
  String id;
  String malId;
  String english;
  String japanese;
  List<String> synonyms;
  String kind;
  String rating;
  double score;
  String status;
  int episodes;
  int episodesAired;
  int duration;
  ReleasedOn releasedOn;
  String url;
  AnimePoster poster;
  List<AnimeGenre> genres;
  List<AnimeGenre> studios;
  List<ExternalLink> externalLinks;
  List<PersonRole> personRoles;
  List<CharacterRole> characterRoles;
  List<RelatedAnime> related;
  List<Video> videos;
  List<Screenshot> screenshots;
  List<ScoresStat> scoresStats;
  List<StatusesStat> statusesStats;
  String description;

  AnimeDetails({
    required this.id,
    required this.malId,
    required this.english,
    required this.japanese,
    required this.synonyms,
    required this.kind,
    required this.rating,
    required this.score,
    required this.status,
    required this.episodes,
    required this.episodesAired,
    required this.duration,
    required this.releasedOn,
    required this.url,
    required this.poster,
    required this.genres,
    required this.studios,
    required this.externalLinks,
    required this.personRoles,
    required this.characterRoles,
    required this.related,
    required this.videos,
    required this.screenshots,
    required this.scoresStats,
    required this.statusesStats,
    required this.description,
  });

  factory AnimeDetails.fromJson(Map<String, dynamic> json) => AnimeDetails(
        id: json["id"] ?? "",
        malId: json["malId"] ?? "",
        english: json["english"] ?? "",
        japanese: json["japanese"] ?? "",
        synonyms: List<String>.from(json["synonyms"].map((x) => x)),
        kind: json["kind"] ?? "",
        rating: json["rating"] ?? "",
        score: json["score"]?.toDouble(),
        status: json["status"] ?? "",
        episodes: json["episodes"] ?? 0,
        episodesAired: json["episodesAired"] ?? 0,
        duration: json["duration"] ?? 0,
        releasedOn: ReleasedOn.fromJson(json["releasedOn"]),
        url: json["url"] ?? "",
        poster: AnimePoster.fromJson(json["poster"]),
        genres: List<AnimeGenre>.from(
            json["genres"].map((x) => AnimeGenre.fromJson(x))),
        studios: List<AnimeGenre>.from(
            json["studios"].map((x) => AnimeGenre.fromJson(x))),
        externalLinks: List<ExternalLink>.from(
            json["externalLinks"].map((x) => ExternalLink.fromJson(x))),
        personRoles: List<PersonRole>.from(
            json["personRoles"].map((x) => PersonRole.fromJson(x))),
        characterRoles: List<CharacterRole>.from(
            json["characterRoles"].map((x) => CharacterRole.fromJson(x))),
        related: List<RelatedAnime>.from(
            json["related"].map((x) => RelatedAnime.fromJson(x))),
        videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
        screenshots: List<Screenshot>.from(
            json["screenshots"].map((x) => Screenshot.fromJson(x))),
        scoresStats: List<ScoresStat>.from(
            json["scoresStats"].map((x) => ScoresStat.fromJson(x))),
        statusesStats: List<StatusesStat>.from(
            json["statusesStats"].map((x) => StatusesStat.fromJson(x))),
        description: json["description"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "malId": malId,
        "english": english,
        "japanese": japanese,
        "synonyms": List<dynamic>.from(synonyms.map((x) => x)),
        "kind": kind,
        "rating": rating,
        "score": score,
        "status": status,
        "episodes": episodes,
        "episodesAired": episodesAired,
        "duration": duration,
        "releasedOn": releasedOn.toJson(),
        "url": url,
        "poster": poster.toJson(),
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "studios": List<dynamic>.from(studios.map((x) => x.toJson())),
        "externalLinks":
            List<dynamic>.from(externalLinks.map((x) => x.toJson())),
        "personRoles": List<dynamic>.from(personRoles.map((x) => x.toJson())),
        "characterRoles":
            List<dynamic>.from(characterRoles.map((x) => x.toJson())),
        "related": List<dynamic>.from(related.map((x) => x.toJson())),
        "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
        "screenshots": List<dynamic>.from(screenshots.map((x) => x.toJson())),
        "scoresStats": List<dynamic>.from(scoresStats.map((x) => x.toJson())),
        "statusesStats":
            List<dynamic>.from(statusesStats.map((x) => x.toJson())),
        "description": description,
      };
}

class CharacterRole {
  String id;
  List<String> rolesEn;
  Character character;

  CharacterRole({
    required this.id,
    required this.rolesEn,
    required this.character,
  });

  factory CharacterRole.fromJson(Map<String, dynamic> json) => CharacterRole(
        id: json["id"],
        rolesEn: List<String>.from(json["rolesEn"].map((x) => x)),
        character: Character.fromJson(json["character"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rolesEn": List<dynamic>.from(rolesEn.map((x) => x)),
        "character": character.toJson(),
      };
}

class Character {
  String id;
  String name;
  AnimePoster? poster;

  Character({
    required this.id,
    required this.name,
    required this.poster,
  });

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        poster: json["poster"] == null
            ? null
            : AnimePoster.fromJson(json["poster"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "poster": poster?.toJson(),
      };
}

class ExternalLink {
  String kind;
  String url;

  ExternalLink({
    required this.kind,
    required this.url,
  });

  factory ExternalLink.fromJson(Map<String, dynamic> json) => ExternalLink(
        kind: json["kind"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "url": url,
      };
}

class AnimeGenre {
  String id;
  String name;

  AnimeGenre({
    required this.id,
    required this.name,
  });

  factory AnimeGenre.fromJson(Map<String, dynamic> json) => AnimeGenre(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class RelatedAnime {
  String id;
  AnimeClass? anime;

  RelatedAnime({
    required this.id,
    this.anime,
  });

  factory RelatedAnime.fromJson(Map<String, dynamic> json) => RelatedAnime(
        id: json["id"],
        anime:
            json["anime"] == null ? null : AnimeClass.fromJson(json["anime"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "anime": anime?.toJson(),
      };
}

class AnimeClass {
  String id;
  String name;
  AnimePoster poster;

  AnimeClass({
    required this.id,
    required this.name,
    required this.poster,
  });

  factory AnimeClass.fromJson(Map<String, dynamic> json) => AnimeClass(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        poster: AnimePoster.fromJson(json["poster"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "poster": poster.toJson(),
      };
}

class PersonRole {
  String id;
  List<String> rolesEn;
  Character person;

  PersonRole({
    required this.id,
    required this.rolesEn,
    required this.person,
  });

  factory PersonRole.fromJson(Map<String, dynamic> json) => PersonRole(
        id: json["id"],
        rolesEn: List<String>.from(json["rolesEn"].map((x) => x)),
        person: Character.fromJson(json["person"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rolesEn": List<dynamic>.from(rolesEn.map((x) => x)),
        "person": person.toJson(),
      };
}

class ReleasedOn {
  int year;

  ReleasedOn({
    required this.year,
  });

  factory ReleasedOn.fromJson(Map<String, dynamic> json) => ReleasedOn(
        year: json["year"] ?? DateTime.now().year,
      );

  Map<String, dynamic> toJson() => {
        "year": year,
      };
}

class ScoresStat {
  int score;
  int count;

  ScoresStat({
    required this.score,
    required this.count,
  });

  factory ScoresStat.fromJson(Map<String, dynamic> json) => ScoresStat(
        score: json["score"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "score": score,
        "count": count,
      };
}

class Screenshot {
  String id;
  String originalUrl;
  String x166Url;
  String x332Url;

  Screenshot({
    required this.id,
    required this.originalUrl,
    required this.x166Url,
    required this.x332Url,
  });

  factory Screenshot.fromJson(Map<String, dynamic> json) => Screenshot(
        id: json["id"],
        originalUrl: json["originalUrl"],
        x166Url: json["x166Url"],
        x332Url: json["x332Url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "originalUrl": originalUrl,
        "x166Url": x166Url,
        "x332Url": x332Url,
      };
}

class StatusesStat {
  String status;
  int count;

  StatusesStat({
    required this.status,
    required this.count,
  });

  factory StatusesStat.fromJson(Map<String, dynamic> json) => StatusesStat(
        status: json["status"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "count": count,
      };
}

class Video {
  String id;
  String url;
  String name;
  String kind;
  String playerUrl;
  String imageUrl;

  Video({
    required this.id,
    required this.url,
    required this.name,
    required this.kind,
    required this.playerUrl,
    required this.imageUrl,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"],
        url: json["url"],
        name: json["name"],
        kind: json["kind"],
        playerUrl: json["playerUrl"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "name": name,
        "kind": kind,
        "playerUrl": playerUrl,
        "imageUrl": imageUrl,
      };
}
