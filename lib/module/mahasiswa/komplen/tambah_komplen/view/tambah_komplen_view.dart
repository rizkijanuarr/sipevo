import 'package:flutter/material.dart';
import '../controller/tambah_komplen_controller.dart';
import 'package:sipevo/core.dart';
import 'package:get/get.dart';

class TambahKomplenView extends StatelessWidget {
  const TambahKomplenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TambahKomplenController>(
      init: TambahKomplenController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: AppBar(
            title: const Text("TambahKomplen"),
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
