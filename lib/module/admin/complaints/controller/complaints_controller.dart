import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sipevo/core.dart';
import 'package:http/http.dart' as http;

class ComplaintsController extends GetxController {
  ComplaintsView? view;

  int total_complaints = 0;
  var complaints = <Complaints>[].obs;

  String basePhotoComplaints =
      "https://sipevo.my.id/public/uploads/complaints/";

  void refreshComplaints() async {
    fetchComplaints();

    Get.snackbar(
      'Refreshed',
      'Data telah diperbarui🚀',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      duration: const Duration(seconds: 5),
    );
  }

  @override
  void onInit() {
    fetchComplaints();
    super.onInit();
  }

  void fetchComplaints() async {
    String? token = await SharedPrefsHelper.getToken();
    var url = Uri.parse(AppRoutes.getComplaints);
    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    print('Response body: ${response.body}');
    print('Status code: ${response.statusCode}');
    print('URL: ${url.toString()}');

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['success']) {
        var complaintsJson = data['complaints'] as List;
        complaints.value = complaintsJson
            .map((complaintJson) => Complaints.fromJson(complaintJson))
            .toList();
        total_complaints = data['total_results'];
        update();
      }
    }
  }

  Future<String?> showOption(complaint) async {
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
        Get.to(() => const UpdateKomplainView(), arguments: complaint)
            ?.then((value) {
          fetchComplaints();
        });
        break;
      case 'delete':
        if (complaint is Complaints) {
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
              });
          print("Confirm Delete: $confirmDelete");
          if (confirmDelete == true) {
            print("Deleting complaint with ID: ${complaint.idComplaint}");
            deleteComplaint(complaint.idComplaint);
          }
        }
        break;
    }
  }

  void deleteComplaint(String complaintId) async {
    String? token = await SharedPrefsHelper.getToken();
    print("Token: $token");

    var url =
        Uri.parse('${AppRoutes.deleteComplaints}?id_complaint=$complaintId');
    print("URL: $url");

    var response = await http.delete(
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
      if (data['success']) {
        print('Complaint deleted successfully');
        Get.snackbar(
          'Success',
          'Complaint deleted successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );
        fetchComplaints();
      }
    }
  }
}
