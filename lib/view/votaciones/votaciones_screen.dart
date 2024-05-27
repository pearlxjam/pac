import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pac/controller/controllers.dart';
import 'package:pac/model/encuesta_usuario.dart';
import 'package:pac/service/remote_service/remote_encuestas_usuario_service.dart';
import 'package:pac/view/votaciones/lista_procesos.dart';

class Votaciones extends StatefulWidget {
  const Votaciones({super.key});

  @override
  State<Votaciones> createState() => _VotacionesState();
}

class _VotacionesState extends State<Votaciones> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Obx(
              () {
                final user = authController.user.value;
                if (user == null) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Debes estar registrado para votar',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  if (authController.user.value?.estado != 1) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Card(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                'Debes validar tu cuenta para votar',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return SingleChildScrollView(
                      child: FutureBuilder<List<EncuestaUsuario>>(
                          future: getEncuestasUsuario(authController.user.value?.id),
                          builder: (BuildContext context, AsyncSnapshot data) {
                            if (data.connectionState != ConnectionState.waiting && data.hasData) {
                              var votacionesList = data.data;
                              var totalDatos = votacionesList!.length;
                              if (totalDatos > 0) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  child: ListaProcesosVotaciones(
                                    totalDatos: totalDatos,
                                    votacionesList: votacionesList,
                                  ),
                                );
                              } else {
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
                                              'No existen encuestas por el momento',
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
                              }
                            } else {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 40),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                          }),
                    );
                  }
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
