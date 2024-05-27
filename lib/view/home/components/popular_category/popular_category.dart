import 'package:flutter/material.dart';
import 'package:pac/model/modelos.dart';
import 'package:pac/view/view.dart';

class PopularCategory extends StatelessWidget {
  final List<Category> categories;
  const PopularCategory({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.23,
      padding: const EdgeInsets.only(right: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        itemBuilder: (context, index) => PopularCategoryCard(category: categories[index]),
      ),
    );
  }
}
