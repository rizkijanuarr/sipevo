import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sipevo/app_routes.dart';
import 'package:sipevo/core.dart';
import 'package:sipevo/module/models/complaints.dart';
import 'package:sipevo/shared_prefs_helper.dart';
import '../view/komplen_view.dart';
import 'package:http/http.dart' as http;

class KomplenController extends GetxController {
  KomplenView? view;

  @override
  void onInit() {
    fetchComplaints();
    super.onInit();
  }

  @override
  void onClose() {
    subjectController.dispose();
    descriptionController.dispose();
    photoController.dispose();
    super.onClose();
  }

  // REFRESH KONTEN
  void refreshComplaints() async {
    fetchComplaints();

    Get.snackbar(
      'Refreshed',
      'Data telah diperbarui🚀',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      duration: const Duration(seconds: 5),
    );
  }

  // LIST KOMPLEN => HALAMAN KOMPLEN VIEW
  int total_complaints = 0;
  var complaints = <Complaints>[].obs;

  String basePhotoComplaints =
      "https://sipevo.my.id/public/uploads/complaints/";

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
          var decodedPhotoUrl =
              Uri.decodeFull(complaintJson['photo_complaints'] ?? '');
          complaintJson['photo_complaints'] = decodedPhotoUrl;
          return Complaints.fromJson(complaintJson);
        }).toList();
        total_complaints = data['total_results'];
        update();
      }
    }
  }

  // TAMBAH KOMPLEN => HALAMAN TAMBAH KOMPLEN
  String? selectedLocation;
  XFile? selectedImage;

  final formKey = GlobalKey<FormState>();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final controllerLocation = ();
  final TextEditingController photoController = TextEditingController();

  final List<String> locationItems = [
    'K1',
    'K2',
    'K3',
    'K4',
    'K5',
    'K6',
    'K7',
    'K8',
    'K9',
    'K10'
  ];

  void updateSelectedLocation(String? newLocation) {
    selectedLocation = newLocation;
    update();
  }

  void addComplaint() async {
    try {
      final token = await SharedPrefsHelper.getToken();
      print('Token: $token');

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

      var request = http.MultipartRequest(
          'POST', Uri.parse(AppRoutes.addComplaintsMahasiswa));
      request.headers['Authorization'] = 'Bearer $token';
      request.fields['subject'] = subjectController.text;
      request.fields['description'] = descriptionController.text;
      request.fields['location'] = selectedLocation!;

      if (selectedImage != null) {
        var imageFile = File(selectedImage!.path);
        var photo = await http.MultipartFile.fromPath('photo', imageFile.path);
        request.files.add(photo);
      }

      var response = await request.send();
      print('Response status: ${response.statusCode}');

      if (response.statusCode == 201) {
        var responseBody = await response.stream.bytesToString();
        print('Response body: $responseBody');

        var responseJson = json.decode(responseBody);
        var photoUrl = responseJson['photo_url'];

        Get.snackbar(
          'Success',
          'Complaint added successfully. Photo URL: $photoUrl',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );
      } else {
        final responseData = json.decode(await response.stream.bytesToString());
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
      subjectController.clear();
      descriptionController.clear();
      photoController.clear();
    }
  }

  // LAST
}
