import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sipevo/core.dart';
import 'package:http/http.dart' as http;

class UserController extends GetxController {
  UserView? view;

  int total_users = 0;
  var users = <User>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  void refreshUsers() async {
    fetchUsers();

    Get.snackbar(
      'Refreshed',
      'Data telah diperbarui🚀',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      duration: const Duration(seconds: 5),
    );
  }

  void fetchUsers() async {
    String? token = await SharedPrefsHelper.getToken();
    final response = await http.get(
      Uri.parse(AppRoutes.getUser),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      if (data['success']) {
        users.value = (data['users'] as List)
            .map((userJson) => User.fromJson(userJson))
            .toList();
        total_users = data['total_users'];
        update();
        print("Fetched users: $users");
      }
    }
  }

  Future<String?> showOption(user) async {
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

    switch (result) {
      case 'update':
        Get.to(() => const UpdateUserView(), arguments: user);
        break;
      case 'delete':
        if (user != null) {
          bool? confirmDelete = await Get.defaultDialog<bool>(
            title: "Are you sure?",
            content: Text("You won't be able to revert this!"),
            textConfirm: "Yes, delete it!",
            textCancel: "Cancel",
            confirmTextColor: Colors.white,
            onConfirm: () {
              Get.back(result: true);
            },
            onCancel: () {
              Get.back(result: false);
            },
          );
          print("Confirm Delete: $confirmDelete");
          if (confirmDelete == true) {
            await delete(user);
          }
        }
        break;
    }
  }

  Future<void> delete(User user) async {
    String? token = await SharedPrefsHelper.getToken();

    final response = await http.post(
      Uri.parse(AppRoutes.deleteUser),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'id_user': user.id,
      }),
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['success']) {
        users.remove(user);
        update();

        Get.snackbar(
          'Success',
          'User deleted successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );
      }
    }
  }

  // LAST
}
