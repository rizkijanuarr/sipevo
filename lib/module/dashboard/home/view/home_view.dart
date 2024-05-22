import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sipevo/core.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        controller.view = this;

        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "SIPEVO",
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Melayani informasi sarana dan prasarana pada Vokasi.",
                                    style: TextStyle(
                                      fontSize: 10.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: const ImageIcon(
                                AssetImage(
                                  "assets/base-logo.png",
                                ),
                                size: 24.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Builder(builder: (context) {
                          List images = [
                            "https://statik.unesa.ac.id/profileunesa_konten_statik/uploads/vokasi/slider/896d0bb3-1968-4181-a3be-7bfc10660b3c.jpg",
                            "https://statik.unesa.ac.id/profileunesa_konten_statik/uploads/vokasi/slider/abf2c0db-4944-45a9-9d34-fb20cd069e93.jpg",
                            "https://statik.unesa.ac.id/profileunesa_konten_statik/uploads/vokasi/slider/d4786e4f-080f-4791-8363-b2e6c34de9fa.jpg",
                            "https://statik.unesa.ac.id/profileunesa_konten_statik/uploads/vokasi/slider/19c29562-f3d5-4864-b548-b5d900470cf4.jpg",
                            "https://statik.unesa.ac.id/profileunesa_konten_statik/uploads/vokasi/slider/6db3180e-2c20-4fe9-9f1e-418adcaf3298.jpg",
                            "https://statik.unesa.ac.id/profileunesa_konten_statik/uploads/vokasi/slider/35886f28-17e0-412d-9ca0-d476339cc3e1.jpg"
                          ];

                          return Column(
                            children: [
                              CarouselSlider(
                                carouselController:
                                    controller.carouselController,
                                options: CarouselOptions(
                                  height: 180.0,
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
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
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
                                          color:
                                              (Theme.of(context).brightness ==
                                                          Brightness.dark
                                                      ? AppColors.baseColor
                                                      : AppColors.baseColor
                                                          .withOpacity(
                                                          0.6,
                                                        ))
                                                  .withOpacity(
                                                      controller.currentIndex ==
                                                              entry.key
                                                          ? 0.9
                                                          : 0.4)),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          );
                        }),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Categories",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => Get.to(CategoriesView()),
                              child: Text(
                                "See all >",
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        GridView.builder(
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1.0 / 0.3,
                            crossAxisCount: 2,
                            mainAxisSpacing: 6,
                            crossAxisSpacing: 6,
                          ),
                          itemCount: controller.categories.length,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            PengaduanCategory category =
                                controller.categories[index];
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                color: Colors.grey[300],
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        _showCategoryDialog(context, category);
                                      },
                                      child: Text(
                                        category.name,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // CATEGORIES
  void _showCategoryDialog(BuildContext context, PengaduanCategory category) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(category.name),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(category.image),
              Text('Name: ${category.name}'),
              Text('Slug: ${category.slug}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
