import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../../../../../app_routes.dart';
import '../../../../../shared_prefs_helper.dart';
import '../../../../models/PengaduanCategory.dart';
import '../view/create_view.dart';

import 'package:http/http.dart' as http;

class CreateController extends GetxController {
  CreateView? view;
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController locationController;

  final formKey = GlobalKey<FormState>();
  List<PengaduanCategory> categories = [];
  String? selectedCategory;

  final TextEditingController photoController = TextEditingController();
  XFile? selectedImage;

  @override
  void onInit() {
    super.onInit();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    locationController = TextEditingController();
    fetchCategories();
  }

  // FETCH CATEGORIES

  void onCategoryChanged(String? value) {
    if (value != null) {
      selectedCategory = value;
    }
  }

  // FETCH CATEGORIES

  void fetchCategories() async {
    final token = await SharedPrefsHelper.getToken();
    try {
      final response = await http.get(
        Uri.parse(AppRoutes.categories),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final List<dynamic> categoryData = responseData['data']['data'];

        categories = categoryData
            .map((category) => PengaduanCategory.fromJson(category))
            .toList();

        // Set default value for selectedCategory
        if (categories.isNotEmpty) {
          selectedCategory = categories.first.id.toString();
        }

        update();
      } else {
        print('Failed to load categories');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  // SUBMIT
  void submit() async {
    final token = await SharedPrefsHelper.getToken();
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse(AppRoutes.basePENGADUAN));
      request.headers.addAll({
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });

      request.fields['pengaduan_category_id'] = selectedCategory!;
      request.fields['title'] = titleController.text;
      request.fields['description'] = descriptionController.text;
      request.fields['location'] = locationController.text;

      if (selectedImage != null) {
        var imageFile = File(selectedImage!.path);
        // Validasi ukuran file gambar
        final fileSize = await imageFile.length();
        if (fileSize > 2000000) {
          // lebih dari 2MB
          print('Error: File size exceeds 2MB');
          return;
        }
        var photo = await http.MultipartFile.fromPath(
            'image', imageFile.path); // Pastikan nama 'image'
        request.files.add(photo);
      }

      // Print data yang akan dikirim
      print('Data yang akan dikirim:');
      print('Kategori: ${request.fields['pengaduan_category_id']}');
      print('Judul: ${request.fields['title']}');
      print('Deskripsi: ${request.fields['description']}');
      print('Lokasi: ${request.fields['location']}');
      print('Foto: ${selectedImage?.path}');
      print('URL permintaan: ${request.url}');

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var responseData = jsonDecode(responseBody);

        print('Response: $responseData');
        print('Pengaduan berhasil dibuat!');
        titleController.clear();
        descriptionController.clear();
        locationController.clear();
        selectedImage = null;
        update();

        // Menampilkan Snackbar sukses
        Get.snackbar(
          'Sukses',
          'Pengaduan berhasil dibuat!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        print('Error: ${response.statusCode}');
        var responseBody = await response.stream.bytesToString();
        print('Response Body: $responseBody'); // untuk debug response body
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    super.onClose();
  }
}
