import 'package:flutter/material.dart';
import '../controller/update_complaints_controller.dart';
import 'package:get/get.dart';

class UpdateComplaintsView extends StatelessWidget {
  const UpdateComplaintsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateComplaintsController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Complaints"),
      ),
      body: Obx(() => SingleChildScrollView(
            child: Column(
              children: [
                CheckboxListTile(
                  title: const Text("Status"),
                  subtitle: const Text("Pilih status yang ingin diubah"),
                  // Langsung memeriksa nilai dari controller
                  value: controller.complaints?.value.status.toLowerCase() ==
                      'closed',
                  onChanged: (bool? value) {
                    // Logika untuk mengubah status tidak berubah
                    String newStatus = value == true ? 'closed' : 'open';
                    controller.updateComplaintStatus(newStatus);
                  },
                ),
              ],
            ),
          )),
    );
  }
}
