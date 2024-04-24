import 'package:get/get.dart';
import '../view/navbarmhs_view.dart';

class NavbarmhsController extends GetxController {
  NavbarmhsView? view;

  int selectedIndex = 0;
  updateIndex(int newIndex) {
    selectedIndex = newIndex;
    update();
  }
}
