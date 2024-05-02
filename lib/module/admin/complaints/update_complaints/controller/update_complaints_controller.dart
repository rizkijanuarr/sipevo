import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sipevo/app_routes.dart';
import 'package:sipevo/core.dart';
import 'package:sipevo/module/models/complaints.dart';
import 'package:sipevo/shared_prefs_helper.dart';
import '../view/update_complaints_view.dart';
import 'package:http/http.dart' as http;

class UpdateComplaintsController extends GetxController {
  UpdateComplaintsView? view;

  @override
  void onInit() {
    if (Get.arguments is Complaints) {
      complaints = Rx<Complaints>(Get.arguments as Complaints);
    }
    super.onInit();
  }

  // KEBUTUHAN DROPDOWN status
  String? selectedStatus;

  final List<String> statusItems = [
    'Tunggu sebentar',
    'Sedang diproses',
    'Telah diselesaikan',
  ];

  void updateSelectedStatus(String? newStatus) {
    selectedStatus = newStatus;
    update();
  }
  // KEBUTUHAN DROPDOWN status

  Rx<Complaints>? complaints;

  Future<void> updateStatus() async {
    if (selectedStatus != null &&
        complaints != null &&
        complaints?.value != null) {
      String? token = await SharedPrefsHelper.getToken();
      var url = Uri.parse(AppRoutes.updateComplaints);

      var response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'id_complaint': complaints?.value.idComplaint,
          'status': selectedStatus,
        }),
      );

      print("STATUS COMPLAINTS ADMIN : $url");
      print("RESPONSE COMPLAINTS ADMIN : ${response.body}");

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        Get.snackbar(
          "Success",
          data['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );
      }
    }
  }

  // LAST
}
