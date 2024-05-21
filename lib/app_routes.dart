class AppRoutes {
  static const baseURL = 'https://f9bd-103-189-201-221.ngrok-free.app/api';

  // AUTH
  static String login = '$baseURL/login';
  static String register = '$baseURL/register'; // FOKUS DISINI YA CATAT!
  static String logout = '$baseURL/logout';

  // PENGADUAN
  static const basePENGADUAN =
      '$baseURL/pengaduan';
  static String categories = '$basePENGADUAN/categories';
  static String status = '$basePENGADUAN/status';
}
