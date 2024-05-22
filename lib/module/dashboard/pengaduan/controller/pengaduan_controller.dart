import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core.dart';

import 'package:http/http.dart' as http;

class PengaduanController extends GetxController {
  PengaduanView? view;
  var pengaduanList = <Pengaduan>[].obs;
  var isLoading = true.obs;

  // REFRESH KONTEN
  void refreshPengaduan() async {
    fetchPengaduan();

    Get.snackbar(
      'Refreshed',
      'Data telah diperbarui🚀',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }

  @override
  void onInit() {
    super.onInit();
    fetchPengaduan();
  }

  Future<void> fetchPengaduan() async {
    final token = await SharedPrefsHelper.getToken();
    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse(AppRoutes.basePENGADUAN),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final data = responseData['data']['data'];

        pengaduanList.value = List<Pengaduan>.from(
          data.map((pengaduan) => Pengaduan.fromJson(pengaduan)),
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to fetch data: ${response.statusCode} 🤯',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Exception',
        'An error occurred: $e 🤯',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> logout() async {
    final token = await SharedPrefsHelper.getToken();

    try {
      final response = await http.post(
        Uri.parse(AppRoutes.logout),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['success'] == true) {
          await SharedPrefsHelper.removeToken();

          Get.snackbar(
            'Logout Successful',
            'You have been logged out🤩',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
          );

          Get.offAll(() => LoginView());
        } else {
          Get.snackbar(
            'Logout Failed',
            'Failed to log out. Please try again. 🤯',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
          );
        }
      } else {
        Get.snackbar(
          'Logout Failed',
          'Failed to log out. Please try again. 🤯',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred. Please try again. 🤯',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }
}
