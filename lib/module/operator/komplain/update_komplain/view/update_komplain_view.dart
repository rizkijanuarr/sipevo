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
      body: Obx(
        () => SingleChildScrollView(
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
        ),
      ),
    );
  }
}
