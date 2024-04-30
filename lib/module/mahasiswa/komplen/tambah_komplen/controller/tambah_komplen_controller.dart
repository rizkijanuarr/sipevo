import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sipevo/app_routes.dart';
import 'package:sipevo/shared_prefs_helper.dart';
import '../view/tambah_komplen_view.dart';
import 'package:http/http.dart' as http;

class TambahKomplenController extends GetxController {
  TambahKomplenView? view;

  // DROPDOWN
  String? selectedLocation;
  XFile? selectedImage;

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
    update(); // This triggers a UI update
  }
  // END DROPDOWN

  final formKey = GlobalKey<FormState>();

  final TextEditingController subjectController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final controllerLocation = ();
  final TextEditingController photoController = TextEditingController();

  @override
  void onClose() {
    subjectController.dispose();
    descriptionController.dispose();
    photoController.dispose();
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

      var request = http.MultipartRequest(
          'POST', Uri.parse(AppRoutes.addComplaintsMahasiswa));
      request.headers['Authorization'] = 'Bearer $token';
      request.fields['subject'] = subjectController.text;
      request.fields['description'] = descriptionController.text;
      request.fields['location'] = selectedLocation!;

      if (selectedImage != null) {
        var imageFile =
            File(selectedImage!.path); // Mengonversi XFile menjadi File
        var photo = await http.MultipartFile.fromPath(
            'photo',
            imageFile
                .path); // Menggunakan nama parameter 'photo' untuk file gambar
        request.files.add(photo);
      }

      var response = await request.send();
      print('Response status: ${response.statusCode}');

      if (response.statusCode == 201) {
        // Print body only when status is successful
        var responseBody = await response.stream.bytesToString();
        print('Response body: $responseBody');

        // Parse the response body to get the photo URL
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
      // Clear the text fields after attempting submission, successful or not
      subjectController.clear();
      descriptionController.clear();
    }
  }
}
