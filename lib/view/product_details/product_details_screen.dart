import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pac/const/const.dart';
import 'package:pac/controller/controllers.dart';
import 'package:pac/model/modelos.dart';
import 'package:pac/providers/provider_registra_descarga.dart';
import 'package:pac/view/view.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  NumberFormat formatter = NumberFormat('00');
  bool _muestraDatos = false;
  String descripcion = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
        backgroundColor: const Color.fromRGBO(0, 56, 194, 0.4),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductCarouselSlider(
                images: widget.product.images.toSet().toList(),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  widget.product.name,
                  style: TextStyle(fontSize: 24, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 40),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Descripción:',
                  style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: AutoSizeText(
                  _getDescription(),
                  style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
                  maxFontSize: 13,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextButton(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
            backgroundColor: WidgetStateProperty.all<Color>(Theme.of(context).primaryColor),
          ),
          onPressed: () {
            if (authController.user.value == null) {
              _muestraDatos = false;
            } else {
              _muestraDatos = true;
            }
            var estado = authController.user.value?.estado;
            if (estado == 1) {
              registraDescarga(widget.product.id, authController.user.value?.id);
              muestraBottomSheet(context, _muestraDatos, widget.product.id);
            } else {
              if (estado == 0) {
                authController.user.value?.id;
                var nombre = authController.user.value?.fullName;
                EasyLoading.showSuccess("Estimado/a, $nombre, Tu usuario ha sido desactivado, si esto es un error comunícate con nosotros en nuestra pagina web.");
              } else {
                if (authController.user.value?.id == null) {
                  EasyLoading.showSuccess("Estimado/a, debes registrarte para ver los descuentos.");
                } else {
                  authController.user.value?.id;
                  var nombre = authController.user.value?.fullName;
                  EasyLoading.showSuccess("Estimado/a, $nombre, tu usuario aún no es validado, por favor espera el correo de validación.");
                }
              }
            }
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Text(
              'Ver código de descuento',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  String _getDescription() {
    if (authController.user.value?.estado == 1) {
      return widget.product.description;
    } else if (authController.user.value?.estado == 2) {
      return "Debes esperar la validación del administrador para obtener el descuento";
    } else {
      return "Debes registrarte para ver los descuentos";
    }
  }

  Future<void> muestraBottomSheet(BuildContext context, bool muestraDatos, int productoID) {
    var estado = authController.user.value?.estado;
    String textoQr = '';

    bool cambiaTexto = false;
    if (estado == 4) {
      cambiaTexto = true;
    }
    if (estado == 1) {
      var beneficiario = authController.user.value!.fullName?.toUpperCase();
      textoQr = 'Descuento: ${widget.product.name}\n Beneficiario: $beneficiario';
    }
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
                    Visibility(
                      visible: !cambiaTexto,
                      child: Visibility(
                        visible: muestraDatos,
                        child: Column(
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
                      ),
                    ),
                    Visibility(
                      visible: cambiaTexto,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.circleXmark,
                              size: 150,
                              color: Colors.red,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              'Debes subir una imagen para validar tu dirección, dirigete a Mi cuenta y sube la imagen',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: !_muestraDatos,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.circleXmark,
                              size: 150,
                              color: Colors.red,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              'Debes registrarte para crear tu código de descuento',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
