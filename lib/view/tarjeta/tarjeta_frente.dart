import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pac/controller/controllers.dart';

class TarjetaFrente extends StatelessWidget {
  const TarjetaFrente({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.28,
        width: double.infinity,
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://www.tarjetavecinopac.com/assets/media/tarjeta/tarjeta.png'), // Reemplaza con la URL de tu imagen
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 100, right: 30, left: 30),
                    alignment: Alignment.centerRight,
                    child: AutoSizeText(
                      authController.user.value!.fullName!.toUpperCase(),
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                          color: Color.fromARGB(255, 22, 2, 73),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      minFontSize: 15,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 30),
                    alignment: Alignment.centerRight,
                    child: Text(
                      authController.user.value!.rut!.toUpperCase(),
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                          color: Color.fromARGB(255, 22, 2, 73),
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
