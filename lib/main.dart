import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sipevo/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final String? token = await SharedPrefsHelper.getToken();
  final String? userRole = await SharedPrefsHelper.getUserRole();

  Widget startingWidget = const LoginView(); // Default ke LoginView
  if (token != null && userRole != null) {
    switch (userRole) {
      case 'admin':
        startingWidget = const NavAdmin(); // Navigasi ke Beranda Admin
        break;
      // Tambahkan case untuk role lainnya
    }
  }

  runApp(MyApp(startingWidget: startingWidget));
}

class MyApp extends StatelessWidget {
  final Widget startingWidget;
  const MyApp({super.key, required this.startingWidget});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff0f9565),
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0,
        ),
      ),
      home: startingWidget, // Gunakan startingWidget sebagai halaman awal
      getPages: [
        GetPage(
            name: '/login',
            page: () => const LoginView()), // Definisikan rute untuk LoginView
        // Tambahkan definisi rute lainnya di sini
      ],
    );
  }
}
