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
  String basePhotoComplaints =
      "https://sipevo.my.id/public/uploads/complaints/";

  void refreshComplaints() async {
    fetchComplaints();
    update();

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
    var url = Uri.parse(AppRoutes.getComplaintsMahasiswa);
    print("Fetching complaints from URL: $url");

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['success']) {
        var complaintsJson = data['complaints'] as List;
        complaints.value = complaintsJson.map((complaintJson) {
          // Decode the photo_complaints URL before passing it to the model
          var decodedPhotoUrl =
              Uri.decodeFull(complaintJson['photo_complaints'] ?? '');
          complaintJson['photo_complaints'] =
              decodedPhotoUrl; // Update the JSON with the decoded URL
          return Complaints.fromJson(complaintJson);
        }).toList();
      }
    } else {
      print('Failed to load complaints');
    }
  }
}
