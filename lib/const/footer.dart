import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1, // Ajusta la altura según tus necesidades
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/footer.png'), // Reemplaza 'tu_imagen.jpg' con la ruta de tu imagen
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
