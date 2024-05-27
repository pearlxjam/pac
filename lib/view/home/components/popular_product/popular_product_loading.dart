import 'package:flutter/material.dart';
import 'package:pac/view/view.dart';

class PopularProductLoading extends StatelessWidget {
  const PopularProductLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      padding: const EdgeInsets.only(right: 10),
      child: ListView.builder(scrollDirection: Axis.horizontal, physics: const BouncingScrollPhysics(), itemCount: 5, itemBuilder: (context, index) => const PopularProductLoadingCard()),
    );
  }
}
