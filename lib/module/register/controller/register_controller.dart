import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sipevo/app_routes.dart';
import 'package:sipevo/core.dart';
import '../view/register_view.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  RegisterView? view;

  // KEBUTUHAN visible password
  bool showPassword = false;

  void togglePasswordVisibility() {
    showPassword = !showPassword;
    update();
  }
  // KEBUTUHAN visible password

  // KEBUTUHAN DROPDOWN mahasiswa_angkatan dan prodi
  String? selectedAngkatan;
  String? selectedProdi;

  final List<String> angkatanItems = [
    '2019',
    '2020',
    '2021',
    '2022',
    '2023',
    '2024',
    '2025'
  ];

  final List<String> prodiItems = [
    'D-4 Teknik Mesin',
    'D-4 Teknik Listrik',
    'D-4 Teknik Sipil',
    'D-4 Transportasi',
    'D-4 Tata Boga',
    'D-4 Tata Busana',
    'D-4 Manajemen Informatika',
    'D-4 Administrasi Negara',
    'D-4 Desain Grafis',
    'D-4 Kepelatihan Olahraga'
  ];

  void updateSelectedAngkatan(String? newAngkatan) {
    selectedAngkatan = newAngkatan;
    update();
  }

  void updateSelectedProdi(String? newProdi) {
    selectedProdi = newProdi;
    update();
  }
  // KEBUTUHAN DROPDOWN mahasiswa_angkatan dan prodi

  // KEBUTUHAN REGISTER USER
  var formKey = GlobalKey<FormState>();
  var controllerName = TextEditingController();
  var controllerNohp = TextEditingController();
  var controllerPass = TextEditingController();
  var controllerMahasiswaAngkatan = ();
  var controllerProdi = ();

  Future<void> registerUser() async {
    var url = Uri.parse(AppRoutes.register);
    var response = await http.post(url, body: {
      'name': controllerName.text,
      'nohp': controllerNohp.text,
      'pass': controllerPass.text,
      'mahasiswa_angkatan': selectedAngkatan,
      'prodi': selectedProdi,
    });

    print("Sending registration data to server...");

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("Response from server: ${response.body}");

      if (data['success']) {
        Get.snackbar(
          'Success',
          'Registration successful, Silahkan ke halaman Login..',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );
        print("Registration successful");
      } else {
        Get.snackbar(
          'Error',
          'Registration failed',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );
        print("Registration failed with message: ${data['message']}");
      }
    } else {
      Get.snackbar(
        'Error',
        'Server error',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );
      print("Server error with status code: ${response.statusCode}");
    }
    clearTextFields();
  }

  void clearTextFields() {
    controllerName.clear();
    controllerNohp.clear();
    controllerPass.clear();
    selectedAngkatan = null;
    selectedProdi = null;
  }

  // LAST
}
