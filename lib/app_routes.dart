class AppRoutes {
  static const baseURL = 'https://5b7c-180-241-4-166.ngrok-free.app/api';

  // AUTH
  static String login = '$baseURL/login';
  static String register = '$baseURL/register';
  static String logout = '$baseURL/logout';

  // PENGADUAN
  static const basePENGADUAN = '$baseURL/pengaduan';
  static String categories = '$basePENGADUAN/categories';
  static String status = '$basePENGADUAN/status';
}
