import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:pac/component/input_outline_button.dart';
import 'package:pac/component/input_text_button.dart';
import 'package:pac/controller/controllers.dart';

class VerificaDireccion extends StatefulWidget {
  const VerificaDireccion({super.key});

  @override
  State<VerificaDireccion> createState() => _VerificaDireccionState();
}

class _VerificaDireccionState extends State<VerificaDireccion> {
  final _formKey = GlobalKey<FormState>();
  File? image;
  bool muestraTomarImagen1 = false;
  // Future tomaImagen() async {
  //   final image = await ImagePicker()
  //       .pickImage(source: ImageSource.camera, imageQuality: 20);
  //   if (image == null) return;
  //   final imagenTemporal = File(image.path);
  //   setState(() {
  //     this.image = imagenTemporal;
  //     muestraTomarImagen1 = true;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "Verificación de dirección,",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 60,
                ),
                Visibility(
                  visible: !muestraTomarImagen1,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        //tomaImagen();
                      },
                      child: Card(
                        elevation: 5,
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: const ListTile(
                          leading: FaIcon(
                            FontAwesomeIcons.camera,
                            color: Colors.white,
                          ),
                          title: Text('Presione acá para tomar la imagen'),
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: muestraTomarImagen1,
                  child: Center(
                    child: Card(
                      margin: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 10,
                      child: image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Column(
                                children: [
                                  Image.file(
                                    image!,
                                    height: 250,
                                    width: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                            )
                          : const Text('xxx'),
                    ),
                  ),
                ),
                Visibility(
                  visible: muestraTomarImagen1,
                  child: GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.only(left: 30, right: 30),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const ListTile(
                        leading: FaIcon(
                          FontAwesomeIcons.camera,
                          color: Colors.white,
                        ),
                        title:
                            Text('Si desea modificar la imagen presione acá'),
                      ),
                    ),
                    onTap: () {
                      //tomaImagen();
                    },
                  ),
                ),
                const SizedBox(height: 70),
                Visibility(
                  visible: muestraTomarImagen1,
                  child: InputTextButton(
                    title: "Verificar con esta imágen",
                    onClick: () {
                      authController.subeImagen(
                          usuarioID: authController.user.value!.id,
                          imagen: image);
                    },
                  ),
                ),
                const SizedBox(height: 10),
                InputOutlineButton(
                  title: "Volver",
                  onClick: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
