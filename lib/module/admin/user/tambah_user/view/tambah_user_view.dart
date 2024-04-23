import 'package:flutter/material.dart';
import '../controller/tambah_user_controller.dart';
import 'package:sipevo/core.dart';
import 'package:get/get.dart';

class TambahUserView extends StatelessWidget {
  const TambahUserView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TambahUserController>(
      init: TambahUserController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Tambah User"),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    TextFormField(
                      // enabled: widget.job == null ? true : false,
                      validator: (value) =>
                          value == '' ? 'Jangan Kosong' : null,
                      controller: controller.controllerName,
                      maxLength: 255,
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
                        helperText: "Contoh: Aan Citra",
                      ),
                      onChanged: (value) {},
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      // enabled: widget.job == null ? true : false,
                      validator: (value) =>
                          value == '' ? 'Jangan Kosong' : null,
                      controller: controller.controllerNohp,
                      maxLength: 255,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'No Hp',
                        labelStyle: TextStyle(
                          color: Colors.blueGrey,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueGrey,
                          ),
                        ),
                        helperText: "Contoh: 081234567890",
                      ),
                      onChanged: (value) {},
                    ),
                    TextFormField(
                      // enabled: widget.job == null ? true : false,
                      validator: (value) =>
                          value == '' ? 'Jangan Kosong' : null,
                      controller: controller.controllerEmail,
                      maxLength: 255,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: Colors.blueGrey,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueGrey,
                          ),
                        ),
                        helperText: "Contoh: WjFJt@example.com",
                      ),
                      onChanged: (value) {},
                    ),
                    TextFormField(
                      // enabled: widget.job == null ? true : false,
                      validator: (value) =>
                          value == '' ? 'Jangan Kosong' : null,
                      controller: controller.controllerPass,
                      maxLength: 8,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Pass',
                        labelStyle: TextStyle(
                          color: Colors.blueGrey,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueGrey,
                          ),
                        ),
                        helperText: "Contoh: rahasia123",
                      ),
                      onChanged: (value) {},
                    ),
                    // DROPDOWN
                    Obx(
                      () => DropdownButton<String>(
                        value: controller.selectedRole.value,
                        items: controller.roles.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style: const TextStyle(color: Colors.black)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          controller.selectedRole.value = value!;
                        },
                        style: const TextStyle(color: Colors.black),
                        dropdownColor: Colors.white,
                        isExpanded: true,
                      ),
                    ),
                    // END OF DROPDOWN
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      // enabled: widget.job == null ? true : false,
                      validator: (value) =>
                          value == '' ? 'Jangan Kosong' : null,
                      controller: controller.controllerAddress,
                      maxLength: 255,
                      decoration: const InputDecoration(
                        labelText: 'Address',
                        labelStyle: TextStyle(
                          color: Colors.blueGrey,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueGrey,
                          ),
                        ),
                        helperText:
                            "Contoh: Tangsel, Kec. Ciputat, Tangerang Selatan",
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
                          await controller.addUser();
                        },
                        child: Text(
                          "Simpan".toUpperCase(),
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
