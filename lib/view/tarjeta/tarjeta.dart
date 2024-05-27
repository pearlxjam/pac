import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pac/view/view.dart';

class MiTarjeta extends StatelessWidget {
  const MiTarjeta({super.key});

  @override
  Widget build(BuildContext context) {
    // final RxBool muestraReverso = false.obs;
    // GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
            child: Column(children: [
              const Center(
                child: Text(
                  'Mi tarjeta Vecina',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Center(
                child: TarjetaFrente(),
              ),
              // Center(
              //   child: Obx(() => muestraReverso.isFalse ? const Text('Para ver el reverso presione sobre la tarjeta') : const Text('Para ver el frente presione sobre la tarjeta')),
              // ),
              // GestureDetector(
              //   onTap: () {
              //     muestraReverso.isFalse ? muestraReverso(true) : muestraReverso(false);
              //   },
              //   child: FlipCard(
              //     key: cardKey,
              //     fill: Fill.fillBack, // Fill the back side of the card to make in the same size as the front.
              //     direction: FlipDirection.HORIZONTAL, // default
              //     side: CardSide.FRONT, // The side to initially display.
              //     front: const TarjetaFrente(),
              //     back: const TarjetaAtras(),
              //   ),
              // ),
              // AnimatedSwitcher(
              //   duration: const Duration(milliseconds: 500),
              //   child: Obx(
              //     () => muestraReverso.isFalse
              //         ? GestureDetector(
              //             onTap: () {
              //               muestraReverso(true);
              //             },
              //             child: const TarjetaFrente(),
              //           )
              //         : GestureDetector(
              //             onTap: () {
              //               muestraReverso(false);
              //             },
              //             child: const TarjetaAtras(),
              //           ),
              //   ),
              // ),
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
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Colors.blue, // Texto blanco
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // Radio de 10
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
