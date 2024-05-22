import 'package:flutter/material.dart';
import 'package:sipevo/core.dart';
import 'package:get/get.dart';

class MenusView extends StatelessWidget {
  const MenusView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MenusController>(
      init: MenusController(),
      builder: (controller) {
        controller.view = this;

        List<Widget> pages = [
          HomeView(),
          CategoriesView(),
          StatusView(),
          PengaduanView(),
        ];

        List<Map<String, dynamic>> menus = [
          {
            "icon": Icons.home,
            "label": "Home",
          },
          {
            "icon": Icons.category,
            "label": "Categories",
          },
          {
            "icon": Icons.list,
            "label": "Status",
          },
          {
            "icon": Icons.track_changes_sharp,
            "label": "Pengaduan",
          }
        ];

        return DefaultTabController(
          length: pages.length,
          initialIndex: controller.selectedIndex,
          child: Scaffold(
            body: IndexedStack(
              index: controller.selectedIndex,
              children: pages,
            ),
            bottomNavigationBar: BottomAppBar(
              padding: const EdgeInsets.all(0.0),
              shape: CircularNotchedRectangle(), // Membuat notch
              child: Container(
                height: 58,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(menus.length, (index) {
                    var item = menus[index];
                    bool selected = index == controller.selectedIndex;
                    if ((menus.length / 2).floor() == index) {}

                    return Expanded(
                      child: AnimatedScale(
                        duration: const Duration(milliseconds: 400),
                        scale: selected ? 1.2 : 1.0,
                        child: IconButton(
                          onPressed: () => controller.updateIndex(index),
                          icon: Icon(
                            item["icon"],
                            color: selected
                                ? AppColors.baseColor
                                : AppColors.baseColor.withOpacity(0.4),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            floatingActionButton: Container(
              child: FloatingActionButton(
                backgroundColor: AppColors.baseColor,
                onPressed: () => Get.to(() => CreateView()),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          ),
        );
      },
    );
  }
}
