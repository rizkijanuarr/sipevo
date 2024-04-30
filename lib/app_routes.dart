class AppRoutes {
  static const baseURL = 'https://sipevo.my.id/public/api';

  // AUTH
  static const baseAUTH = '$baseURL/auth';
  static String login = '$baseAUTH/login.php';
  static String register = '$baseAUTH/register.php';

  // USER
  static const baseUSER = '$baseURL/user';
  static String getUser = '$baseUSER/get.php';
  static String addUser = '$baseUSER/add.php';
  static String updateUser = '$baseUSER/update.php';
  static String deleteUser = '$baseUSER/delete.php';

  // PROFIL
  static String profile = '$baseUSER/profile.php';
  static String updateProfile = '$baseUSER/update_profile.php';

  // COMPLAINTS
  static const baseCOMPLAINTS = '$baseURL/complaints';
  static String getComplaints = '$baseCOMPLAINTS/get.php';
  static String addComplaints = '$baseCOMPLAINTS/add.php';
  static String updateComplaints = '$baseCOMPLAINTS/update.php';
  static String deleteComplaints = '$baseCOMPLAINTS/delete.php';

  // COMPLAINTS MAHASISWA
  static const baseCOMPLAINTSMAHASISWA = '$baseCOMPLAINTS/mahasiswa';
  static String getComplaintsMahasiswa = '$baseCOMPLAINTSMAHASISWA/get.php';
  static String addComplaintsMahasiswa = '$baseCOMPLAINTSMAHASISWA/add.php';

  // LOGS SYSTEM
  static const baseLOGS = '$baseURL/logs';
  static String getLogs = '$baseLOGS/logs_manager.php';
}
