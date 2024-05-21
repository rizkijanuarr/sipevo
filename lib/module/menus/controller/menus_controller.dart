import 'package:get/get.dart';
import '../view/menus_view.dart';

class MenusController extends GetxController {
  MenusView? view;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  int selectedIndex = 0;
  updateIndex(int newIndex) {
    selectedIndex = newIndex;
    update();
  }
}
