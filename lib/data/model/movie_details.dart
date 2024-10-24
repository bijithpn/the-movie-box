import 'dart:convert';

MovieDetails movieDetailsFromJson(String str) =>
    MovieDetails.fromJson(json.decode(str));

String movieDetailsToJson(MovieDetails data) => json.encode(data.toJson());

class MovieDetails {
  bool adult;
  String backdropPath;
  BelongsToCollection? belongsToCollection;
  List<Genre> genres;
  int id;
  String imdbId;
  String overview;
  double popularity;
  String posterPath;
  List<ProductionCompany> productionCompanies;
  DateTime? releaseDate;
  int runtime;
  String tagline;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  MovieDetails({
    required this.adult,
    required this.backdropPath,
    required this.genres,
    required this.id,
    this.belongsToCollection,
    required this.imdbId,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.releaseDate,
    required this.runtime,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) => MovieDetails(
        adult: json["adult"] ?? false,
        backdropPath: json["backdrop_path"] ?? "",
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
        id: json["id"],
        imdbId: json["imdb_id"] ?? "",
        belongsToCollection: json["belongs_to_collection"] == null
            ? null
            : BelongsToCollection.fromJson(json["belongs_to_collection"]),
        overview: json["overview"] ?? "",
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"] ?? "",
        productionCompanies: List<ProductionCompany>.from(
            json["production_companies"]
                .map((x) => ProductionCompany.fromJson(x))),
        releaseDate: json["release_date"] == null
            ? DateTime.now()
            : DateTime.tryParse(json["release_date"]),
        runtime: json["runtime"] ?? 0,
        tagline: json["tagline"] ?? "",
        title: json["title"] ?? "",
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "id": id,
        "imdb_id": imdbId,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "belongs_to_collection": belongsToCollection?.toJson(),
        "production_companies":
            List<dynamic>.from(productionCompanies.map((x) => x.toJson())),
        "release_date":
            "${releaseDate?.year.toString().padLeft(4, '0')}-${releaseDate?.month.toString().padLeft(2, '0')}-${releaseDate?.day.toString().padLeft(2, '0')}",
        "runtime": runtime,
        "tagline": tagline,
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}

class Genre {
  int id;
  String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class ProductionCompany {
  int id;
  String logoPath;
  String name;
  String originCountry;

  ProductionCompany({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
      ProductionCompany(
        id: json["id"],
        logoPath: json["logo_path"] ?? "",
        name: json["name"] ?? "",
        originCountry: json["origin_country"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "logo_path": logoPath,
        "name": name,
        "origin_country": originCountry,
      };
}

class BelongsToCollection {
  int id;

  BelongsToCollection({
    required this.id,
  });

  factory BelongsToCollection.fromJson(Map<String, dynamic> json) =>
      BelongsToCollection(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
