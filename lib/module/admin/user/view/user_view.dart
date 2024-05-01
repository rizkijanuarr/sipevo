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
            title: Text("List Users (${controller.total_users})"),
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
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
              itemCount: controller.users.length,
              itemBuilder: (context, index) {
                var user = controller.users[index];
                return InkWell(
                  onTap: () async {
                    // Aksi yang akan diambil saat card ditekan
                    String? result = await controller.showOption(user);
                    if (result == 'update') {
                      // update
                    } else if (result == 'delete') {
                      // del
                    } else {
                      // close
                    }
                    return;
                  },
                  child: Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.all(10),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://sipevo.my.id/public/uploads/users/${user.photo}'),
                          ),
                          title: Text(
                            user.name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${user.role.substring(0, 1).toUpperCase()}${user.role.substring(1)} - ${user.nohp}',
                              ),
                              Text(
                                user.prodi != null ? user.prodi : '-',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Get.to(const TambahUserView()),
            backgroundColor: AppColors.baseColor,
            child: const Icon(Icons.add, color: Colors.white),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
      },
    );
  }
}
