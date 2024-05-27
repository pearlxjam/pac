import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({super.key});
  final boxDecoration = const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      // stops: [0.2, 0.2],
      colors: [
        Color.fromRGBO(249, 176, 54, 0.4),
        Color.fromRGBO(195, 46, 38, 0.4),
        Color.fromRGBO(188, 207, 0, 0.4),
        Color.fromRGBO(61, 204, 230, 0.4),
        Color.fromRGBO(0, 56, 194, 0.4),
      ],
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(decoration: boxDecoration),
    ]);
  }
}
