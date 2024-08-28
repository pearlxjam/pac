import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductCarouselSlider extends StatefulWidget {
  final List<String> images;
  const ProductCarouselSlider({super.key, required this.images});

  @override
  State<ProductCarouselSlider> createState() => _ProductCarouselSliderState();
}

class _ProductCarouselSliderState extends State<ProductCarouselSlider> {
  int _currentIndex = 0;
  @override
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Stack(
            children: [
              CarouselSlider(
                items: widget.images
                    .map((e) => Container(
                          color: Colors.white,
                          child: Hero(
                            tag: e,
                            child: CachedNetworkImage(
                              imageUrl: e,
                              imageBuilder: (context, imageProvider) => Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  image: DecorationImage(image: imageProvider),
                                ),
                              ),
                              placeholder: (context, url) => Shimmer.fromColors(
                                highlightColor: Colors.white,
                                baseColor: Colors.grey.shade300,
                                child: Container(
                                  color: Colors.grey.shade300,
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
                        ))
                    .toList(),
                options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 1.5,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    }),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.images.map((e) {
              int index = widget.images.indexOf(e);
              return Container(
                width: 6,
                height: 6,
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index ? Colors.grey.shade600 : Colors.grey.shade400,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
