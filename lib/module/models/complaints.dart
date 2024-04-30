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
  final String? photoComplaints; // New field for photo URL
  final String? location;

  Complaints({
    required this.idComplaint,
    required this.subject,
    required this.description,
    required this.status,
    required this.idUser,
    required this.createdAt,
    required this.updatedAt,
    required this.location,
    this.updatedBy,
    this.updatedByRole,
    this.photoComplaints, // Initialize in constructor
  });

  factory Complaints.fromJson(Map<String, dynamic> json) {
    return Complaints(
      idComplaint: json['id_complaint'].toString(),
      subject: json['subject'],
      description: json['description'],
      status: json['status'],
      idUser: json['id_user'].toString(),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      updatedBy: json['updated_by'].toString(),
      updatedByRole: json['updated_by_role'],
      photoComplaints: json['photo_complaints'],
      location: json['location'],
    );
  }
}
