import 'package:flutter/material.dart';

class TarjetaAtras extends StatelessWidget {
  const TarjetaAtras({
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
                    image: NetworkImage('https://cdn.pixabay.com/photo/2018/07/11/21/51/toast-3532016_1280.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 60, left: 30),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Datos fondo tarjeta',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                  ),
                  // Container(
                  //   padding: const EdgeInsets.only(top: 10, left: 30),
                  //   alignment: Alignment.centerLeft,
                  //   child: Text(
                  //     authController.user.value!.rut!.toUpperCase(),
                  //     style: TextStyle(color: azul, fontWeight: FontWeight.bold, fontSize: 18.0),
                  //   ),
                  // ),
                  // Container(
                  //   padding: const EdgeInsets.only(top: 30, right: 30, bottom: 30),
                  //   alignment: Alignment.centerRight,
                  //   child: Text(
                  //     'Válida hasta el 12/27',
                  //     style: TextStyle(color: azul, fontWeight: FontWeight.bold, fontSize: 12.0),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
