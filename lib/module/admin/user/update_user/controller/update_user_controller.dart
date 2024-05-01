import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sipevo/app_routes.dart';
import 'package:sipevo/core.dart';
import 'package:sipevo/module/models/user.dart';
import 'package:sipevo/shared_prefs_helper.dart';
import 'package:http/http.dart' as http;

class UpdateUserController extends GetxController {
  UpdateUserView? view;

  var users = <User>[].obs;

  // KEBUTUHAN TAMBAH USER
  final controllerId = TextEditingController();
  final controllerName = TextEditingController();
  final controllerNohp = TextEditingController();
  final controllerPass = TextEditingController();

  final formKey = GlobalKey<FormState>();

  // Daftar peran
  List<String> rolesItems = [
    'admin',
    'operator',
    'mahasiswa',
  ];

  List<String> angkatanItems = [
    '2019',
    '2020',
    '2021',
    '2022',
    '2023',
    '2024',
    '2025'
  ];

  List<String> prodiItems = [
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

  // Variabel untuk menyimpan peran yang dipilih
  RxString selectedRole = ''.obs;
  RxString selectedAngkatan = ''.obs;
  RxString selectedProdi = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Menerima objek User dari argumen
    User user = Get.arguments as User;

    // Mengisi form controller dengan data dari objek User
    controllerId.text = user.id.toString();
    controllerName.text = user.name;
    controllerNohp.text = user.nohp;
    controllerPass.text = user.pass;

    // Set peran default jika perlu
    selectedRole.value =
        rolesItems.contains(user.role) ? user.role : rolesItems[0];
    selectedAngkatan.value = angkatanItems.contains(user.mahasiswa_angkatan)
        ? user.mahasiswa_angkatan
        : angkatanItems[0];
    selectedProdi.value =
        prodiItems.contains(user.prodi) ? user.prodi : prodiItems[0];
  }

  Future<void> updateUser() async {
    String? token = await SharedPrefsHelper.getToken();
    if (token == null) {
      Get.snackbar(
        'Error',
        'No token found. Please login again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );
      print('Error: No token found. Please login again.');
      return;
    }

    final response = await http.post(
      Uri.parse(AppRoutes.updateUser),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'id_user': controllerId.text,
        'name': controllerName.text,
        'nohp': controllerNohp.text,
        'pass': controllerPass.text,
        'role': selectedRole.value,
        'mahasiswa_angkatan': selectedAngkatan.value,
        'prodi': selectedProdi.value,
      }),
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['success']) {
        Get.snackbar(
          'Success',
          data['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );

        print('Success: ${data['message']}');
        // Optionally, navigate back or refresh the user list
      } else {
        Get.snackbar(
          'Error',
          data['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );
        print('Error: ${data['message']}');
      }
    } else {
      Get.snackbar(
        'Error',
        'Failed to update user. Status code: ${response.statusCode}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );
      print(
          'Error: Failed to update user. Status code: ${response.statusCode}');
    }
  }

  void updateSelectedRole(String newRole) {
    selectedRole.value = newRole;
  }

  void updateSelectedAngkatan(String newAngkatan) {
    selectedAngkatan.value = newAngkatan;
  }

  void updateSelectedProdi(String newProdi) {
    selectedProdi.value = newProdi;
  }
}
