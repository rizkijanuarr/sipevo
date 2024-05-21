class PengaduanCreate {
  final int id;
  final int userId;
  final int pengaduanCategoryId;
  final int pengaduanStatusId;
  final String title;
  final String description;
  final String location;
  final String image;
  final String slug;
  final String createdAt;
  final String updatedAt;

  PengaduanCreate({
    required this.id,
    required this.userId,
    required this.pengaduanCategoryId,
    required this.pengaduanStatusId,
    required this.title,
    required this.description,
    required this.location,
    required this.image,
    required this.slug,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PengaduanCreate.fromJson(Map<String, dynamic> json) {
    return PengaduanCreate(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      pengaduanCategoryId: json['pengaduan_category_id'] ?? 0,
      pengaduanStatusId: json['pengaduan_status_id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      location: json['location'] ?? '',
      image: json['image'] ?? '',
      slug: json['slug'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
