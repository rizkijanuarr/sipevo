import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sipevo/core.dart';
import '../controller/tambah_komplen_controller.dart';
import 'package:get/get.dart';

class TambahKomplenView extends StatelessWidget {
  const TambahKomplenView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TambahKomplenController>(
      init: TambahKomplenController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Tambah Komplen"),
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
                      controller: controller.subjectController,
                      maxLength: 30,
                      decoration: const InputDecoration(
                        labelText: 'Subject',
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
                      controller: controller.descriptionController,
                      maxLength: 255,
                      decoration: const InputDecoration(
                        labelText: 'Description',
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
                    DropdownButtonFormField<String>(
                      value: controller.selectedLocation,
                      onChanged: (String? newValue) {
                        controller.selectedLocation = newValue!;
                        controller.update();
                      },
                      items: controller.locationItems
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: const InputDecoration(
                        hintText: "Ruang",
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Icon(Icons.school),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Hero(
                      tag: "login_btn",
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: AppColors.primarySwatch,
                          shape: const StadiumBorder(),
                          maximumSize: const Size(double.infinity, 46),
                          minimumSize: const Size(double.infinity, 46),
                        ),
                        onPressed: () async {
                          controller.addComplaint();
                        },
                        child: Text(
                          "Tambahkan".toUpperCase(),
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
