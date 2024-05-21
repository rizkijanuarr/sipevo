import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../controller/create_controller.dart';
import 'package:sipevo/core.dart';

class CreateView extends StatelessWidget {
  const CreateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateController>(
      init: CreateController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Create"),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20.0),
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
                            var imageFile = File(image.path);
                            final fileSize = await imageFile.length();
                            if (fileSize > 2000000) {
                              // lebih dari 2MB
                              print('Error: File size exceeds 2MB');
                              return;
                            }
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
                    DropdownButtonFormField<String>(
                      items: controller.categories.map((category) {
                        return DropdownMenuItem<String>(
                          value: category.id.toString(),
                          child: Text(category.name),
                        );
                      }).toList(),
                      onChanged: controller.onCategoryChanged,
                      value: controller.selectedCategory,
                      decoration: InputDecoration(labelText: 'Category'),
                    ),
                    TextFormField(
                      controller: controller.titleController,
                      decoration: InputDecoration(labelText: 'Title'),
                    ),
                    TextFormField(
                      controller: controller.descriptionController,
                      decoration: InputDecoration(labelText: 'Description'),
                    ),
                    TextFormField(
                      controller: controller.locationController,
                      decoration: InputDecoration(labelText: 'Location'),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Hero(
                      tag: "simpan",
                      child: ElevatedButton(
                        onPressed: () async {
                          controller.submit();
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.baseColor),
                        ),
                        child: Text(
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          "Tambahkan".toUpperCase(),
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
