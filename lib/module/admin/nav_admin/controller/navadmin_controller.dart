import 'package:get/get.dart';
import 'package:sipevo/core.dart';

class AdminController extends GetxController {
  NavAdmin? view;

  int selectedIndex = 0;
  updateIndex(int newIndex) {
    selectedIndex = newIndex;
    update();
  }
}
