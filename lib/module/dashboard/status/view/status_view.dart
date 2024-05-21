import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/PengaduanStatus.dart'; // Import model PengaduanStatus
import '../controller/status_controller.dart';
import 'package:sipevo/core.dart';

class StatusView extends StatelessWidget {
  const StatusView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StatusController>(
      init: StatusController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Status"),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () => controller.refreshStatus(),
                  icon: const Icon(Icons.refresh),
                ),
              ),
            ],
          ),
          body: controller.statuses.isEmpty
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: controller.statuses.length,
                  itemBuilder: (context, index) {
                    PengaduanStatus status = controller.statuses[index];
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        title: Text(status.name),
                        subtitle: Text(status.slug),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(status.name),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Name: ${status.name}'),
                                    Text('Slug: ${status.slug}'),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Close'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
