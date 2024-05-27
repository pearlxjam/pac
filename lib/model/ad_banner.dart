import 'dart:convert';

import 'package:hive/hive.dart';

part 'ad_banner.g.dart';

List<AdBanner> adBannerListFromJson(String val) => List<AdBanner>.from(
    json.decode(val)['data'].map((banner) => AdBanner.fromJson(banner)));

@HiveType(typeId: 1)
class AdBanner {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String image;
  @HiveField(2)
  final String url;

  AdBanner({required this.id, required this.image, required this.url});

  factory AdBanner.fromJson(Map<String, dynamic> data) =>
      AdBanner(id: data['id'], image: data['imagen'], url: data['url']);
}
