import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sipevo/core.dart';
import 'package:sipevo/module/mahasiswa/dashboard/widget/dot.dart';

class Meynu extends StatefulWidget {
  const Meynu({
    super.key,
  });

  @override
  _MeynuState createState() => _MeynuState();
}

class _MeynuState extends State<Meynu> {
  bool isExpanded = false;

  final List<Map<String, dynamic>> iconLabels = [
    {'icon': Icons.work_outline_outlined, 'label': 'Complaints'},
    {'icon': Icons.person_outline, 'label': 'Profile'},
  ];

  final List<Widget> pages = [
    const KomplenView(),
    const AccountView(),
  ];

  final DashboardController controller = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: isExpanded ? 200 : 130,
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: const [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 24,
              offset: Offset(0, 11),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Text(
                      "Your role as :",
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                  Obx(() => Text(controller.userRole.value ?? 'mahasiswa')),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Dot(
                color: AppColors.primarySwatch,
                strokeWidth: 2.0,
                dashPattern: const [10.0, 10.0],
                gap: 2.0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.stretch, // Expanded ke bawah
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: iconLabels
                          .map((item) => GestureDetector(
                                onTap: () {
                                  // Menavigasi ke halaman tertentu saat ikon diklik
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => pages[
                                          iconLabels.indexWhere((e) =>
                                              e['label'] == item['label'])],
                                    ),
                                  );
                                },
                                child: _buildIconWithLabel(
                                  item['icon'] as IconData,
                                  item['label'] as String,
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconWithLabel(IconData icon, String label) {
    return Column(
      children: [
        Icon(
          icon,
          size: 24.0,
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10.0,
          ),
        ),
      ],
    );
  }
}
