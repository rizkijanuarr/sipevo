import 'package:flutter/material.dart';
import 'package:sipevo/core.dart';
import 'package:get/get.dart';

class UserView extends StatelessWidget {
  const UserView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      init: UserController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: AppBar(
            title: const Text("List User"),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () => controller.refreshUsers(),
                  icon: const Icon(Icons.refresh),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  if (controller.users.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.users.length,
                      itemBuilder: (context, index) {
                        var user = controller.users[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor:
                                const Color(0xff0f9565).withOpacity(0.8),
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          title: Text(
                            user.name,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Text(user.role),
                          trailing: IconButton(
                            onPressed: () => controller.showOption(user),
                            icon: const Icon(Icons.more_vert),
                          ),
                        );
                      },
                    ),
                  if (controller.users.isEmpty)
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
          floatingActionButton: FloatingActionButton(
            onPressed: () => Get.to(const TambahUserView()),
            backgroundColor: Colors.red,
            child: const Icon(Icons.add, color: Colors.white),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
      },
    );
  }
}
