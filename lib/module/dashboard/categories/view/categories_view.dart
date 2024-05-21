import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/PengaduanCategory.dart';
import '../controller/categories_controller.dart';
import 'package:sipevo/core.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoriesController>(
      init: CategoriesController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Categories"),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () => controller.refreshCategories(),
                  icon: const Icon(Icons.refresh),
                ),
              ),
            ],
          ),
          body: controller.categories.isEmpty
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: controller.categories.length,
                  itemBuilder: (context, index) {
                    PengaduanCategory category = controller.categories[index];
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      elevation: 1,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(category.image),
                        ),
                        title: Text(category.name),
                        subtitle: Text(category.slug),
                        onTap: () {
                          _showCategoryDialog(context, category);
                        },
                      ),
                    );
                  },
                ),
        );
      },
    );
  }

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
