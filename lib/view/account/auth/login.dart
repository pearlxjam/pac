import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pac/component/input_outline_button.dart';
import 'package:pac/component/input_text_button.dart';
import 'package:pac/component/input_text_field.dart';
import 'package:pac/const/const.dart';
import 'package:pac/controller/controllers.dart';
import 'package:pac/extention/string_extension.dart';
import 'package:pac/view/view.dart';
import 'package:rut_utils/rut_utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController rut = TextEditingController();
  TextEditingController nombres = TextEditingController();
  TextEditingController nombres2 = TextEditingController();
  TextEditingController apellidoPaterno = TextEditingController();
  TextEditingController apellidoMaterno = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController direccionController = TextEditingController();
  TextEditingController fechaNacimientoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();
  DateTime? selectedDate;
  List<String> generoOptions = ['Masculino', 'Femenino', 'Otro'];
  String? genero;
  bool _acceptTerms = false;

  @override
  void dispose() {
    nombres.dispose();
    nombres2.dispose();
    apellidoPaterno.dispose();
    apellidoMaterno.dispose();
    emailController.dispose();
    telefonoController.dispose();
    direccionController.dispose();
    fechaNacimientoController.dispose();
    passwordController.dispose();
    repasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.99,
            child: Padding(
              // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Form(
                key: _formKey,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.99,
                  child: ListView(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      const Text("Crear cuenta,", style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold)),
                      const Text(
                        "Ingresa para comenzar!",
                        style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w400, letterSpacing: 1.2),
                      ),
                      const Spacer(
                          // flex: 3,
                          ),
                      Column(
                        children: [
                          InputTextField(
                            title: 'Rut ej.- 12345678-9xxx',
                            textEditingController: rut,
                            validation: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Este campo no puede estar vacío";
                              } else if (!isRutValid(value)) {
                                return "El rut ingresado no es válido";
                              } else if (!value.contains("-")) {
                                return "El rut debe contener el caracter '-'";
                              }

                              return null;
                            },
                          ),
                          const SizedBox(height: 8),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 40),
                            child: InputTextField(
                              title: 'Contraseña',
                              obsecureText: true,
                              textEditingController: passwordController,
                              validation: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return "Este campo no puede estar vacío";
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 40),
                            child: InputTextField(
                              title: 'Repita su contraseña',
                              obsecureText: true,
                              textEditingController: repasswordController,
                              validation: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return "Este campo no puede estar vacío";
                                } else if (passwordController.text != value) {
                                  return "Las contraseña no coinciden";
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 8),
                          InputTextField(
                            title: 'Nombres ej.- Juan',
                            textEditingController: nombres,
                            validation: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Este campo no puede estar vacío";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8),
                          InputTextField(
                            title: 'Segundo nombre ej.- Juan',
                            textEditingController: nombres2,
                            validation: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Este campo no puede estar vacío";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8),
                          InputTextField(
                            title: 'Apellido Paterno ej.- Perez',
                            textEditingController: apellidoPaterno,
                            validation: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Este campo no puede estar vacío";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8),
                          InputTextField(
                            title: 'Apellido Materno ej.- Gonzalez',
                            textEditingController: apellidoMaterno,
                            validation: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Este campo no puede estar vacío";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<String>(
                            style: const TextStyle(fontSize: 12.0, height: 2.0, color: Colors.black),
                            value: genero,
                            items: generoOptions.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                genero = value;
                              });
                            },
                            decoration: const InputDecoration(
                                labelText: 'Género',
                                labelStyle: TextStyle(color: Colors.black54),
                                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                hintStyle: TextStyle(fontWeight: FontWeight.w300, fontSize: 11),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  borderSide: BorderSide(width: 1, color: Colors.black26),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  borderSide: BorderSide(width: 1, color: Colors.black26),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  borderSide: BorderSide(width: 1, color: Colors.black26),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  borderSide: BorderSide(width: 1, color: Colors.black26),
                                )),
                          ),
                          const SizedBox(height: 8),
                          InputTextField(
                            title: 'Correo electrónico',
                            textEditingController: emailController,
                            validation: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Este campo no puede estar vacío";
                              } else if (!value.isValidEmail) {
                                return "Ingresa un correo válido";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8),
                          InputTextField(
                            title: 'Teléfono',
                            textEditingController: telefonoController,
                            validation: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Este campo no puede estar vacío";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8),
                          InputTextField(
                            title: 'Dirección',
                            textEditingController: direccionController,
                            validation: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Este campo no puede estar vacío";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Fecha de Nacimiento (dd/mm/yyyy)',
                              labelStyle: TextStyle(color: Colors.black54),
                              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              hintStyle: TextStyle(fontWeight: FontWeight.w300, fontSize: 11),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(width: 1, color: Colors.black26),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(width: 1, color: Colors.black26),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(width: 1, color: Colors.black26),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(width: 1, color: Colors.black26),
                              ),
                            ),
                            controller: fechaNacimientoController,
                            onTap: () {
                              _selectDate(context);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Este campo no puede estar vacío';
                              }
                              return null; // Devuelve null si la validación es exitosa
                            },
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Center(
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const TerminosYCondiciones(),
                                        ),
                                      );
                                    },
                                    child: AutoSizeText(
                                      'He leído y estoy de acuerdo con los \nTérminos y condiciones',
                                      maxFontSize: 12,
                                      style: TextStyle(color: azul),
                                    ),
                                  ),
                                  Checkbox(
                                    value: _acceptTerms, // Donde _acceptTerms es una variable bool que indicará si el usuario ha aceptado los términos.
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _acceptTerms = value ?? false;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Visibility(
                        visible: _acceptTerms,
                        child: InputTextButton(
                          title: "Registro",
                          onClick: () {
                            if (_formKey.currentState!.validate()) {
                              authController.signUp(
                                rut: rut.text,
                                nombres: nombres.text,
                                nombres2: nombres2.text,
                                // apellidos: apellidos.text,
                                apellidoPaterno: apellidoPaterno.text,
                                apellidoMaterno: apellidoMaterno.text,
                                email: emailController.text,
                                telefono: telefonoController.text,
                                direccion: direccionController.text,
                                genero: genero ?? 'Prefiero no decir',
                                fechaNacimiento: fechaNacimientoController.text,
                                contrasenia: passwordController.text,
                              );
                            }
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
                      const Spacer(
                        flex: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Ya tengo cuenta, "),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
                            },
                            child: const Text(
                              "Ingresar",
                              style: TextStyle(color: Colors.blue),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 220,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime maximumDate = currentDate.subtract(const Duration(days: 18 * 365)); // Subtract 18 years from the current date

    final DateTime pickedDate = (await showDatePicker(
          locale: const Locale("es", "ES"),
          context: context,
          initialDate: selectedDate ?? maximumDate, // Set the initial date to the maximum allowed age
          firstDate: DateTime(1920),
          lastDate: maximumDate, // Set the maximum allowed date
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: Colors.blue, // Change the color of the OK and Cancel buttons
                dialogBackgroundColor: Colors.white,
                colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.blue), // Change the background color of the date picker
              ),
              child: child!,
            );
          },
        )) ??
        maximumDate;

    if (pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        fechaNacimientoController.text = DateFormat('dd/MM/yyyy').format(selectedDate!);
      });
    }
  }
}
