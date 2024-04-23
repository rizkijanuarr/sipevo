import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sipevo/app_routes.dart';
import 'package:sipevo/module/models/logs.dart';
import 'package:sipevo/shared_prefs_helper.dart';
import '../view/logs_view.dart';
import 'package:http/http.dart' as http;

class LogsController extends GetxController {
  LogsView? view;

  /// untuk memperbarui tampilan
  /// / Tambahkan metode ini dalam UserController
  void refreshLogs() async {
    fetchLogs(); // Memuat ulang data pengguna dari server
    update(); // Memperbarui UI

    // Menampilkan Snackbar
    Get.snackbar(
      'Refreshed', // Judul Snackbar
      'Data telah diperbarui🚀', // Pesan Snackbar
      snackPosition: SnackPosition.BOTTOM, // Posisi Snackbar
      backgroundColor: Colors.blue, // Warna latar belakang Snackbar
      colorText: Colors.white, // Warna teks Snackbar
      duration: const Duration(seconds: 5), // Durasi tampilan Snackbar
    );
  }

  var logs = <Log>[].obs;

  @override
  void onInit() {
    fetchLogs();
    super.onInit();
  }

  void fetchLogs() async {
    String? token = await SharedPrefsHelper.getToken();
    final response = await http.get(
      Uri.parse(AppRoutes.logsList),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json', // Pastikan ini diperlukan oleh API
      },
    );
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var logsJson = jsonData['logs'] as List;
      logs.value = logsJson.map((logJson) => Log.fromJson(logJson)).toList();
    } else {
      // Handle error
    }
  }
}
