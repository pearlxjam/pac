import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pac/const/const.dart';
import 'package:pac/controller/controllers.dart';
import 'package:pac/providers/provider_registra_descarga.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:shimmer/shimmer.dart';

class ListaDescuentos extends StatelessWidget {
  const ListaDescuentos({
    super.key,
    required this.totalDescuentos,
    required this.descuentosList,
  });

  final int totalDescuentos;
  final dynamic descuentosList;

  @override
  Widget build(BuildContext context) {
    DateTime fechaActual = DateTime.now();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.99,
        height: MediaQuery.of(context).size.height * 0.80,
        child: ListView.separated(
            physics: const ScrollPhysics(),
            itemCount: totalDescuentos,
            separatorBuilder: (context, index) => const SizedBox(), // Agregar un separador entre elementos
            itemBuilder: (BuildContext context, int index) {
              final descuento = descuentosList[index];
              String fechaInicioFormateada = DateFormat('dd-MM-yyyy').format(DateTime.parse(descuento.fechaInicioDescuento));
              String fechaTerminoFormateada = DateFormat('dd-MM-yyyy').format(DateTime.parse(descuento.fechaTerminoDescuento));
              String fechaDescargaFormateada = DateFormat('dd-MM-yyyy').format(DateTime.parse(descuento.fechaDescarga));
              bool esFechaPasada = DateTime.parse(descuento.fechaTerminoDescuento).isBefore(fechaActual);
              // Color cardColor = esFechaPasada ? Colors.grey : amarillo;
              Color imagenColor = esFechaPasada ? Colors.grey : Colors.transparent;
              return SingleChildScrollView(
                child: CachedNetworkImage(
                  imageUrl: descuento.imagenDescuento,
                  imageBuilder: (context, imageProvider) => GestureDetector(
                    onTap: () {
                      if (!esFechaPasada) {
                        //muestraBottomSheet(context, descuento.tituloDescuento, descuento.descuentoID);
                        registraDescarga(descuento.descuentoID, authController.user.value?.id);
                      }
                    },
                    child: Card(
                      elevation: 10,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.20,
                                child: ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                    imagenColor, // Usar el color de fondo como filtro de color
                                    BlendMode.saturation,
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: descuento.imagenDescuento,
                                    width: 150,
                                    height: 90,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.60,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      AutoSizeText(
                                        descuento.tituloDescuento,
                                        maxLines: 2,
                                        maxFontSize: 13,
                                        style: const TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold),
                                      ),
                                      !esFechaPasada
                                          ? Text(
                                              'Inicio : $fechaInicioFormateada',
                                              style: const TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold),
                                            )
                                          : const Text('Caducado'),
                                      !esFechaPasada
                                          ? Text(
                                              'Termino : $fechaTerminoFormateada',
                                              style: const TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold),
                                            )
                                          : const SizedBox(),
                                      AutoSizeText(
                                        'Fecha descarga : $fechaDescargaFormateada',
                                        style: const TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    // child: Material(
                    //   elevation: 8,
                    //   borderRadius: BorderRadius.circular(12),
                    //   child: AnimatedContainer(
                    //     duration: const Duration(milliseconds: 300),
                    //     width: double.infinity,
                    //     height: 140,
                    //     decoration: BoxDecoration(
                    //       color: cardColor,
                    //       borderRadius: BorderRadius.circular(12),
                    //     ),
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    //         ColorFiltered(
                    //           colorFilter: ColorFilter.mode(
                    //             imagenColor, // Usar el color de fondo como filtro de color
                    //             BlendMode.saturation,
                    //           ),
                    //           child: Image.network(
                    //             descuento.imagenDescuento,
                    //             width: 90,
                    //             height: 80,
                    //           ),
                    //         ),
                    //         const SizedBox(
                    //           width: 20,
                    //         ),
                    //         Padding(
                    //           padding: const EdgeInsets.only(top: 30, bottom: 20),
                    //           child: Column(
                    //             mainAxisAlignment: MainAxisAlignment.start,
                    //             children: [
                    //               AutoSizeText(
                    //                 descuento.tituloDescuento,
                    //                 maxLines: 2,
                    //                 maxFontSize: 13,
                    //                 style: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold),
                    //               ),
                    //               Text(
                    //                 'Inicio : $fechaInicioFormateada',
                    //                 style: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold),
                    //               ),
                    //               Text(
                    //                 'Termino : $fechaTerminoFormateada',
                    //                 style: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold),
                    //               ),
                    //               AutoSizeText(
                    //                 'Fecha descarga : $fechaDescargaFormateada',
                    //                 style: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold),
                    //               )
                    //             ],
                    //           ),
                    //         ),
                    //       ]),
                    //     ),
                    //   ),
                    // ),
                  ),
                  placeholder: (context, url) => Material(
                    elevation: 8,
                    shadowColor: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.white,
                      child: Container(
                        width: double.infinity,
                        height: 140,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 30,
                                width: 75,
                                color: Colors.grey,
                              ),
                              Container(
                                decoration: BoxDecoration(color: Colors.white.withOpacity(0.6), borderRadius: const BorderRadius.all(Radius.circular(24))),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  child: Text(
                                    'Ver más',
                                    style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Material(
                    elevation: 8,
                    shadowColor: Colors.grey.shade300,
                    child: Container(
                      width: double.infinity,
                      height: 140,
                      decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(12)),
                      child: const Center(
                        child: Icon(
                          Icons.error_outline,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

Future<void> muestraBottomSheet(BuildContext context, String nombreProducto, int productoID) {
  String textoQr = '';

  var beneficiario = authController.user.value!.fullName?.toUpperCase();
  textoQr = 'Descuento: $nombreProducto\n Beneficiario: $beneficiario';
  return showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 1.5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      child: const Text('Cerrar'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Center(
                          child: PrettyQrView.data(
                            decoration: PrettyQrDecoration(
                              image: PrettyQrDecorationImage(
                                image: AssetImage(logo),
                              ),
                            ),
                            data: textoQr,
                            errorCorrectLevel: QrErrorCorrectLevel.M,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}
