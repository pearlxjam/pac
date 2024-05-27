import 'package:flutter/material.dart';
import 'package:pac/model/modelos.dart';
import 'package:pac/view/view.dart';

class PopularProduct extends StatelessWidget {
  final List<Product> popularProducts;
  const PopularProduct({super.key, required this.popularProducts});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.31,
      padding: const EdgeInsets.only(right: 10),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: popularProducts.length,
          itemBuilder: (context, index) => PopularProductCard(product: popularProducts[index])),
    );
  }
}
