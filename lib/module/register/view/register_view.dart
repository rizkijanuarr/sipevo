import 'package:flutter/material.dart';
import 'package:sipevo/core.dart';
import 'package:get/get.dart';
import 'package:sipevo/util/color.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
      init: RegisterController(),
      builder: (controller) {
        controller.view = this;

        return Theme(
          data: ThemeData(
            primaryColor: const Color(0xff0f9565),
            scaffoldBackgroundColor: Colors.white,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: AppColors.primarySwatch,
                shape: const StadiumBorder(),
                maximumSize: const Size(double.infinity, 56),
                minimumSize: const Size(double.infinity, 56),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: AppColors.primarySwatch[50],
              iconColor: AppColors.primarySwatch,
              prefixIconColor: AppColors.primarySwatch,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Column(
                            children: [
                              Text(
                                "SISTEM PENGADUAN VOKASI",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16.0 * 2),
                            ],
                          ),
                          Row(
                            children: [
                              const Spacer(),
                              Expanded(
                                flex: 8,
                                child: Form(
                                  key: controller.formKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        validator: (value) => value == ''
                                            ? 'Jangan Kosong'
                                            : null,
                                        controller: controller.controllerName,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        textInputAction: TextInputAction.next,
                                        cursorColor: AppColors.primarySwatch,
                                        onSaved: (name) {},
                                        decoration: const InputDecoration(
                                          hintText: "Name",
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Icon(Icons.person),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16.0,
                                      ),
                                      TextFormField(
                                        validator: (value) => value == ''
                                            ? 'Jangan Kosong'
                                            : null,
                                        controller: controller.controllerNohp,
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.next,
                                        cursorColor: AppColors.primarySwatch,
                                        onSaved: (phone) {},
                                        decoration: const InputDecoration(
                                          hintText: "No. Phone",
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Icon(Icons.phone_android),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16.0,
                                      ),
                                      TextFormField(
                                        validator: (value) => value == ''
                                            ? 'Jangan Kosong'
                                            : null,
                                        controller: controller.controllerPass,
                                        textInputAction: TextInputAction.done,
                                        obscureText: !controller
                                            .showPassword, // Toggle based on controller state
                                        cursorColor: AppColors.primarySwatch,
                                        decoration: InputDecoration(
                                          hintText: "Password",
                                          prefixIcon: const Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Icon(Icons.lock),
                                          ),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              // Toggle the icon dynamically
                                              controller.showPassword
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: AppColors.primarySwatch,
                                            ),
                                            onPressed: () {
                                              // Update the state to show or hide the password
                                              controller
                                                  .togglePasswordVisibility();
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16.0,
                                      ),
                                      DropdownButtonFormField<String>(
                                        value: controller.selectedAngkatan,
                                        onChanged: (String? newValue) {
                                          controller.selectedAngkatan =
                                              newValue!;
                                          controller.update();
                                        },
                                        items: controller.angkatanItems
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        decoration: const InputDecoration(
                                          hintText: "Mahasiswa Angkatan",
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Icon(Icons.school),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16.0),
                                      DropdownButtonFormField<String>(
                                        value: controller.selectedProdi,
                                        onChanged: (String? newValue) {
                                          controller.selectedProdi = newValue!;
                                          controller.update();
                                        },
                                        items: controller.prodiItems
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        decoration: const InputDecoration(
                                          hintText: "Prodi",
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Icon(Icons.book),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16.0,
                                      ),
                                      Hero(
                                        tag: "login_btn",
                                        child: ElevatedButton(
                                          onPressed: () {
                                            if (controller.formKey.currentState!
                                                .validate()) {
                                              controller.registerUser();
                                            }
                                          },
                                          child: Text(
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            "Register".toUpperCase(),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          const Text(
                                            "Have an Account ? ",
                                            style: TextStyle(),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              try {
                                                print(
                                                    "Navigating to LoginView");
                                                Get.back(canPop: true);
                                              } catch (e) {
                                                print(
                                                    "Error navigating to LoginView: $e");
                                              }
                                            },
                                            child: const Text(
                                              "Login",
                                              style: TextStyle(
                                                color: AppColors.primarySwatch,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
