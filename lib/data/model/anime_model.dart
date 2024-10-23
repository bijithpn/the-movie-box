class Anime {
  String id;
  String malId;
  String english;
  AnimePoster poster;

  Anime({
    required this.id,
    required this.malId,
    required this.english,
    required this.poster,
  });

  factory Anime.fromJson(Map<String, dynamic> json) => Anime(
        id: json["id"] ?? "",
        malId: json["malId"] ?? "",
        english: json["english"] ?? "",
        poster: AnimePoster.fromJson(json["poster"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "malId": malId,
        "english": english,
        "poster": poster.toJson(),
      };
}

class AnimePoster {
  String originalUrl;
  String mainUrl;

  AnimePoster({
    required this.originalUrl,
    required this.mainUrl,
  });

  factory AnimePoster.fromJson(Map<String, dynamic> json) => AnimePoster(
        originalUrl: json["originalUrl"] ?? "",
        mainUrl: json["mainUrl"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "originalUrl": originalUrl,
        "mainUrl": mainUrl,
      };
}
