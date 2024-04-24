import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sipevo/app_routes.dart';
import 'package:sipevo/core.dart';
import 'package:sipevo/module/models/complaints.dart';
import 'package:sipevo/shared_prefs_helper.dart';
import '../view/komplen_view.dart';
import 'package:http/http.dart' as http;

class KomplenController extends GetxController {
  KomplenView? view;

  var complaints = <Complaints>[].obs; // Gunakan tipe data Complaint

  /// untuk memperbarui tampilan
  /// / Tambahkan metode ini dalam UserController
  void refreshComplaints() async {
    fetchComplaints(); // Memuat ulang data pengguna dari server
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

  @override
  void onInit() {
    fetchComplaints();
    super.onInit();
  }

  void fetchComplaints() async {
    String? token = await SharedPrefsHelper.getToken();
    var response = await http.get(
      Uri.parse(AppRoutes.complaintsListMahasiswa),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['success']) {
        var complaintsJson = data['complaints'] as List;
        complaints.value = complaintsJson
            .map((complaintJson) => Complaints.fromJson(complaintJson))
            .toList();
      }
    } else {
      // Handle error
      print('Failed to load complaints');
    }
  }

  // Fungsi untuk menampilkan opsi
  void showOption(complaint) async {
    var result = await Get.dialog(
      SimpleDialog(
        children: [
          ListTile(
            onTap: () => Get.back(result: 'update'),
            title: const Text('Update'),
          ),
          ListTile(
            onTap: () => Get.back(result: 'delete'),
            title: const Text('Delete'),
          ),
          ListTile(
            onTap: () => Get.back(),
            title: const Text('Close'),
          ),
        ],
      ),
      barrierDismissible: false,
    );

    // Tindakan berdasarkan hasil dari dialog
    switch (result) {
      case 'update':
        Get.to(() => const TambahKomplenView(), arguments: complaint)
            ?.then((value) => refreshComplaints());
        break;
      case 'delete':
        if (complaint is Complaints) {
          // Pastikan `complaint` adalah instance dari `Complaints`
          deleteComplaint(
              complaint.idComplaint); // Gunakan `idComplaint` sebagai argumen
        }
        break;
    }
  }

  void deleteComplaint(String complaintId) async {
    String? token = await SharedPrefsHelper.getToken();
    print("Token: $token"); // Debug token
    var url =
        Uri.parse('${AppRoutes.deleteComplaints}?id_complaint=$complaintId');
    print("URL: $url"); // Debug URL
    var response = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    print("Status Code: ${response.statusCode}"); // Debug status code
    print("Response Body: ${response.body}"); // Debug response body

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['success']) {
        print('Complaint deleted successfully');
        Get.snackbar(
          'Success', // Title
          'Complaint deleted successfully', // Message
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue,
          colorText: Colors.white,
          duration: const Duration(seconds: 5), // Durasi tampilan Snackbar
        );
        fetchComplaints(); // Refresh the complaints list after deletion
      } else {
        print('Failed to delete complaint');
        Get.snackbar(
          'Error', // Title
          'Failed to delete complaint', // Message
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue,
          colorText: Colors.white,
          duration: const Duration(seconds: 5), // Durasi tampilan Snackbar
        );
      }
    } else {
      // Handle error
      print(
          'Failed to delete complaint with status code: ${response.statusCode}');
      Get.snackbar(
        'Error', // Title
        'Failed to delete complaint. Status code: ${response.statusCode}', // Message
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
        duration: const Duration(seconds: 5), // Durasi tampilan Snackbar
      );
    }
  }
}
