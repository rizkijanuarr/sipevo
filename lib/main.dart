import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:sipevo/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final String? token = await SharedPrefsHelper.getToken();

  Get.put(LoginController());

  bool isTokenValid = false;
  if (token != null) {
    isTokenValid = !Jwt.isExpired(token);
    if (!isTokenValid) {
      await SharedPrefsHelper.removeToken();
    }
  }

  Widget startingWidget = isTokenValid ? MenusView() : SplashView();

  runApp(MyApp(startingWidget: startingWidget));
}

class MyApp extends StatelessWidget {
  final Widget startingWidget;
  const MyApp({Key? key, required this.startingWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetMaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.grey[100],
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
        home: startingWidget,
      ),
    );
  }
}
