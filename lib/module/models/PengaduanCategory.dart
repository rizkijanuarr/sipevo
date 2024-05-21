class PengaduanCategory {
  int id;
  String image;
  String name;
  String slug;
  DateTime createdAt;
  DateTime updatedAt;

  PengaduanCategory({
    required this.id,
    required this.image,
    required this.name,
    required this.slug,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PengaduanCategory.fromJson(Map<String, dynamic> json) {
    return PengaduanCategory(
      id: json['id'],
      image: json['image'],
      name: json['name'],
      slug: json['slug'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'slug': slug,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
