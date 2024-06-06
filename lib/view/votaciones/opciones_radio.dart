import 'package:flutter/material.dart';

class CreaOpcionesRadio extends StatefulWidget {
  const CreaOpcionesRadio({
    super.key,
    required this.totalDatosOpciones,
    required this.opcionesList,
    required this.votacionesID,
  });

  final int totalDatosOpciones;
  final dynamic opcionesList;
  final int votacionesID;

  @override
  State<CreaOpcionesRadio> createState() => _CreaOpcionesRadioState();
}

class _CreaOpcionesRadioState extends State<CreaOpcionesRadio> {
  int? selectedOption;

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
  }
}
