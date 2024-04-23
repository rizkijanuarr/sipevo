import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sipevo/core.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class BerandaView extends StatelessWidget {
  const BerandaView({super.key});

  // URL tujuan
  final String _url = 'https://vokasi.unesa.ac.id/';

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BerandaController>(
      init: BerandaController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                color: Color(0xff0f9565),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                        ],
                      ),
                      const Positioned(
                        left: 20,
                        top: 20,
                        child: Text(
                          "Sistem\nPengaduan Vokasi",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Tambahkan widget Positioned baru di sini
                      Positioned(
                        right: 20,
                        top: 20,
                        child: Text(
                          DateFormat('dd MMMM yyyy')
                              .format(DateTime.now()), // Format tanggal
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 20,
                        top: 40, // Posisi di sudut kanan bawah
                        child: Text(
                          DateFormat('HH:mm')
                              .format(DateTime.now()), // Format jam
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      // menu
                      const Positioned(
                        bottom:
                            20, // Atau nilai lain untuk menyesuaikan posisi lebih ke atas
                        left: 0,
                        right: 0,
                        child: ExpandableContainer(),
                      ),
                    ],
                  ),
                ),
                // JARAK ANTARA ATASNYA TERLALU JAUH GIMANA NGATASINNYA BINGUNG SAYA BRO
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Aktivitas Terkini",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          final url = Uri.parse(_url);
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          } else {
                            // Handle the error or show a message if the URL can't be opened
                            print('Could not launch $url');
                          }
                        },
                        child: const Text(
                          "See all",
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Color(0xff0f9565),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Builder(builder: (context) {
                  List images = [
                    "https://statik.unesa.ac.id/profileunesa_konten_statik/uploads/vokasi/slider/abf2c0db-4944-45a9-9d34-fb20cd069e93.jpg",
                    "https://statik.unesa.ac.id/profileunesa_konten_statik/uploads/vokasi/slider/d4786e4f-080f-4791-8363-b2e6c34de9fa.jpg",
                    "https://statik.unesa.ac.id/profileunesa_konten_statik/uploads/vokasi/slider/896d0bb3-1968-4181-a3be-7bfc10660b3c.jpg",
                    "https://statik.unesa.ac.id/profileunesa_konten_statik/uploads/vokasi/slider/19c29562-f3d5-4864-b548-b5d900470cf4.jpg",
                    "https://statik.unesa.ac.id/profileunesa_konten_statik/uploads/vokasi/slider/750cfc60-1dd4-49fe-8d27-77c0a3e829e6.png",
                    "https://statik.unesa.ac.id/profileunesa_konten_statik/uploads/vokasi/slider/6db3180e-2c20-4fe9-9f1e-418adcaf3298.jpg",
                    "https://statik.unesa.ac.id/profileunesa_konten_statik/uploads/vokasi/slider/35886f28-17e0-412d-9ca0-d476339cc3e1.jpg"
                  ];

                  return Column(
                    children: [
                      CarouselSlider(
                        carouselController: controller.carouselController,
                        options: CarouselOptions(
                          height: 160.0,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) {
                            controller.currentIndex = index;
                            controller.update();
                          },
                        ),
                        items: images.map((imageUrl) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(6.0),
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      imageUrl,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: images.asMap().entries.map((entry) {
                          return GestureDetector(
                            onTap: () => controller.carouselController
                                .animateToPage(entry.key),
                            child: Container(
                              width: 12.0,
                              height: 12.0,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: (Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? const Color(0xff0f9565)
                                          : const Color(0xff0f9565).withOpacity(
                                              0.6,
                                            ))
                                      .withOpacity(
                                          controller.currentIndex == entry.key
                                              ? 0.9
                                              : 0.4)),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  );
                }),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .cardColor, // Ensure this matches your existing color
                      borderRadius:
                          BorderRadius.circular(20), // Added border radius
                    ),
                    child: Builder(
                      builder: (context) {
                        final List<Map> chartData = [
                          {
                            "year": "Pending",
                            "sales": 40,
                          },
                          {
                            "year": "Open",
                            "sales": 90,
                          },
                          {
                            "year": "Closed",
                            "sales": 30,
                          },
                        ];

                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Pengaduan", // Title text
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge, // Adjust the style as needed
                              ),
                              SfCircularChart(
                                legend: const Legend(isVisible: true),
                                series: <CircularSeries>[
                                  PieSeries<Map, String>(
                                    dataSource: chartData,
                                    dataLabelSettings: const DataLabelSettings(
                                      isVisible: true,
                                    ),
                                    xValueMapper: (Map data, _) => data["year"],
                                    yValueMapper: (Map data, _) =>
                                        data["sales"],
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
