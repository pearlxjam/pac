import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:pac/controller/controllers.dart';
import 'package:pac/model/encuesta_usuario.dart';
import 'package:pac/service/remote_service/remote_encuestas_preguntas.dart';
import 'package:pac/view/votaciones/lista_preguntas.dart';

class MuestraPreguntasProceso extends StatefulWidget {
  final EncuestaUsuario votaciones;
  const MuestraPreguntasProceso({super.key, required this.votaciones});

  @override
  State<MuestraPreguntasProceso> createState() =>
      _MuestraPreguntasProcesoState();
}

class _MuestraPreguntasProcesoState extends State<MuestraPreguntasProceso> {
  bool puedeVotar = true;
  Future<void> buscaVotacion(int votacionID) async {
    final user = authController.user.value;
    if (user == null) {
      setState(() {
        puedeVotar = false;
      });
    }
    if (user?.estado != 1) {
      setState(() {
        puedeVotar = false;
      });
    }

    if (puedeVotar) {
      var usuarioID = user?.id;

      var url =
          'https://www.tarjetavecinopac.com/api/buscaTotalRespuestasEncuesta.php?votacionID=$votacionID&usuarioID=$usuarioID';
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        final int totalRespuestas = data[0]['totalRespuestas'];
        if (totalRespuestas != 0) {
          setState(() {
            puedeVotar = false;
          });
        }
      }
    }
  }

  @override
  void initState() {
    buscaVotacion(widget.votaciones.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Votaciones'),
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(0, 56, 194, 0.4),
          automaticallyImplyLeading: false,
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width * 0.999,
          height: MediaQuery.of(context).size.height * 0.99,
          // decoration: const BoxDecoration(
          //   gradient: LinearGradient(
          //     begin: Alignment.topCenter,
          //     end: Alignment.bottomCenter,
          //     // stops: [0.2, 0.2],
          //     colors: [
          //       Color.fromRGBO(249, 176, 54, 0.4),
          //       Color.fromRGBO(195, 46, 38, 0.4),
          //       Color.fromRGBO(188, 207, 0, 0.4),
          //       Color.fromRGBO(61, 204, 230, 0.4),
          //       Color.fromRGBO(0, 56, 194, 0.4),
          //     ],
          //   ),
          // ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            child: AutoSizeText(
                              widget.votaciones.titulo,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              maxFontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: puedeVotar,
                    child: SingleChildScrollView(
                      child: FutureBuilder(
                        future: getPreguntasEncuesta(widget.votaciones.id),
                        builder: (BuildContext context, AsyncSnapshot data) {
                          if (data.connectionState != ConnectionState.waiting &&
                              data.hasData) {
                            var preguntasList = data.data;
                            var totalDatosEncuesta = preguntasList!.length;
                            if (totalDatosEncuesta > 0) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: ListaPreguntasEncuesta(
                                    totalDatosEncuesta: totalDatosEncuesta,
                                    preguntasList: preguntasList,
                                    votacionesID: widget.votaciones.id),
                              );
                            } else {
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Center(
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 40),
                                          child: Text(
                                            'No existen preguntas por el momento',
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
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !puedeVotar,
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              children: [
                                const Card(
                                  elevation: 4,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 10),
                                    child: AutoSizeText(
                                      'Estimado/a usted ya votó en este proceso, muchas gracias por su participación',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      maxFontSize: 12,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon:
                                      const FaIcon(FontAwesomeIcons.arrowLeft),
                                  label: const Text('Volver'),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
