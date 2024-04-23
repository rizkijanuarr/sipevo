import 'package:flutter/material.dart';
import '../controller/complaints_controller.dart';
import 'package:get/get.dart';

class ComplaintsView extends StatelessWidget {
  const ComplaintsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ComplaintsController>(
      init: ComplaintsController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("List Complaints"),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () => controller.refreshComplaints(),
                  icon: const Icon(Icons.refresh),
                ),
              ),
            ],
          ),
          body: Obx(
            () => SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    if (controller.complaints.isNotEmpty)
                      ...List.generate(controller.complaints.length, (index) {
                        var complaint = controller.complaints[index];
                        return Stack(
                          children: [
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "Subject: ${complaint.subject ?? ''}"),
                                          const SizedBox(height: 4),
                                          Text(
                                              "Deskripsi: ${complaint.description ?? ''}"),
                                          const SizedBox(height: 8),
                                          Text(
                                              "Di proses oleh: ${complaint.updatedByRole ?? ''}"),
                                          const SizedBox(
                                            height: 5.0,
                                          ),
                                          Chip(
                                            label: Text(
                                              complaint.status,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.0),
                                            ),
                                            backgroundColor: complaint.status
                                                        .toLowerCase() ==
                                                    'open'
                                                ? Colors.orange[500]
                                                : Colors.red[500],
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.more_vert),
                                      onPressed: () =>
                                          controller.showOption(complaint),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    if (controller.complaints.isEmpty)
                      const Center(
                        child: Text(
                          'Data Kosong',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
