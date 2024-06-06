import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pac/const/const.dart';
import 'package:pac/model/modelos.dart';
import 'package:pac/view/view.dart';
import 'package:shimmer/shimmer.dart';

class PopularProductCard extends StatelessWidget {
  final Product product;
  const PopularProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
      child: InkWell(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(product: product),
            ),
          );
        },
        child: Material(
          color: rojo,
          elevation: 5,
          shadowColor: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            width: MediaQuery.of(context).size.width * 0.45,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: 120,
                  color: Colors.white,
                  child: CachedNetworkImage(
                    width: 200,
                    height: 120,
                    fit: BoxFit.contain,
                    imageUrl: product.images.first,
                    placeholder: (context, url) => Shimmer.fromColors(
                      highlightColor: Colors.white,
                      baseColor: Colors.grey.shade300,
                      child: Container(
                        color: Colors.grey,
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                      ),
                    ),
                    errorWidget: (context, url, error) => const Center(
                      child: Icon(
                        Icons.error_outline,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10),
                  child: AutoSizeText(product.name, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold), maxLines: 3, maxFontSize: 13),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
