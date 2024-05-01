import 'package:flutter/material.dart';
import '../controller/logs_controller.dart';
import 'package:sipevo/core.dart';
import 'package:get/get.dart';

class LogsView extends StatelessWidget {
  const LogsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LogsController>(
      init: LogsController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: AppBar(
            title: Text("List Logs (${controller.total_logs})"),
            actions: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: IconButton(
                  onPressed: () => controller.refreshLogs(),
                  icon: const Icon(Icons.refresh),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0), // Tambahkan padding di sini
            child: ListView.builder(
              itemCount: controller.logs.length,
              itemBuilder: (context, index) {
                var log = controller.logs[index];
                return Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://sipevo.my.id/public/uploads/users/${log.photo}'),
                    ),
                    title: Text(
                      log.logDescription,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('${log.name} - ${log.timestamp}'),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
