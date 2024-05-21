class PengaduanStatus {
  int id;
  String name;
  String slug;
  DateTime createdAt;
  DateTime updatedAt;

  PengaduanStatus({
    required this.id,
    required this.name,
    required this.slug,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PengaduanStatus.fromJson(Map<String, dynamic> json) {
    return PengaduanStatus(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
