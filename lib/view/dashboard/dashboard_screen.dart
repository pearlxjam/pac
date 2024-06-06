import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pac/controller/control.dart';
import 'package:pac/view/view.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) => Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          bottom: false,
          child: Stack(children: [
            // const Background(),
            IndexedStack(
              index: controller.tabIndex,
              children: const [
                HomeScreen(),
                //Votaciones(),
                ProductScreen(),
                CategoryScreen(),
                // AccountScreen()
              ],
            ),
          ]),
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(0, 56, 194, 0.4),
            // border: Border(
            //   top: BorderSide(
            //       color: Theme.of(context).colorScheme.secondary, width: 0.7),
            // ),
          ),
          child: SnakeNavigationBar.color(
            backgroundColor: const Color.fromRGBO(0, 56, 194, 0.3),
            shadowColor: const Color.fromRGBO(0, 56, 194, 1),
            behaviour: SnakeBarBehaviour.floating,
            snakeShape: SnakeShape.indicator,
            unselectedLabelStyle: const TextStyle(fontSize: 9),
            selectedLabelStyle: const TextStyle(fontSize: 9),
            snakeViewColor: Colors.red,
            unselectedItemColor: Colors.white,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            elevation: 50,
            currentIndex: controller.tabIndex,
            onTap: (val) {
              controller.updateIndex(val);
            },
            items: const [
              BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.house), label: 'Inicio'),
              //BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.checkToSlot), label: 'Votaciones'),
              BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.tags), label: 'Descuentos'),
              BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.tableList), label: 'Categorías'),
            ],
          ),
        ),
      ),
    );
  }
}
