import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sipevo/app_routes.dart';
import 'package:sipevo/module/models/complaints.dart';
import 'package:sipevo/shared_prefs_helper.dart';
import '../view/tambah_komplen_view.dart';
import 'package:http/http.dart' as http;

class TambahKomplenController extends GetxController {
  TambahKomplenView? view;

  final formKey = GlobalKey<FormState>();

  final TextEditingController subjectController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void onClose() {
    subjectController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  void addComplaint() async {
    try {
      final token = await SharedPrefsHelper.getToken();
      print('Token: $token'); // Debugging token

      if (subjectController.text.isEmpty ||
          descriptionController.text.isEmpty) {
        Get.snackbar(
          'Error',
          'Subject and description cannot be empty',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );
        return;
      }

      final requestBody = jsonEncode({
        'subject': subjectController.text,
        'description': descriptionController.text,
      });
      print('Request Body: $requestBody'); // Debugging request body

      final response = await http.post(
        Uri.parse(AppRoutes.addComplaintsMahasiswa),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: requestBody,
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        Get.snackbar(
          'Success',
          'Complaint added successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );
      } else {
        final responseData = json.decode(response.body);
        Get.snackbar(
          'Error',
          responseData['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );
      }
    } catch (e) {
      print('An error occurred: $e');
      Get.snackbar(
        'Error',
        'An unexpected error occurred',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );
    } finally {
      // Clear the text fields after attempting submission, successful or not
      subjectController.clear();
      descriptionController.clear();
    }
  }
}
