import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sipevo/core.dart';
import 'package:get/get.dart';

class UpdateAccount extends StatelessWidget {
  const UpdateAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(
      init: AccountController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Profile"),
            leading: IconButton(
              onPressed: () => Get.back(result: () => AccountView()),
              icon: const Icon(
                Icons.arrow_back,
                size: 24.0,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    // // VIEW FOTO
                    InkWell(
                      onTap: () async {
                        try {
                          XFile? image = await ImagePicker().pickImage(
                            source: ImageSource.camera,
                            imageQuality: 40,
                          );
                          if (image != null) {
                            controller.selectedImage = image;
                            controller.update();
                          }
                        } catch (e) {
                          print("Error selecting image from camera: $e");
                        }
                      },
                      child: Column(
                        children: [
                          if (controller.selectedImage != null) ...[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.file(
                                File(controller.selectedImage!.path),
                                fit: BoxFit.cover,
                                width: 200.0,
                                height: 200.0,
                              ),
                            ),
                          ],
                          TextFormField(
                            controller: controller.photoController,
                            enabled: false,
                            decoration: const InputDecoration(
                              labelText: 'Photo',
                              labelStyle: TextStyle(
                                color: Colors.blueGrey,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blueGrey,
                                ),
                              ),
                              suffixIcon: Icon(Icons.image),
                            ),
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                    ),
                    // // VIEW FOTO
                    TextFormField(
                      validator: (value) =>
                          value == '' ? 'Jangan Kosong' : null,
                      controller: controller.nameController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      cursorColor: AppColors.primarySwatch,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(
                          color: Colors.blueGrey,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                      onChanged: (value) {},
                    ),
                    TextFormField(
                      validator: (value) =>
                          value == '' ? 'Jangan Kosong' : null,
                      controller: controller.nohpController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      cursorColor: AppColors.primarySwatch,
                      decoration: const InputDecoration(
                        labelText: 'No HP',
                        labelStyle: TextStyle(
                          color: Colors.blueGrey,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                      onChanged: (value) {},
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Hero(
                      tag: "updateprofilebtn",
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: AppColors.primarySwatch,
                          shape: const StadiumBorder(),
                          maximumSize: const Size(double.infinity, 46),
                          minimumSize: const Size(double.infinity, 46),
                        ),
                        onPressed: () async {
                          controller.updateProfile();
                        },
                        child: Text(
                          "Update".toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
