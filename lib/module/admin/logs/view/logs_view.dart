import 'package:flutter/material.dart';
import '../controller/logs_controller.dart';
import 'package:sipevo/core.dart';
import 'package:get/get.dart';

class LogsView extends StatelessWidget {
  const LogsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LogsController>(
      init: LogsController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("List Logs"),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () => controller.refreshLogs(),
                  icon: const Icon(Icons.refresh),
                ),
              ),
            ],
          ),
          body: Obx(() => ListView.builder(
                itemCount: controller.logs.length,
                itemBuilder: (context, index) {
                  final log = controller.logs[index];
                  return ListTile(
                    title: Text(log.logDescription),
                    subtitle: Text("${log.name} - ${log.timestamp}"),
                  );
                },
              )),
        );
      },
    );
  }
}
