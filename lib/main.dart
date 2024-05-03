import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sipevo/core.dart';
import 'package:sipevo/module/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final String? token = await SharedPrefsHelper.getToken();
  final String? userRole = await SharedPrefsHelper.getUserRole();

  Get.put(LoginController());
  Widget startingWidget = SplashPage();

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

  // Change status bar color
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppColors.baseColor, // Sesuaikan dengan AppColors.baseColor
  ));

  runApp(MyApp(startingWidget: startingWidget));
}

class MyApp extends StatelessWidget {
  final Widget startingWidget;
  const MyApp({Key? key, required this.startingWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey[300],
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.baseColor,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0,
        ),
      ),
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor:
              AppColors.baseColor, // Sesuaikan dengan AppColors.baseColor
        ),
        child: startingWidget,
      ),
    );
  }
}
