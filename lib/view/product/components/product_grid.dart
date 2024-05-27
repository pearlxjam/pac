import 'package:flutter/material.dart';
import 'package:pac/const/const.dart';
import 'package:pac/model/modelos.dart';
import 'package:pac/view/view.dart';

class ProductGrid extends StatelessWidget {
  final List<Product> products;
  const ProductGrid({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Título centrado
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 15),
          child: Center(
            child: Text(
              "Descuentos",
              style: TextStyle(
                  fontSize: 24, // Puedes ajustar el tamaño del texto según tus preferencias
                  fontWeight: FontWeight.bold,
                  color: verde),
            ),
          ),
        ),
        const SizedBox(height: 10), // Espacio entre el título y la cuadrícula
        // Cuadrícula de productos
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(10),
            itemCount: products.length,
            itemBuilder: (context, index) => ProductCard(product: products[index]),
          ),
        ),
        //const Footer(),
      ],
    );
  }
}
