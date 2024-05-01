import 'package:flutter/material.dart';
import 'package:sipevo/module/operator/akun/view/akun_view.dart';
import 'package:sipevo/module/operator/komplain/view/komplain_view.dart';
import '../controller/navbarop_controller.dart';
import 'package:sipevo/core.dart';
import 'package:get/get.dart';

class NavbaropView extends StatelessWidget {
  const NavbaropView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavbaropController>(
      init: NavbaropController(),
      builder: (controller) {
        controller.view = this;

        List<Map<String, dynamic>> menus = [
          {
            "icon": Icons.home,
            "label": "Beranda",
          },
          {
            "icon": Icons.work,
            "label": "List Complaints",
          },
          {
            "icon": Icons.history,
            "label": "List Logs",
          },
          {
            "icon": Icons.person,
            "label": "Profile",
          }
        ];

        return DefaultTabController(
          length: 5,
          initialIndex: controller.selectedIndex,
          child: Scaffold(
            body: IndexedStack(
              index: controller.selectedIndex,
              children: const [
                HomeView(),
                KomplainView(),
                LogsSystemView(),
                AkunView(),
              ],
            ),
            bottomNavigationBar: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20.0)),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 5.0,
                      spreadRadius: 2.0,
                      offset: const Offset(0, -3),
                    ),
                  ],
                ),
                child: BottomAppBar(
                  elevation: 0,
                  color: Colors.transparent,
                  child: SizedBox(
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: menus.map((menu) {
                        final int index = menus.indexOf(menu);
                        return GestureDetector(
                          onTap: () => controller.updateIndex(index),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                menu["icon"] as IconData,
                                color: index == controller.selectedIndex
                                    ? AppColors.baseColor
                                    : Colors.grey,
                              ),
                              if (index == controller.selectedIndex)
                                Text(
                                  menu["label"] as String,
                                  style: const TextStyle(
                                      color: AppColors.baseColor),
                                ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
