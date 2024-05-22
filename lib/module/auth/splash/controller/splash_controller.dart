import 'package:get/get.dart';
import 'package:sipevo/core.dart';


class SplashController extends GetxController {
  SplashView? view;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _startLoading();
  }

  void _startLoading() async {
    // Simulasi proses loading
    await Future.delayed(Duration(seconds: 3));
    isLoading.value = false;

    Get.off(() => LoginView());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
