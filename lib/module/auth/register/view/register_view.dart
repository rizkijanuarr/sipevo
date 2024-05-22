import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
      init: RegisterController(),
      builder: (controller) {
        return Theme(
          data: ThemeData(
            primaryColor: const Color(0xff0f9565),
            scaffoldBackgroundColor: Colors.white,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: AppColors.baseColor,
                shape: const StadiumBorder(),
                maximumSize: const Size(double.infinity, 56),
                minimumSize: const Size(double.infinity, 56),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Colors.grey[100],
              iconColor: AppColors.baseColor,
              prefixIconColor: AppColors.baseColor,
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
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/logo-unesa.png",
                                    width: 60,
                                    height: 60,
                                  ),
                                  const SizedBox(width: 5.0),
                                  Image.asset(
                                    "assets/logo-vokasi.png",
                                    width: 100,
                                    height: 100,
                                  ),
                                  const SizedBox(width: 5.0),
                                  Image.asset(
                                    "assets/zee.png",
                                    width: 70,
                                    height: 70,
                                  ),
                                ],
                              ),
                              const Text(
                                "SISTEM PENGADUAN VOKASI",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 32.0),
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
                                        controller: controller.nameController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        textInputAction: TextInputAction.next,
                                        cursorColor: AppColors.baseColor,
                                        decoration: const InputDecoration(
                                          hintText: "Name",
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Icon(Icons.person),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16.0),
                                      TextFormField(
                                        validator: (value) => value == ''
                                            ? 'Jangan Kosong'
                                            : null,
                                        controller: controller.noHpController,
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.next,
                                        cursorColor: AppColors.baseColor,
                                        decoration: const InputDecoration(
                                          hintText: "No. Phone",
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Icon(Icons.phone_android),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16.0),
                                      TextFormField(
                                        validator: (value) => value == ''
                                            ? 'Jangan Kosong'
                                            : null,
                                        controller:
                                            controller.noIndukController,
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.next,
                                        cursorColor: AppColors.baseColor,
                                        decoration: const InputDecoration(
                                          hintText: "No Induk",
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Icon(Icons.badge),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16.0),
                                      TextFormField(
                                        validator: (value) => value == ''
                                            ? 'Jangan Kosong'
                                            : null,
                                        controller: controller.emailController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        textInputAction: TextInputAction.next,
                                        cursorColor: AppColors.baseColor,
                                        decoration: const InputDecoration(
                                          hintText: "Email",
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Icon(Icons.email),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16.0),
                                      TextFormField(
                                        validator: (value) => value == ''
                                            ? 'Jangan Kosong'
                                            : null,
                                        controller:
                                            controller.passwordController,
                                        textInputAction: TextInputAction.done,
                                        obscureText: !controller.showPassword,
                                        cursorColor: AppColors.baseColor,
                                        decoration: InputDecoration(
                                          hintText: "Password",
                                          prefixIcon: const Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Icon(Icons.lock),
                                          ),
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: IconButton(
                                              icon: Icon(
                                                controller.showPassword
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: Colors.grey,
                                              ),
                                              onPressed: () {
                                                controller
                                                    .togglePasswordVisibility();
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16.0),
                                      TextFormField(
                                        validator: (value) => value == ''
                                            ? 'Jangan Kosong'
                                            : null,
                                        controller: controller
                                            .passwordConfirmationController,
                                        textInputAction: TextInputAction.done,
                                        obscureText: !controller.showPassword,
                                        cursorColor: AppColors.baseColor,
                                        decoration: InputDecoration(
                                          hintText: "Password Confirmation",
                                          prefixIcon: const Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Icon(Icons.lock),
                                          ),
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: IconButton(
                                              icon: Icon(
                                                controller.showPassword
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: Colors.grey,
                                              ),
                                              onPressed: () {
                                                controller
                                                    .togglePasswordVisibility();
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16.0),
                                      DropdownButtonFormField<String>(
                                        value: controller.selectedRole,
                                        onChanged: controller.onRoleChanged,
                                        items: controller.roles
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        decoration: const InputDecoration(
                                          hintText: "Role",
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Icon(Icons.group),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16.0),
                                      Hero(
                                        tag: "register_button",
                                        child: ElevatedButton(
                                          onPressed: controller.register,
                                          child: Text(
                                            "Register".toUpperCase(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20.0),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          const Text(
                                            "Have an Account ? ",
                                            style: TextStyle(),
                                          ),
                                          InkWell(
                                            onTap: () =>
                                                Get.offAll(() => LoginView()),
                                            child: const Text(
                                              "Login",
                                              style: TextStyle(
                                                color: AppColors.baseColor,
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
