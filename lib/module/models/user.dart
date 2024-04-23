class User {
  final int? id; // Make id nullable if json['id_user'] can be null
  final String name;
  final String nohp;
  final String email;
  final String role;
  final String photo;
  final String address;

  User({
    this.id, // Remove required if id can be null
    required this.name,
    required this.nohp,
    required this.email,
    required this.role,
    required this.photo,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    print('Parsing user: ${json['name']}');
    return User(
      id: json['id_user'] != null
          ? (json['id_user'] is String
              ? int.tryParse(json['id_user'])
              : json['id_user'])
          : null, // Safely handle null and type conversion
      name: json['name'] ??
          '', // Provide default values for non-nullable fields if necessary
      nohp: json['nohp'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      photo: json['photo'] ?? '',
      address: json['address'] ?? '',
    );
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, nohp: $nohp, email: $email, role: $role, photo: $photo, address: $address}';
  }
}
