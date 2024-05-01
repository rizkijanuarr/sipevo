import 'package:flutter/material.dart';
import '../controller/update_account_controller.dart';
import 'package:sipevo/core.dart';
import 'package:get/get.dart';

class UpdateAccountView extends StatelessWidget {
  const UpdateAccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpdateAccountController>(
      init: UpdateAccountController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: AppBar(
            title: const Text("UpdateAccount"),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: const [],
              ),
            ),
          ),
        );
      },
    );
  }
}
