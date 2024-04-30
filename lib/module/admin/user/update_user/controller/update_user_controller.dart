import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sipevo/app_routes.dart';
import 'package:sipevo/module/models/user.dart';
import 'package:sipevo/shared_prefs_helper.dart';
import '../view/update_user_view.dart';
import 'package:http/http.dart' as http;

class UpdateUserController extends GetxController {
  UpdateUserView? view;

  var users = <User>[].obs;

  Future<void> updateUser() async {
    String? token = await SharedPrefsHelper.getToken();
    if (token == null) {
      Get.snackbar(
        'Error', // Judul Snackbar
        'No token found. Please login again.', // Pesan Snackbar
        snackPosition: SnackPosition.BOTTOM, // Posisi Snackbar
        backgroundColor: Colors.blue, // Warna latar belakang Snackbar
        colorText: Colors.white, // Warna teks Snackbar
        duration: const Duration(seconds: 5), // Durasi tampilan Snackbar
      );
      print('Error: No token found. Please login again.');
      return;
    }

    // Tempatkan kode print di sini untuk memverifikasi data yang akan dikirim
    print(jsonEncode({
      'id_user': controllerId.text,
      'name': controllerName.text.isNotEmpty ? controllerName.text : null,
      'nohp': controllerNohp.text.isNotEmpty ? controllerNohp.text : null,
      'email': controllerEmail.text.isNotEmpty ? controllerEmail.text : null,
      'role': selectedRole.value.isNotEmpty ? selectedRole.value : null,
      'address':
          controllerAddress.text.isNotEmpty ? controllerAddress.text : null,
    }));

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
        'email': controllerEmail.text,
        'role': selectedRole.value,
        'address': controllerAddress.text,
      }),
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['success']) {
        Get.snackbar(
          'Success', data['message'],
          snackPosition: SnackPosition.BOTTOM, // Posisi Snackbar
          backgroundColor: Colors.blue, // Warna latar belakang Snackbar
          colorText: Colors.white, // Warna teks Snackbar
          duration: const Duration(seconds: 5),
        );

        print('Success: ${data['message']}');
        // Optionally, navigate back or refresh the user list
      } else {
        Get.snackbar(
          'Error', data['message'],
          snackPosition: SnackPosition.BOTTOM, // Posisi Snackbar
          backgroundColor: Colors.blue, // Warna latar belakang Snackbar
          colorText: Colors.white, // Warna teks Snackbar
          duration: const Duration(seconds: 5),
        );
        print('Error: ${data['message']}');
      }
    } else {
      Get.snackbar(
        'Error',
        'Failed to update user. Status code: ${response.statusCode}',
        snackPosition: SnackPosition.BOTTOM, // Posisi Snackbar
        backgroundColor: Colors.blue, // Warna latar belakang Snackbar
        colorText: Colors.white, // Warna teks Snackbar
        duration: const Duration(seconds: 5),
      );
      print(
          'Error: Failed to update user. Status code: ${response.statusCode}');
    }
  }

  //
  final controllerId = TextEditingController();
  final controllerName = TextEditingController();
  final controllerNohp = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerRole = TextEditingController();
  final controllerAddress = TextEditingController();

  final formKey = GlobalKey<FormState>();

  // Daftar peran
  List<String> roles = ['admin', 'operator', 'mahasiswa'];

  // Variabel untuk menyimpan peran yang dipilih
  RxString selectedRole = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Set peran default jika perlu
    selectedRole.value = roles[0];

    // Menerima objek User dari argumen
    User user = Get.arguments as User;

    // Mengisi form controller dengan data dari objek User
    controllerId.text = user.id.toString();
    controllerName.text = user.name;
    controllerNohp.text = user.nohp;
    selectedRole.value = user.role;

    // Set peran default jika perlu
    selectedRole.value = roles.contains(user.role) ? user.role : roles[0];
  }
}
