import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sipevo/core.dart';
import 'package:get/get.dart';
import 'package:sipevo/module/operator/komplain/update_komplain/controller/update_komplain_controller.dart';

class UpdateKomplainView extends StatelessWidget {
  const UpdateKomplainView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateKomplainController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Complaints"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: controller.selectedStatus,
                onChanged: (String? newValue) {
                  controller.selectedStatus = newValue!;
                  controller.update();
                },
                items: controller.statusItems
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      _truncateStringIfNeeded(value, 20),
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  hintText: "Status",
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Icon(Icons.build),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Hero(
                tag: "tambahkomplen_button",
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: AppColors.primarySwatch,
                    shape: const StadiumBorder(),
                    maximumSize: const Size(double.infinity, 46),
                    minimumSize: const Size(double.infinity, 46),
                  ),
                  onPressed: () async {
                    if (controller.selectedStatus != null) {
                      await controller.updateStatus();
                    } else {
                      Get.snackbar(
                        "Error",
                        "Please select a status",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.blue,
                        colorText: Colors.white,
                        duration: const Duration(seconds: 5),
                      );
                    }
                  },
                  child: Text(
                    "Update".toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // KEBUTUHAN MEMOTONG STRING YANG PANJANGNYA MELEBIHI BATAS
  String _truncateStringIfNeeded(String input, int maxLength) {
    if (input.length <= maxLength) {
      return input;
    } else {
      return input.substring(0, maxLength) + '...';
    }
  }
}
