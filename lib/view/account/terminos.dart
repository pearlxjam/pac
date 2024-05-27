import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class TerminosYCondiciones extends StatelessWidget {
  const TerminosYCondiciones({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Column(
                  children: [
                    Center(
                      child: Text(
                        'Terminos y condiciones',
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
                      "https://www.tarjetavecinopac.com/assets/documentos/TERMINOS_Y_CONDICIONES.pdf"),
                ),
                const SizedBox(height: 20),
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
