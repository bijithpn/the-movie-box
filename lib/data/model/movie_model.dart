class Show {
  int id;
  String posterPath;

  Show({
    required this.id,
    required this.posterPath,
  });

  factory Show.fromJson(Map<String, dynamic> json) => Show(
        id: json["id"],
        posterPath: json["poster_path"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "poster_path": posterPath,
      };
}
