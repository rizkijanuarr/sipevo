import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
              : controller.statuses.isEmpty
                  ? Center(
                      child: Text('Data tidak tersedia!'),
                    )
                  : ListView.builder(
                      itemCount: controller.statuses.length,
                      itemBuilder: (context, index) {
                        PengaduanStatus status = controller.statuses[index];
                        Color backgroundColor;

                        switch (status.name) {
                          case 'Pending':
                            backgroundColor = Colors.red;
                            break;
                          case 'Sedang diproses':
                            backgroundColor = Colors.yellow;
                            break;
                          case 'Terselesaikan':
                            backgroundColor = Colors.green;
                            break;
                          default:
                            backgroundColor = Colors.grey;
                        }

                        return Card(
                          elevation: 1,
                          margin: const EdgeInsets.all(8),
                          child: ListTile(
                            title: RichText(
                              text: TextSpan(
                                text: status.name,
                                style: TextStyle(
                                  color: Colors.black,
                                  backgroundColor: backgroundColor,
                                ),
                              ),
                            ),
                            subtitle: Text(status.slug),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(status.name),
                                    content: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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

class Status {
  final String name;

  Status(this.name);
}
