import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pac/controller/controllers.dart';

class InformacionPersonal extends StatelessWidget {
  const InformacionPersonal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          // Wrap your content in a SingleChildScrollView
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(children: [
              const Center(
                child: Text(
                  'Información',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.55,
                child: Card(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 36,
                            child: CircleAvatar(
                              radius: 35,
                              backgroundImage: AssetImage("assets/logo_sin_fondo.png"),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
                            child: AutoSizeText(
                              authController.user.value!.fullName?.toUpperCase() ?? "Ingresa a tu cuenta",
                              presetFontSizes: const [25, 20, 10],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ListTile(
                        leading: const FaIcon(FontAwesomeIcons.personDotsFromLine),
                        title: Text(authController.user.value?.rut ?? "Ingresa a tu cuenta"),
                        subtitle: const Text('Rut'),
                      ),
                      ListTile(
                        leading: const FaIcon(FontAwesomeIcons.at),
                        title: Text(authController.user.value?.email ?? "Ingresa a tu cuenta"),
                        subtitle: const Text('Correo'),
                      ),
                      ListTile(
                        leading: const FaIcon(FontAwesomeIcons.house),
                        title: Text(authController.user.value?.direccion ?? "Ingresa a tu cuenta"),
                        subtitle: const Text('Dirección'),
                      ),
                      ListTile(
                        leading: const FaIcon(FontAwesomeIcons.cakeCandles),
                        title: Text(DateFormat('dd/MM/yyyy').format(authController.user.value!.birthDay ?? DateTime.now())),
                        subtitle: const Text('Fecha de nacimiento'),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            'Si deseas modificar tus datos \ncomunícate con nosotros.\nEnvía un correo a :\ntarjetavecina@pedroaguirrecerda.cl',
                            maxFontSize: 12,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.60,
                child: Align(
                  alignment: Alignment.centerRight,
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
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
