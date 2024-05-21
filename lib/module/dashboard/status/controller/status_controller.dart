import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/PengaduanStatus.dart';
import '../view/status_view.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sipevo/core.dart';

class StatusController extends GetxController {
  StatusView? view;
  List<PengaduanStatus> statuses = [];

  // REFRESH KONTEN
  void refreshStatus() async {
    fetchStatuses();

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
    fetchStatuses();
  }

  void fetchStatuses() async {
    final token = await SharedPrefsHelper.getToken();
    try {
      final response = await http.get(
        Uri.parse(AppRoutes.status),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final data = responseData['data']['data'];

        statuses = List<PengaduanStatus>.from(
          data.map((status) => PengaduanStatus.fromJson(status)),
        );

        update();
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
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
