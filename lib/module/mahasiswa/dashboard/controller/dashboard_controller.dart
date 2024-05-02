import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../view/dashboard_view.dart';

class DashboardController extends GetxController {
  DashboardView? view;

  var userRole = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserRoleFromPrefs();
  }

  void fetchUserRoleFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final String? role = prefs.getString(
        'userRole');

    if (role != null) {
      userRole.value = role;
    }
  }

  // KEBUTUHAN CAROUSEL
  int currentIndex = 0;
  final CarouselController carouselController = CarouselController();
}
