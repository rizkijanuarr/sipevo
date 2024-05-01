import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sipevo/app_routes.dart';
import 'package:http/http.dart' as http;
import 'package:sipevo/shared_prefs_helper.dart';
import '../view/tambah_user_view.dart';
import 'dart:convert';

class TambahUserController extends GetxController {
  TambahUserView? view;

  @override
  void onInit() {
    super.onInit();
  }

  // KEBUTUHAN DROPDOWN roles, angkatan, prodi
  String? selectedRoles;
  String? selectedAngkatan;
  String? selectedProdi;

  final List<String> rolesItems = ['admin', 'operator', 'mahasiswa'];
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

  void updateSelectedRoles(String? newRoles) {
    selectedRoles = newRoles;
    update();
  }

  void updateSelectedAngkatan(String? newAngkatan) {
    selectedAngkatan = newAngkatan;
    update();
  }

  void updateSelectedProdi(String? newProdi) {
    selectedProdi = newProdi;
    update();
  }
  // KEBUTUHAN DROPDOWN roles, angkatan, prodi

  // KEBUTUHAN TAMBAH USER
  final formKey = GlobalKey<FormState>();
  final controllerName = TextEditingController();
  final controllerNohp = TextEditingController();
  final controllerPass = TextEditingController();

  Future<void> addUser() async {
    if (formKey.currentState!.validate()) {
      String? token = await SharedPrefsHelper.getToken();

      try {
        var response = await http.post(
          Uri.parse(AppRoutes.addUser),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'name': controllerName.text,
            'nohp': controllerNohp.text,
            'password': controllerPass.text,
            'role': selectedRoles,
            'mahasiswa_angkatan': selectedAngkatan,
            'prodi': selectedProdi,
          }),
        );

        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          update();

          Get.snackbar(
            "Success",
            data['message'],
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.blue,
            colorText: Colors.white,
            duration: const Duration(seconds: 5),
          );
        }
      } finally {
        controllerName.clear();
        controllerNohp.clear();
        controllerPass.clear();

        selectedRoles = null;
        selectedAngkatan = null;
        selectedProdi = null;

        update();
      }
    }
  }
  // KEBUTUHAN TAMBAH USER

  // LAST
}
