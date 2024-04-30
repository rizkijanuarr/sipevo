import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sipevo/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final String? token = await SharedPrefsHelper.getToken();
  final String? userRole = await SharedPrefsHelper.getUserRole();

  Get.put(LoginController());
  Widget startingWidget = const LoginView();

  if (token != null && userRole != null) {
    switch (userRole) {
      case 'admin':
        startingWidget = const NavAdmin();
        break;
      case 'operator':
        startingWidget = const NavbaropView();
        break;
      case 'mahasiswa':
        startingWidget = const NavbarmhsView();
        break;
    }
  }

  runApp(MyApp(startingWidget: startingWidget));
}

class MyApp extends StatelessWidget {
  final Widget startingWidget;
  const MyApp({Key? key, required this.startingWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey[300],
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primarySwatch,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0,
        ),
      ),
      home: startingWidget,
    );
  }
}
