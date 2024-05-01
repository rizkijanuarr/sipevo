class Log {
  final String idLog;
  final String logDescription;
  final String idUser;
  final String name;
  final String? photo;
  final String timestamp;

  Log({
    required this.idLog,
    required this.logDescription,
    required this.idUser,
    required this.name,
    required this.photo,
    required this.timestamp,
  });

  factory Log.fromJson(Map<String, dynamic> json) {
    return Log(
      idLog: json['id_log'].toString(),
      logDescription: json['log_description'].toString(),
      idUser: json['id_user'].toString(),
      name: json['name'].toString(),
      photo: json['photo'] ?? '',
      timestamp: json['timestamp'].toString(),
    );
  }
}
