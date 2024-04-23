class Complaints {
  final String idComplaint;
  final String subject;
  final String description;
  final String status;
  final String idUser;
  final String createdAt;
  final String updatedAt;
  final String? updatedBy;
  final String? updatedByRole;

  Complaints({
    required this.idComplaint,
    required this.subject,
    required this.description,
    required this.status,
    required this.idUser,
    required this.createdAt,
    required this.updatedAt,
    this.updatedBy,
    this.updatedByRole,
  });

  factory Complaints.fromJson(Map<String, dynamic> json) {
    return Complaints(
      idComplaint: json['id_complaint'],
      subject: json['subject'],
      description: json['description'],
      status: json['status'],
      idUser: json['id_user'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      updatedBy: json['updated_by'],
      updatedByRole: json['updated_by_role'],
    );
  }
}
