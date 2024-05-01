import 'package:flutter/material.dart';
import '../controller/update_user_controller.dart';
import 'package:sipevo/core.dart';
import 'package:get/get.dart';

class UpdateUserView extends StatelessWidget {
  const UpdateUserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpdateUserController>(
      init: UpdateUserController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Update User"),
          ),
          body: Form(
            key: controller.formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                TextFormField(
                  controller: controller.controllerId,
                  decoration: const InputDecoration(labelText: 'ID'),
                  enabled: false, // ID tidak perlu diubah
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: controller.controllerName,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: controller.controllerNohp,
                  decoration: const InputDecoration(labelText: 'No HP'),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: controller.controllerPass,
                  decoration: const InputDecoration(labelText: 'Pass'),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Obx(() => DropdownButtonFormField<String>(
                      value: controller.selectedRole.value,
                      onChanged: (newValue) {
                        controller.selectedRole.value = newValue!;
                      },
                      items: controller.rolesItems
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: const InputDecoration(labelText: 'Role'),
                    )),
                const SizedBox(
                  height: 20.0,
                ),
                Obx(() => DropdownButtonFormField<String>(
                      value: controller.selectedAngkatan.value,
                      onChanged: (newValue) {
                        controller.selectedAngkatan.value = newValue!;
                      },
                      items: controller.angkatanItems
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: const InputDecoration(labelText: 'Angkatan'),
                    )),
                const SizedBox(
                  height: 20.0,
                ),
                Obx(() => DropdownButtonFormField<String>(
                      value: controller.selectedProdi.value,
                      onChanged: (newValue) {
                        controller.selectedProdi.value = newValue!;
                      },
                      items: controller.prodiItems
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: const InputDecoration(labelText: 'Prodi'),
                    )),
                const SizedBox(
                  height: 20.0,
                ),
                Hero(
                  tag: "update_user",
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: AppColors.baseColor,
                      shape: const StadiumBorder(),
                      maximumSize: const Size(double.infinity, 46),
                      minimumSize: const Size(double.infinity, 46),
                    ),
                    onPressed: () async {
                      if (controller.formKey.currentState!.validate()) {
                        controller.updateUser();
                      }
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
        );
      },
    );
  }
}
