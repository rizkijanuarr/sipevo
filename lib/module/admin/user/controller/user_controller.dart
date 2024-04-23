import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sipevo/core.dart';
import 'package:http/http.dart' as http;

class UserController extends GetxController {
  UserView? view;

  var users = <User>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  /// untuk memperbarui tampilan
  /// / Tambahkan metode ini dalam UserController
  void refreshUsers() async {
    fetchUsers(); // Memuat ulang data pengguna dari server
    update(); // Memperbarui UI

    // Menampilkan Snackbar
    Get.snackbar(
      'Refreshed', // Judul Snackbar
      'Data telah diperbarui🚀', // Pesan Snackbar
      snackPosition: SnackPosition.BOTTOM, // Posisi Snackbar
      backgroundColor: Colors.blue, // Warna latar belakang Snackbar
      colorText: Colors.white, // Warna teks Snackbar
      duration: const Duration(seconds: 5), // Durasi tampilan Snackbar
    );
  }

  void fetchUsers() async {
    try {
      String? token = await SharedPrefsHelper.getToken();
      final response = await http.get(
        Uri.parse(AppRoutes.listUser),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type':
              'application/json', // Pastikan ini diperlukan oleh API
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['success']) {
          var usersJson = data['users'] as List;
          users.value =
              usersJson.map((userJson) => User.fromJson(userJson)).toList();
          print("Fetched users: $users");
        } else {
          print("Error from API: ${data['message']}");
        }
      } else {
        print("Error fetching users: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e) {
      print("Exception caught: $e");
    }
  }

  // Fungsi untuk menampilkan opsi
  void showOption(user) async {
    var result = await Get.dialog(
      SimpleDialog(
        children: [
          ListTile(
            onTap: () => Get.back(result: 'update'),
            title: const Text('Update'),
          ),
          ListTile(
            onTap: () => Get.back(result: 'delete'),
            title: const Text('Delete'),
          ),
          ListTile(
            onTap: () => Get.back(),
            title: const Text('Close'),
          ),
        ],
      ),
      barrierDismissible: false,
    );

    // Tindakan berdasarkan hasil dari dialog
    switch (result) {
      case 'update':
        Get.to(() => const UpdateUserView(), arguments: user)
            ?.then((value) => refreshUsers());
        break;
      case 'delete':
        delete(user);
        break;
    }
  }

  // Fungsi untuk menghapus pengguna
  void delete(User user) async {
    try {
      String? token = await SharedPrefsHelper.getToken();
      final response = await http.post(
        Uri.parse(AppRoutes.deleteUser),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'id_user':
              user.id, // Asumsikan setiap pengguna memiliki 'id' yang unik
        }),
      );

      print(
          "Delete response: ${response.body}"); // Tambahkan baris ini untuk mencetak respons

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['success']) {
          users.remove(
              user); // Hapus pengguna dari daftar lokal jika penghapusan di server berhasil
          update(); // Perbarui tampilan setelah penghapusan
          Get.snackbar(
            'Success', // Judul snackbar
            'User deleted successfully', // Pesan snackbar
            snackPosition: SnackPosition.BOTTOM, // Posisi Snackbar
            backgroundColor: Colors.blue, // Warna latar belakang Snackbar
            colorText: Colors.white, // Warna teks Snackbar
            duration: const Duration(seconds: 5), // Durasi tampilan Snackbar
          );
        } else {
          Get.snackbar(
            'Error', // Judul snackbar
            'Error from API: ${data['message']}', // Pesan snackbar
            snackPosition: SnackPosition.BOTTOM, // Posisi Snackbar
            backgroundColor: Colors.blue, // Warna latar belakang Snackbar
            colorText: Colors.white, // Warna teks Snackbar
            duration: const Duration(seconds: 5), // Durasi tampilan Snackbar
          );
        }
      } else {
        Get.snackbar(
          'Error', // Judul snackbar
          'Error deleting user: ${response.statusCode}', // Pesan snackbar
          snackPosition: SnackPosition.BOTTOM, // Posisi Snackbar
          backgroundColor: Colors.blue, // Warna latar belakang Snackbar
          colorText: Colors.white, // Warna teks Snackbar
          duration: const Duration(seconds: 5), // Durasi tampilan Snackbar
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error', // Judul snackbar
        'Exception caught: $e', // Pesan snackbar
        snackPosition: SnackPosition.BOTTOM, // Posisi Snackbar
        backgroundColor: Colors.blue, // Warna latar belakang Snackbar
        colorText: Colors.white, // Warna teks Snackbar
        duration: const Duration(seconds: 5), // Durasi tampilan Snackbar
      );
    }
  }
}
