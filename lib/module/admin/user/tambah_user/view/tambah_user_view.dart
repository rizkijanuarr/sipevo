import 'package:flutter/material.dart';
import '../controller/tambah_user_controller.dart';
import 'package:sipevo/core.dart';
import 'package:get/get.dart';

class TambahUserView extends StatelessWidget {
  const TambahUserView({Key? key});

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
                      validator: (value) =>
                          value == '' ? 'Jangan Kosong' : null,
                      controller: controller.controllerName,
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
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      validator: (value) =>
                          value == '' ? 'Jangan Kosong' : null,
                      controller: controller.controllerNohp,
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
                      ),
                      onChanged: (value) {},
                    ),

                    const SizedBox(
                      height: 20.0,
                    ),

                    TextFormField(
                      validator: (value) =>
                          value == '' ? 'Jangan Kosong' : null,
                      controller: controller.controllerPass,
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
                      ),
                      onChanged: (value) {},
                    ),

                    const SizedBox(
                      height: 20.0,
                    ),

                    // DROPDOWN ROLES
                    DropdownButton<String>(
                      value: controller.selectedRoles,
                      hint: const Text('Pilih Roles'),
                      items: controller.rolesItems.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value.substring(0, 1).toUpperCase() +
                                value.substring(1),
                            style: const TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        controller.updateSelectedRoles(value);
                      },
                      style: const TextStyle(color: Colors.black),
                      dropdownColor: Colors.white,
                      isExpanded: true,
                    ),

                    const SizedBox(
                      height: 20.0,
                    ),

                    // DROPDOWN mahasiswa_angkatan
                    DropdownButton<String>(
                      value: controller.selectedAngkatan,
                      hint: const Text('Pilih Angkatan'),
                      icon: const Icon(Icons.arrow_drop_down),
                      items: controller.angkatanItems.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        controller.updateSelectedAngkatan(value);
                      },
                      style: const TextStyle(color: Colors.black),
                      dropdownColor: Colors.white,
                      isExpanded: true,
                    ),

                    const SizedBox(
                      height: 20.0,
                    ),

                    // DROPDOWN prodi
                    DropdownButton<String>(
                      value: controller.selectedProdi,
                      hint: const Text('Pilih Prodi'),
                      items: controller.prodiItems.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        controller.updateSelectedProdi(value);
                      },
                      style: const TextStyle(color: Colors.black),
                      dropdownColor: Colors.white,
                      isExpanded: true,
                    ),

                    const SizedBox(
                      height: 20.0,
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: AppColors.baseColor,
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
