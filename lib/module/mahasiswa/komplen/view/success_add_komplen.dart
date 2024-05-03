// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sipevo/core.dart';

class SuccessAddKomplen extends StatefulWidget {
  const SuccessAddKomplen({Key? key}) : super(key: key);

  @override
  State<SuccessAddKomplen> createState() => _SuccessAddKomplenState();
}

class _SuccessAddKomplenState extends State<SuccessAddKomplen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(result: () => KomplenView()),
          icon: const Icon(
            Icons.arrow_back,
            size: 24.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/ceklis.png",
                  width: 100,
                  height: 100,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Yeayy! Pengaduan anda berhasil dibuat!",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
