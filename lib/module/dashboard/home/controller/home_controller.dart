import 'dart:convert';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';
import '../../../../app_routes.dart';
import '../../../../shared_prefs_helper.dart';
import '../../../models/PengaduanCategory.dart';
import '../view/home_view.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  HomeView? view;
  List<PengaduanCategory> categories = [];

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // int selectedIndex = 0;
  // updateIndex(int newIndex) {
  //   selectedIndex = newIndex;
  //   update();
  // }

  int currentIndex = 0;
  final CarouselController carouselController = CarouselController();

  void fetchCategories() async {
    final token = await SharedPrefsHelper.getToken();
    try {
      final response = await http.get(
        Uri.parse(AppRoutes.categories),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final List<dynamic> categoryData = responseData['data']['data'];

        categories = categoryData
            .map((category) => PengaduanCategory.fromJson(category))
            .toList();

        update();
      } else {
        print('Failed to load categories');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }
}
