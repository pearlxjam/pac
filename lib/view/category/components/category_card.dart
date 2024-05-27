import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pac/const/const.dart';
import 'package:pac/controller/controllers.dart';
import 'package:pac/model/modelos.dart';
import 'package:shimmer/shimmer.dart';

class CategoryCard extends StatefulWidget {
  final Category category;
  const CategoryCard({super.key, required this.category});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: InkWell(
        onTap: () {
          dashboardController.updateIndex(1);
          productController.searchTextEditController.text = 'cat: ${widget.category.name}';
          productController.searchVal.value = 'cat: ${widget.category.name}';
          productController.getProductByCategory(id: widget.category.id);
          setState(() {
            _selected = !_selected;
          });
        },
        child: CachedNetworkImage(
          imageUrl: widget.category.image,
          imageBuilder: (context, imageProvider) => Material(
            elevation: 8,
            // shadowColor: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: double.infinity,
              height: _selected ? 150 : 140,
              decoration: BoxDecoration(
                color: azul,
                borderRadius: BorderRadius.circular(12),
                // image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 2),
                    Image.network(
                      widget.category.image,
                      width: 140,
                      height: 110,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 20),
                      // child: AutoSizeText(category.name, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold), maxLines: 3, maxFontSize: 13),
                      child: AutoSizeText(
                        widget.category.name,
                        maxLines: 3,
                        maxFontSize: 13,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          placeholder: (context, url) => Material(
            elevation: 8,
            shadowColor: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12),
            child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.white,
                child: Container(
                  width: double.infinity,
                  height: 140,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 30,
                          width: 75,
                          color: Colors.grey,
                        ),
                        Container(
                          decoration: BoxDecoration(color: Colors.white.withOpacity(0.6), borderRadius: const BorderRadius.all(Radius.circular(24))),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Text(
                              'Ver más',
                              style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          ),
          errorWidget: (context, url, error) => Material(
            elevation: 8,
            shadowColor: Colors.grey.shade300,
            child: Container(
              width: double.infinity,
              height: 140,
              decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(12)),
              child: const Center(
                child: Icon(
                  Icons.error_outline,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
