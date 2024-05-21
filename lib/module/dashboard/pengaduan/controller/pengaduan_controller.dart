import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app_routes.dart';
import '../../../../shared_prefs_helper.dart';
import '../../../models/Pengaduan.dart';
import '../view/pengaduan_view.dart';

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
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
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
        Get.snackbar('Error', 'Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Exception', 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }
}
