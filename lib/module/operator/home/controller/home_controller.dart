import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../view/home_view.dart';

class HomeController extends GetxController {
  HomeView? view;

  var userRole = ''.obs; // Membuat userRole sebagai observable

  @override
  void onInit() {
    super.onInit();
    fetchUserRoleFromPrefs();
  }

  void fetchUserRoleFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final String? role = prefs.getString(
        'userRole'); // Pastikan kunci ini sesuai dengan yang Anda gunakan saat menyimpan

    if (role != null) {
      userRole.value = role; // Memperbarui nilai userRole
    }
  }

  // carousel
  int currentIndex = 0;
  final CarouselController carouselController = CarouselController();
}
