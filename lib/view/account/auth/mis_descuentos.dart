import 'package:flutter/material.dart';
import 'package:pac/controller/controllers.dart';
import 'package:pac/model/modelos.dart';
import 'package:pac/service/remote_service/remote_descuentos_service.dart';
import 'package:pac/view/view.dart';

class MisDescuentos extends StatelessWidget {
  const MisDescuentos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Mis descuentos'),
        backgroundColor: const Color.fromRGBO(0, 56, 194, 0.4),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<List<DescuentosUsuario>>(
            future: getResumenDescuentosUsuarios(authController.user.value?.id),
            builder: (BuildContext context, AsyncSnapshot data) {
              if (data.connectionState != ConnectionState.waiting && data.hasData) {
                var descuentosList = data.data;
                var totalDescuentos = descuentosList!.length;
                if (totalDescuentos == 0) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Center(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                              child: Text(
                                'No registra solicitudes de descuento',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: ListaDescuentos(
                      totalDescuentos: totalDescuentos,
                      descuentosList: descuentosList,
                    ),
                  );
                }
              } else {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
