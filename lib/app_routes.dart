class AppRoutes {
  static const baseURL = 'http://192.168.1.14/sipevo';
  static String register = '$baseURL/register.php';

  static const complaints = '$baseURL/complaints';
  static String complaintsList = '$complaints/get_complaints.php';
  static String complaintsListMahasiswa =
      '$complaints/get_complaints_mahasiswa.php';
  static String addComplaintsMahasiswa =
      '$complaints/add_complaints_mahasiswa.php';

  static String updateStatusComplaints = '$complaints/update_status.php';
  static String deleteComplaints = '$complaints/delete_complaints.php';

  static const logs = '$baseURL/logs';
  static String logsList = '$logs/logs_manager.php';

  static const user = '$baseURL/user';
  static String listUser = '$user/get_users.php';
  static String addUser = '$user/add_user.php';
  static String updateUser = '$user/update_user.php';
  static String deleteUser = '$user/delete_user.php';

  static String profile = '$user/profile.php';
  static String updateProfile = '$user/update_profile.php';

  static String login = '$baseURL/login.php';
}
