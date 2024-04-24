import 'package:flutter/material.dart';
import 'package:sipevo/core.dart';
import 'package:get/get.dart';

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
                backgroundColor: const Color(0xff0f9565),
                shape: const StadiumBorder(),
                maximumSize: const Size(double.infinity, 56),
                minimumSize: const Size(double.infinity, 56),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: const Color(0xff0f9565).withOpacity(0.1),
              iconColor: const Color(0xFF6F35A5),
              prefixIconColor: const Color(0xff0f9565),
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
                                        cursorColor: const Color(0xff0f9565),
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
                                        cursorColor: const Color(0xff0f9565),
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
                                        controller: controller.controllerEmail,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        textInputAction: TextInputAction.next,
                                        cursorColor: const Color(0xff0f9565),
                                        onSaved: (email) {},
                                        decoration: const InputDecoration(
                                          hintText: "Email",
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Icon(Icons.email),
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
                                        obscureText: true,
                                        cursorColor: const Color(0xff0f9565),
                                        decoration: const InputDecoration(
                                          hintText: "Password",
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Icon(Icons.lock),
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
                                        controller:
                                            controller.controllerAddress,
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.next,
                                        cursorColor: const Color(0xff0f9565),
                                        onSaved: (address) {},
                                        decoration: const InputDecoration(
                                          hintText: "Address",
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Icon(Icons.location_on),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16.0),
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
                                                color: Color(0xff0f9565),
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
