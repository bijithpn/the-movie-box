import 'package:the_movie_box/data/model/movie_model.dart';

class Collection {
  int id;
  String name;
  String overview;
  String posterPath;
  String backdropPath;
  List<Show> shows;

  Collection({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.shows,
  });

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        id: json["id"],
        name: json["name"] ?? "",
        overview: json["overview"] ?? "",
        posterPath: json["poster_path"] ?? "",
        backdropPath: json["backdrop_path"] ?? "",
        shows: List<Show>.from(json["parts"].map((x) => Show.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "overview": overview,
        "poster_path": posterPath,
        "backdrop_path": backdropPath,
        "parts": List<dynamic>.from(shows.map((x) => x.toJson())),
      };
}
