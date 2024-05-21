class User {
  int id;
  dynamic usersIdentifiesId;
  String name;
  String noInduk;
  String noHp;
  String email;
  dynamic emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;

  User({
    required this.id,
    this.usersIdentifiesId,
    required this.name,
    required this.noInduk,
    required this.noHp,
    required this.email,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      usersIdentifiesId: json['users_identifies_id'],
      name: json['name'],
      noInduk: json['no_induk'],
      noHp: json['no_hp'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'users_identifies_id': usersIdentifiesId,
      'name': name,
      'no_induk': noInduk,
      'no_hp': noHp,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
