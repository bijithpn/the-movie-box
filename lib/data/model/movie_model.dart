class Show {
  int id;
  double popularity;
  String posterPath;
  double voteAverage;

  Show({
    required this.id,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
  });

  factory Show.fromJson(Map<String, dynamic> json) => Show(
        id: json["id"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"] ?? "",
        voteAverage: json["vote_average"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "popularity": popularity,
        "poster_path": posterPath,
        "vote_average": voteAverage,
      };
}
