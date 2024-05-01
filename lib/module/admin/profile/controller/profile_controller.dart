import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sipevo/app_routes.dart';
import 'package:sipevo/module/models/user.dart';
import 'package:sipevo/shared_prefs_helper.dart';
import '../view/profile_view.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  ProfileView? view;

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    nohpController.dispose();
    photoController.dispose();
  }

  // REFRESH KONTEN
  void refreshProfile() async {
    fetchUserProfile();

    Get.snackbar(
      'Refreshed',
      'Data telah diperbarui🚀',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      duration: const Duration(seconds: 5),
    );
  }

  // LIST PROFILE => HALAMAN PROFIL

  List<User> users = <User>[].obs;

  void fetchUserProfile() async {
    String? token = await SharedPrefsHelper.getToken();
    var url = Uri.parse(AppRoutes.profile);
    print("Fetching user profile from URL: $url");

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
      if (data['success'] != null && data['success']) {
        var userData = data['data'];
        users.assignAll([User.fromJson(userData)]);
        update();
      }
    }
  }

  // UPDATE PROFILE => HALAMAN UPDATE PROFILE

  final formKey = GlobalKey<FormState>();
  XFile? selectedImage;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController nohpController = TextEditingController();
  final TextEditingController photoController = TextEditingController();

  void updateProfile() async {
    String? token = await SharedPrefsHelper.getToken();
    var url = Uri.parse(AppRoutes.updateProfile);
    print("Updating user profile at URL: $url");

    try {
      if (nameController.text.isEmpty || nohpController.text.isEmpty) {
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

      var request =
          http.MultipartRequest('POST', Uri.parse(AppRoutes.updateProfile));
      request.headers['Authorization'] = 'Bearer $token';
      request.fields['name'] = nameController.text;
      request.fields['nohp'] = nohpController.text;

      if (selectedImage != null) {
        var imageFile = File(selectedImage!.path);
        var photo = await http.MultipartFile.fromPath('photo', imageFile.path);
        request.files.add(photo);
      }

      var response = await request.send();
      print('Response status: ${response.statusCode}');

      if (response.statusCode == 201) {
        // Print body only when status is successful
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
      nameController.clear();
      nohpController.clear();
      photoController.clear();
    }
  }
}
