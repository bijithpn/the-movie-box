class Animes {
  int id;
  CoverImage coverImage;

  Animes({
    required this.id,
    required this.coverImage,
  });

  factory Animes.fromJson(Map<String, dynamic> json) => Animes(
        id: json["id"],
        coverImage: CoverImage.fromJson(json["coverImage"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "coverImage": coverImage.toJson(),
      };
}

class CoverImage {
  String large;

  CoverImage({
    required this.large,
  });

  factory CoverImage.fromJson(Map<String, dynamic> json) => CoverImage(
        large: json["large"],
      );

  Map<String, dynamic> toJson() => {
        "large": large,
      };
}
