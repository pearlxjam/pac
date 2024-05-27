import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pac/controller/controllers.dart';
import 'package:pac/view/view.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (categoryController.categoryList.isNotEmpty) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Dos columnas
            childAspectRatio: 0.9, // Proporción de aspecto para ajustar las tarjetas
          ),
          physics: const BouncingScrollPhysics(),
          itemCount: categoryController.categoryList.length,
          itemBuilder: (context, index) => CategoryCard(category: categoryController.categoryList[index]),
        );
      } else {
        return Container();
      }
    });
  }
}
