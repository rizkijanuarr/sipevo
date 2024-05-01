import 'dart:convert';

import 'package:get/get.dart';
import 'package:sipevo/app_routes.dart';
import 'package:sipevo/module/models/logs.dart';
import 'package:sipevo/shared_prefs_helper.dart';
import '../view/logs_system_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LogsSystemController extends GetxController {
  LogsSystemView? view;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    fetchLogs();
    super.onInit();
  }

  // REFRESH KONTEN
  void refreshLogs() async {
    fetchLogs();

    Get.snackbar(
      'Refreshed',
      'Data telah diperbarui🚀',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      duration: const Duration(seconds: 5),
    );
  }

  // HALAMAN LOGS
  int total_logs = 0;
  var logs = <Log>[].obs;

  void fetchLogs() async {
    String? token = await SharedPrefsHelper.getToken();
    final response = await http.get(
      Uri.parse(AppRoutes.getLogs),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var logsJson = jsonData['logs'] as List;
      logs.value = logsJson.map((logJson) => Log.fromJson(logJson)).toList();
      total_logs = jsonData['total_logs'];
      update();
    }
  }
}
