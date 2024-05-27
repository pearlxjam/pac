import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Instructivo extends StatelessWidget {
  const Instructivo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Column(
                  children: [
                    Center(
                      child: Text(
                        'Instructivo Obtención Tarjeta Vecino',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: SfPdfViewer.network(
                      "https://www.tarjetavecinopac.com/assets/documentos/INSTRUCTIVO_OBTENCION_TARJETA_VECINO-2023.pdf"),
                ),
                const SizedBox(height: 30),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.60,
                    child: Column(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const FaIcon(FontAwesomeIcons.arrowLeft),
                          label: const Text('Volver'),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
