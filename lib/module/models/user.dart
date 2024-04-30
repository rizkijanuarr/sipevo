class User {
  final int? id;
  final String name;
  final String nohp;
  final String role;
  final String photo;
  final String mahasiswa_angkatan;
  final String prodi;

  User({
    this.id,
    required this.name,
    required this.nohp,
    required this.role,
    required this.photo,
    required this.mahasiswa_angkatan,
    required this.prodi,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    print('Parsing user: ${json['name']}');
    return User(
      id: json['id_user'] != null
          ? (json['id_user'] is String
              ? int.tryParse(json['id_user'])
              : json['id_user'])
          : null,
      name: json['name'] ?? '',
      nohp: json['nohp'] ?? '',
      role: json['role'] ?? '',
      photo: json['photo'] ?? '',
      mahasiswa_angkatan: json['mahasiswa_angkatan'] ?? '',
      prodi: json['prodi'] ?? '',
    );
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, nohp: $nohp,  role: $role, photo: $photo, mahasiswa_angkatan: $mahasiswa_angkatan, prodi: $prodi}';
  }
}
