import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/PengaduanCategory.dart';
import '../view/categories_view.dart';
import 'package:sipevo/core.dart';
import 'package:http/http.dart' as http;

class CategoriesController extends GetxController {
  CategoriesView? view;
  List<PengaduanCategory> categories = [];

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  // REFRESH KONTEN
  void refreshCategories() async {
    fetchCategories();

    Get.snackbar(
      'Refreshed',
      'Data telah diperbarui🚀',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

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

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
