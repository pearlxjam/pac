import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pac/view/votaciones/muestra_proceso.dart';
import 'package:readmore/readmore.dart';

class ListaProcesosVotaciones extends StatefulWidget {
  const ListaProcesosVotaciones({
    super.key,
    required this.totalDatos,
    required this.votacionesList,
  });

  final int totalDatos;
  final dynamic votacionesList;

  @override
  State<ListaProcesosVotaciones> createState() =>
      _ListaProcesosVotacionesState();
}

class _ListaProcesosVotacionesState extends State<ListaProcesosVotaciones> {
  bool puedeVotar = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.99,
      height: MediaQuery.of(context).size.height * 0.70,
      child: Card(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListView.separated(
          physics: const ScrollPhysics(),
          itemCount: widget.totalDatos,
          separatorBuilder: (context, index) =>
              const Divider(), // Agregar un separador entre elementos
          itemBuilder: (BuildContext context, int index) {
            final votaciones = widget.votacionesList[index];
            String fechaInicioFormateada = votaciones.fechaInicio;
            String fechaTerminoFormateada = votaciones.fechaTermino;
            bool tieneImagen = votaciones.imagen != null;

            if (votaciones.estadoVotacion != 1) {
              setState(() {
                puedeVotar = false;
              });
            }

            String textoVotar = puedeVotar ? 'Puedes votar' : 'Ya votaste!';

            // Color cardColor = puedeVotar ? Colors.white : Colors.grey;
            // print(votaciones.imagen);
            // if (votaciones.imagen != 'null') {
            //   tieneImagen = true;
            // }
            Color imagenColor = tieneImagen ? Colors.grey : Colors.transparent;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Card(
                elevation: 4,
                // color: cardColor, // Establecer el color del Card
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Visibility(
                            visible: tieneImagen,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.height * 0.1,
                              child: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  imagenColor, // Usar el color de fondo como filtro de color
                                  BlendMode.saturation,
                                ),
                                child: tieneImagen
                                    ? Image.network(
                                        votaciones.imagen!,
                                        fit: BoxFit.contain,
                                      )
                                    : const Placeholder(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                AutoSizeText(
                                  votaciones.titulo,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Entre: $fechaInicioFormateada y $fechaTerminoFormateada',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: ReadMoreText(
                                          votaciones.descripcion,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic),
                                          trimLines: 1,
                                          trimMode: TrimMode.Line,
                                          trimCollapsedText: 'Mostrar más',
                                          moreStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green),
                                          trimExpandedText: 'Mostrar menos',
                                          lessStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(),
                                GestureDetector(
                                  onTap: () {
                                    if (puedeVotar) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MuestraPreguntasProceso(
                                                  votaciones: votaciones),
                                        ),
                                      );
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        if (puedeVotar)
                                          const FaIcon(
                                              FontAwesomeIcons.checkToSlot,
                                              color: Colors.green),
                                        if (!puedeVotar)
                                          const FaIcon(FontAwesomeIcons.check,
                                              color: Colors.red),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          textoVotar,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
