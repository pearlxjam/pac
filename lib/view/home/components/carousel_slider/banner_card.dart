import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class BannerCard extends StatelessWidget {
  final String imageUrl;
  final String url;
  const BannerCard({super.key, required this.imageUrl, required this.url});
  Future<void> _launchUrl(url) async {
    url = Uri.parse(url);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _launchUrl(url);
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
        child: Container(
          margin: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Shimmer.fromColors(
                highlightColor: Colors.white,
                baseColor: Colors.grey.shade300,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Container(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              fit: BoxFit.fill,
              width: double.infinity,
            ),
          ),
        ),
      ),
    );
  }
}
