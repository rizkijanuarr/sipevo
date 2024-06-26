import 'package:flutter/material.dart';
import 'package:sipevo/core.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (controller) {
        controller.view = this;

        return Theme(
          data: ThemeData(
            primaryColor: AppColors.baseColor,
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
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Image.asset(
                                    "assets/logo-vokasi.png",
                                    width: 100,
                                    height: 100,
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  Image.asset(
                                    "assets/zee.png",
                                    width: 70,
                                    height: 70,
                                  ),
                                ],
                              ),
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
                                        controller: controller.controllerEmail,
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.next,
                                        cursorColor: AppColors.baseColor,
                                        onSaved: (email) {},
                                        decoration: const InputDecoration(
                                          hintText: "Your Email",
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Icon(Icons.person),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16.0),
                                        child: TextFormField(
                                          validator: (value) => value == ''
                                              ? 'Jangan Kosong'
                                              : null,
                                          controller:
                                              controller.controllerPassword,
                                          textInputAction: TextInputAction.done,
                                          obscureText: !controller.showPassword,
                                          cursorColor: AppColors.baseColor,
                                          decoration: InputDecoration(
                                            hintText: "Your password",
                                            prefixIcon: const Padding(
                                              padding: EdgeInsets.all(16.0),
                                              child: Icon(Icons.lock),
                                            ),
                                            suffixIcon: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                      ),
                                      const SizedBox(height: 16.0),
                                      Hero(
                                        tag: "login_button",
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            await controller.login();
                                          },
                                          child: Text(
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            "Login".toUpperCase(),
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
                                            "Don’t have an Account ? ",
                                            style: TextStyle(),
                                          ),
                                          InkWell(
                                            onTap: () => Get.offAll(
                                                () => RegisterView()),
                                            child: const Text(
                                              "Sign Up",
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
