import 'package:get/get.dart';
import '../view/navbarop_view.dart';

class NavbaropController extends GetxController {
  NavbaropView? view;

  int selectedIndex = 0;
  updateIndex(int newIndex) {
    selectedIndex = newIndex;
    update();
  }
}
