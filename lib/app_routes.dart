class AppRoutes {
  static const baseURL =
      'https://e07f-2001-448a-5021-2ff3-f56e-4232-9450-3bcc.ngrok-free.app/api';

  // AUTH
  static String login = '$baseURL/login';
  static String register = '$baseURL/register'; // FOKUS DISINI YA CATAT!
  static String logout = '$baseURL/logout';

  // PENGADUAN
  static const basePENGADUAN = '$baseURL/pengaduan';
  static String categories = '$basePENGADUAN/categories';
  static String status = '$basePENGADUAN/status';
}
