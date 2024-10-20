import 'dart:convert';

class Cast {
  int id;
  String knownForDepartment;
  String name;
  String originalName;
  String profilePath;
  String character;

  Cast({
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.profilePath,
    required this.character,
  });

  Cast copyWith({
    int? id,
    String? knownForDepartment,
    String? name,
    String? originalName,
    String? profilePath,
    String? character,
  }) {
    return Cast(
      id: id ?? this.id,
      knownForDepartment: knownForDepartment ?? this.knownForDepartment,
      name: name ?? this.name,
      originalName: originalName ?? this.originalName,
      profilePath: profilePath ?? this.profilePath,
      character: character ?? this.character,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'known_for_department': knownForDepartment,
      'name': name,
      'original_name': originalName,
      'profile_path': profilePath,
      'character': character,
    };
  }

  factory Cast.fromJson(Map<String, dynamic> map) {
    return Cast(
      id: map['id']?.toInt() ?? 0,
      knownForDepartment: map['known_for_department'] ?? '',
      name: map['name'] ?? '',
      originalName: map['original_name'] ?? '',
      profilePath: map['profile_path'] ?? '',
      character: map['character'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Cast(id: $id, knownForDepartment: $knownForDepartment, name: $name, originalName: $originalName, profilePath: $profilePath, character: $character)';
  }
}

class Crew {
  int id;
  String profilePath;
  String knownForDepartment;
  String name;
  String department;
  String job;
  Crew({
    required this.id,
    required this.profilePath,
    required this.knownForDepartment,
    required this.name,
    required this.department,
    required this.job,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'profilePath': profilePath,
      'knownForDepartment': knownForDepartment,
      'name': name,
      'department': department,
      'job': job,
    };
  }

  factory Crew.fromJson(Map<String, dynamic> map) {
    return Crew(
      id: map['id']?.toInt() ?? 0,
      profilePath: map['profile_path'] ?? "",
      knownForDepartment: map['known_for_department'] ?? '',
      name: map['name'] ?? '',
      department: map['department'] ?? '',
      job: map['job'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());
}
