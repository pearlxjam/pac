import 'package:flutter/material.dart';
import 'package:pac/model/modelos.dart';
import 'package:pac/service/remote_service/remote_encuestas_opciones.dart';
import 'package:pac/view/view.dart';

class ListaOpcionesRespuestas extends StatefulWidget {
  const ListaOpcionesRespuestas({super.key, required this.preguntaID, required this.tipoRespuesta, required this.votacionesID});
  final int preguntaID;
  final String tipoRespuesta;
  final int votacionesID;

  @override
  State<ListaOpcionesRespuestas> createState() => _ListaOpcionesRespuestasState();
}

class _ListaOpcionesRespuestasState extends State<ListaOpcionesRespuestas> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int? selectedOption;
  List<OpcionesPreguntas>? opcionesList;

  @override
  void initState() {
    super.initState();
    loadOpciones();
  }

  void loadOpciones() async {
    final data = await getOpcionesPreguntas(widget.votacionesID, widget.preguntaID);
    setState(() {
      opcionesList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: opcionesList != null ? buildOpcionesList() : const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget buildOpcionesList() {
    var totalDatosOpciones = opcionesList!.length;
    var tipoRespuesta = widget.tipoRespuesta;

    if (tipoRespuesta == '1') {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.99,
        height: MediaQuery.of(context).size.height * 0.2,
        child: ListView.separated(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount: totalDatosOpciones,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (BuildContext context, int index) {
            final opciones = opcionesList![index];
            final isSelected = selectedOption == opciones.id;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedOption = isSelected ? null : opciones.id;
                });
              },
              child: Row(
                children: [
                  Radio<int>(
                    value: opciones.id,
                    groupValue: selectedOption,
                    onChanged: (int? value) {
                      setState(() {
                        selectedOption = value;
                      });
                    },
                  ),
                  Expanded(
                    child: Text(
                      opciones.opcion,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    } else {
      return CreaOpcionesCheckList(
        totalDatosOpciones: totalDatosOpciones,
        opcionesList: opcionesList,
        votacionesID: widget.votacionesID,
      );
    }
  }
}
