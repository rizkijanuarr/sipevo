import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sipevo/app_routes.dart';
import 'package:sipevo/module/models/user.dart';
import 'package:sipevo/shared_prefs_helper.dart';
import '../view/account_view.dart';
import 'package:http/http.dart' as http;

class AccountController extends GetxController {
  AccountView? view;

  List<User> users = <User>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void fetchUserProfile() async {
    String? token = await SharedPrefsHelper.getToken();
    var url = Uri.parse(AppRoutes.profile);
    print("Fetching user profile from URL: $url");

    try {
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
        } else {
          print("Error: Success is false in response");
        }
      } else {
        print("Error: Unexpected status code ${response.statusCode}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }
}
