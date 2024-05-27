import 'package:flutter/material.dart';

class CreaOpcionesCheckList extends StatefulWidget {
  const CreaOpcionesCheckList({
    super.key,
    required this.totalDatosOpciones,
    required this.opcionesList,
    required this.votacionesID,
  });

  final int totalDatosOpciones;
  final dynamic opcionesList;
  final int votacionesID;

  @override
  State<CreaOpcionesCheckList> createState() => _CreaOpcionesCheckListState();
}

class _CreaOpcionesCheckListState extends State<CreaOpcionesCheckList> {
  final selectedOptions = <int>{};

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.99,
      height: MediaQuery.of(context).size.height * 0.2,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: widget.totalDatosOpciones,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          final opciones = widget.opcionesList[index];
          final isSelected = selectedOptions.contains(opciones.id);

          return Row(
            children: [
              Checkbox(
                value: isSelected,
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      selectedOptions.add(opciones.id);
                    } else {
                      selectedOptions.remove(opciones.id);
                    }
                  });
                },
              ),
              Expanded(
                child: Text(
                  opciones.opcion,
                  overflow: TextOverflow.ellipsis,
                  maxLines:
                      2, // Limitar a 2 líneas antes de mostrar puntos suspensivos
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
