import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sipevo/app_routes.dart';
import 'package:sipevo/module/models/complaints.dart';
import 'package:sipevo/shared_prefs_helper.dart';
import '../view/update_complaints_view.dart';
import 'package:http/http.dart' as http;

class UpdateComplaintsController extends GetxController {
  UpdateComplaintsView? view;

  Rx<Complaints>? complaints; // Tambahkan variabel untuk menyimpan data keluhan

  @override
  void onInit() {
    complaints = Rx<Complaints>(
        Get.arguments as Complaints); // Inisialisasi data keluhan dari argumen
    super.onInit();
  }

  void updateComplaintStatus(String newStatus) async {
    String? token = await SharedPrefsHelper.getToken();
    var response = await http.post(
      Uri.parse(AppRoutes.updateComplaints),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'id_complaint': complaints?.value.idComplaint,
        'status': newStatus,
      }),
    );
    print('Updating status to: $newStatus');

    if (response.statusCode == 200) {
      // Handle success
      var responseData = jsonDecode(response.body);
      print(responseData['message']); // Print message to console
      Get.back(); // Kembali ke halaman sebelumnya
      Get.snackbar(
        "Success",
        responseData['message'], // Tampilkan snackbar dengan pesan sukses
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue, // Warna latar belakang Snackbar
        colorText: Colors.white, // Warna teks Snackbar
        duration: const Duration(seconds: 5), // Durasi tampilan Snackbar
      );
    } else {
      // Handle error
      var responseData = jsonDecode(response.body);
      print('Failed to update complaint status: ${responseData['message']}');
      Get.snackbar(
        "Error",
        "Failed to update complaint status: ${responseData['message']}", // Tampilkan snackbar dengan pesan error
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue, // Warna latar belakang Snackbar
        colorText: Colors.white, // Warna teks Snackbar
        duration: const Duration(seconds: 5), // Durasi tampilan Snackbar
      );
    }
  }
}
