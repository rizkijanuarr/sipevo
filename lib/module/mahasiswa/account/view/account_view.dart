import 'package:flutter/material.dart';
import 'package:sipevo/module/mahasiswa/account/view/update_account.dart';
import '../controller/account_controller.dart';
import 'package:sipevo/core.dart';
import 'package:get/get.dart';

class AccountView extends StatelessWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(
      init: AccountController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Profile"),
            actions: [
              IconButton(
                onPressed: () => controller.refreshProfile(),
                icon: const Icon(
                  Icons.refresh,
                  size: 24.0,
                ),
              ),
              IconButton(
                onPressed: () async {
                  await SharedPrefsHelper.removeToken();
                  Get.offAll(() => LoginView());
                },
                icon: const Icon(
                  Icons.logout,
                  size: 24.0,
                ),
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(30.0),
            child: Column(
              children: [
                SizedBox(
                  height: 24,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 12.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(124 / 2),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                          spreadRadius: 8)
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 42.0,
                      backgroundImage: NetworkImage(
                        controller.users.isNotEmpty
                            ? ('https://sipevo.my.id/public/uploads/users/${controller.users[0].photo}')
                            : '',
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Obx(() => Text(
                      controller.users.isNotEmpty
                          ? controller.users[0].name
                          : '',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Container(
                  margin: const EdgeInsets.only(
                    top: 16.0,
                    bottom: 16.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        color: Color(0xffAF52DE),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 12.0,
                            right: 12.0,
                            top: 4.0,
                            bottom: 4.0,
                          ),
                          child: Obx(
                            () => Text(
                              controller.users.isNotEmpty
                                  ? controller.users[0].role.replaceFirst(
                                      controller.users[0].role[0],
                                      controller.users[0].role[0].toUpperCase())
                                  : '',
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 12.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                          spreadRadius: 8)
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Information",
                          style: TextStyle(
                            color: const Color(0xff3C3C43).withOpacity(0.6),
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Name",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Obx(() => Text(
                                      controller.users.isNotEmpty
                                          ? controller.users[0].name
                                          : '',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Nomor HP",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Obx(() => Text(
                                      controller.users.isNotEmpty
                                          ? controller.users[0].nohp
                                          : '',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Angkatan",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Obx(() => Text(
                                      controller.users.isNotEmpty
                                          ? controller
                                              .users[0].mahasiswa_angkatan
                                          : '',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Prodi",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Obx(() => Text(
                                      controller.users.isNotEmpty
                                          ? controller.users[0].prodi
                                          : '',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            heroTag: "profile",
            onPressed: () =>
                Get.to(() => const UpdateAccount(), preventDuplicates: false),
            backgroundColor: Colors.red,
            child: const Icon(Icons.edit, color: Colors.white),
          ),
        );
      },
    );
  }
}
