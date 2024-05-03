import 'package:flutter/material.dart';
import 'package:sipevo/core.dart';
import 'package:sipevo/module/operator/komplain/update_komplain/controller/update_komplain_controller.dart';
import 'package:get/get.dart';

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
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Hero(
                tag: "readcomplaint_button",
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: AppColors.baseColor,
                    shape: const StadiumBorder(),
                    maximumSize: const Size(double.infinity, 46),
                    minimumSize: const Size(double.infinity, 46),
                  ),
                  onPressed: () => controller.readComplaint(),
                  child: Text(
                    "Read Complaint".toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Hero(
                tag: "resolvecomplaint_button",
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: AppColors.baseColor,
                    shape: const StadiumBorder(),
                    maximumSize: const Size(double.infinity, 46),
                    minimumSize: const Size(double.infinity, 46),
                  ),
                  onPressed: () => controller.resolveComplaint(),
                  child: Text(
                    "Resolve Complaint".toUpperCase(),
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
