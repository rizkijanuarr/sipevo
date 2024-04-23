class Log {
  final String idLog;
  final String logDescription;
  final String idUser;
  final String name;
  final String timestamp;

  Log({
    required this.idLog,
    required this.logDescription,
    required this.idUser,
    required this.name,
    required this.timestamp,
  });

  factory Log.fromJson(Map<String, dynamic> json) {
    return Log(
      idLog: json['id_log'],
      logDescription: json['log_description'],
      idUser: json['id_user'],
      name: json['name'],
      timestamp: json['timestamp'],
    );
  }
}
