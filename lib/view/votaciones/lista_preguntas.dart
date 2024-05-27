import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pac/view/votaciones/lista_opciones.dart';

class ListaPreguntasEncuesta extends StatefulWidget {
  const ListaPreguntasEncuesta({
    super.key,
    required this.totalDatosEncuesta,
    required this.preguntasList,
    required this.votacionesID,
  });

  final int totalDatosEncuesta;
  final dynamic preguntasList;
  final int votacionesID;

  @override
  State<ListaPreguntasEncuesta> createState() => _ListaPreguntasEncuestaState();
}

class _ListaPreguntasEncuestaState extends State<ListaPreguntasEncuesta> {
  final ScrollController _controller = ScrollController();
  late int? answer3;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    answer3 = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.99,
      height: MediaQuery.of(context).size.height * 0.76,
      child: Card(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Scrollbar(
          controller: _controller,
          thumbVisibility: true, //always show scrollbar
          thickness: 5, //width of scrollbar
          radius: const Radius.circular(20),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  controller: _controller,
                  physics: const ScrollPhysics(),
                  itemCount: widget.totalDatosEncuesta,
                  separatorBuilder: (context, index) =>
                      const Divider(), // Agregar un separador entre elementos
                  itemBuilder: (BuildContext context, int index) {
                    final preguntas = widget.preguntasList[index];
                    int numPreg = index + 1;
                    int preguntaID = preguntas.id;
                    bool tieneDescripcion = preguntas.descripcion != null;
                    String tipoRespuesta = preguntas.tipoRespuesta;

                    return Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Text('Pregunta $numPreg'),
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.85,
                                        child: AutoSizeText(
                                          preguntas.pregunta,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Visibility(
                                    visible: tieneDescripcion,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.85,
                                          child: tieneDescripcion
                                              ? AutoSizeText(
                                                  preguntas.descripcion,
                                                  style: const TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic),
                                                )
                                              : const Text(''),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(),
                                ],
                              ),
                              ListaOpcionesRespuestas(
                                preguntaID: preguntaID,
                                tipoRespuesta: tipoRespuesta,
                                votacionesID: widget.votacionesID,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // Agregar aquí la lógica para enviar las respuestas cuando se presione el botón "Votar".
                },
                icon: const Icon(Icons.check),
                label: const Text("Votar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
