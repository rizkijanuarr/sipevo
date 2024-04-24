import 'package:flutter/material.dart';
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
                        helperText: "Contoh: AC Rusak!",
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
                        helperText: "Contoh: Lorem ipsum dolor si amet.",
                      ),
                      onChanged: (value) {},
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Hero(
                      tag: "login_btn",
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: const Color(0xff0f9565),
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
