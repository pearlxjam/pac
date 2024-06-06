import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pac/component/main_header.dart';
import 'package:pac/const/const.dart';
import 'package:pac/const/footer.dart';
import 'package:pac/controller/controllers.dart';
import 'package:pac/view/view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: azul,
        title: const MainHeader(),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 10,
        toolbarHeight: 100,
      ),
      drawer: const NavBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Obx(() {
                      if (homeController.bannerList.isNotEmpty) {
                        return CarouselSliderView(bannerList: homeController.bannerList);
                      } else {
                        return const CarouselLoading();
                      }
                    }),
                    const SectionTitle(
                      title: "Categorías",
                      seccion: 2,
                    ),
                    Obx(() {
                      if (homeController.popularCategoryList.isNotEmpty) {
                        return PopularCategory(categories: homeController.popularCategoryList);
                      } else {
                        return const PopularCategoryLoading();
                      }
                    }),
                    const SectionTitle(
                      title: "Descuentos",
                      seccion: 1,
                    ),
                    Obx(() {
                      if (homeController.popularProductList.isNotEmpty) {
                        return PopularProduct(popularProducts: homeController.popularProductList);
                      } else {
                        return const PopularProductLoading();
                      }
                    }),
                    const Footer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
