import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sipevo/app_routes.dart';
import 'package:http/http.dart' as http;
import 'package:sipevo/shared_prefs_helper.dart';
import '../view/tambah_user_view.dart';
import 'dart:convert';

class TambahUserController extends GetxController {
  TambahUserView? view;

  Future<void> addUser() async {
    if (formKey.currentState!.validate()) {
      print("Name: ${controllerName.text}");
      print("No Hp: ${controllerNohp.text}");
      print("Email: ${controllerEmail.text}");
      print("Password: ${controllerPass.text}");
      print("Role: ${selectedRole.value}");
      print("Address: ${controllerAddress.text}");
      String? token = await SharedPrefsHelper.getToken();
      try {
        var response = await http.post(
          Uri.parse(AppRoutes.addUser),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type':
                'application/json', // Pastikan ini diperlukan oleh API
          },
          body: json.encode({
            'name': controllerName.text,
            'nohp': controllerNohp.text,
            'email': controllerEmail.text,
            'password': controllerPass.text,
            'role': selectedRole.value,
            'address': controllerAddress.text,
          }),
        );

        if (response.statusCode == 200) {
          // Handle response
          var data = json.decode(response.body);
          print("Success: ${data['message']}");
          // Tampilkan pesan sukses
          Get.snackbar(
            "Success", // Judul
            data['message'], // Pesan
            snackPosition: SnackPosition.BOTTOM, // Posisi Snackbar
            backgroundColor: Colors.blue, // Warna latar belakang Snackbar
            colorText: Colors.white, // Warna teks Snackbar
            duration: const Duration(seconds: 5),
          );
        } else {
          // Handle error
          print("Error: ${response.body}");
          // Tampilkan pesan error
          Get.snackbar(
            "Error", // Judul
            "Failed to add user", // Pesan default jika response.body tidak mengandung pesan yang spesifik
            snackPosition: SnackPosition.BOTTOM, // Posisi Snackbar
            backgroundColor: Colors.blue, // Warna latar belakang Snackbar
            colorText: Colors.white, // Warna teks Snackbar
            duration: const Duration(seconds: 5),
          );
        }
      } finally {
        // Clear the text fields
        controllerName.clear();
        controllerNohp.clear();
        controllerEmail.clear();
        controllerPass.clear();
        controllerAddress.clear();
        // Optionally, reset the selected role to the default value
        selectedRole.value = roles[0];
      }
    }
  }

  //
  final controllerName = TextEditingController();
  final controllerNohp = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerPass = TextEditingController();
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
  }

  //
  // void initState() {
  //   if (widget.job != null) {
  //     controllerIdJob.text = widget.job!.idJob!;
  //     controllerJobName.text = widget.job!.jobName!;
  //     controllerSalary.text = widget.job!.salary!;
  //   }
  //   super.initState();
  // }
}
