import 'package:finanseeup/models/model_category.dart';
import 'package:finanseeup/utils/helpers/icon_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CategoryModel> categories = [
      CategoryModel(name: "Shopping & Food",icon: IconHelper.iconName(Icons.shop)),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return ListTile(
            title: Text(category.name!),
            leading: Icon(
               IconHelper.iconFromName(category.icon!) ?? Icons.category,
            ),
            onTap: () {
              Get.back(result: category); // Return the selected account to the previous screen
            },
          );
        },
      ),
    );
  }
}
