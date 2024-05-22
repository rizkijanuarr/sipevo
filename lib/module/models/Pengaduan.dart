import '../../core.dart';

class Pengaduan {
  int id;
  int userId;
  int pengaduanCategoryId;
  int pengaduanStatusId;
  dynamic usersIdentifiesId;
  String title;
  String description;
  String location;
  String image;
  String slug;
  DateTime createdAt;
  DateTime updatedAt;
  String? tanggapanDescription;
  String? tanggapanImage;
  int pengaduanCountsCount;
  User user;
  PengaduanCategory pengaduanCategory;
  PengaduanStatus pengaduanStatus;
  dynamic usersIdentifies;

  Pengaduan({
    required this.id,
    required this.userId,
    required this.pengaduanCategoryId,
    required this.pengaduanStatusId,
    this.usersIdentifiesId,
    required this.title,
    required this.description,
    required this.location,
    required this.image,
    required this.slug,
    required this.createdAt,
    required this.updatedAt,
    this.tanggapanDescription,
    this.tanggapanImage,
    required this.pengaduanCountsCount,
    required this.user,
    required this.pengaduanCategory,
    required this.pengaduanStatus,
    this.usersIdentifies,
  });

  factory Pengaduan.fromJson(Map<String, dynamic> json) {
    return Pengaduan(
      id: json['id'],
      userId: json['user_id'],
      pengaduanCategoryId: json['pengaduan_category_id'],
      pengaduanStatusId: json['pengaduan_status_id'],
      usersIdentifiesId: json['users_identifies_id'],
      title: json['title'],
      description: json['description'],
      location: json['location'],
      image: json['image'],
      slug: json['slug'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      tanggapanDescription: json['tanggapan_description'],
      tanggapanImage: json['tanggapan_image'],
      pengaduanCountsCount: json['pengaduan_counts_count'],
      user: User.fromJson(json['user']),
      pengaduanCategory: PengaduanCategory.fromJson(json['pengaduan_category']),
      pengaduanStatus: PengaduanStatus.fromJson(json['pengaduan_status']),
      usersIdentifies: json['users_identifies'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'pengaduan_category_id': pengaduanCategoryId,
      'pengaduan_status_id': pengaduanStatusId,
      'users_identifies_id': usersIdentifiesId,
      'title': title,
      'description': description,
      'location': location,
      'image': image,
      'slug': slug,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'tanggapan_description': tanggapanDescription,
      'tanggapan_image': tanggapanImage,
      'pengaduan_counts_count': pengaduanCountsCount,
      'user': user.toJson(),
      'pengaduan_category': pengaduanCategory.toJson(),
      'pengaduan_status': pengaduanStatus.toJson(),
      'users_identifies': usersIdentifies,
    };
  }
}
