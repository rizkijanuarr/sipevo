import 'package:flutter/material.dart';
import '../controller/account_controller.dart';
import 'package:sipevo/core.dart';
import 'package:get/get.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

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
                onPressed: () async {
                  await SharedPrefsHelper.removeToken();
                  Get.offAll(LoginView());
                },
                icon: const Icon(
                  Icons.logout,
                  size: 24.0,
                ),
              ),
            ],
          ),
          body: Center(
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: const Column(
                children: [
                  Text(
                    "COMMING SOON!👀",
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Color(0xff0f9565),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
