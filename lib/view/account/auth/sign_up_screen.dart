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
// import 'package:pac/view/account/auth/sign_in_screen.dart';
// import 'package:pac/view/account/terminos.dart';
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
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text("Crear cuenta,", style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Text("Ingresa para comenzar!", style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w400, letterSpacing: 1.2)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 40),
                        child: InputTextField(
                          title: 'Rut ej.- 12345678-9',
                          textEditingController: rut,
                          textInputType: TextInputType.text,
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
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 40),
                        child: InputTextField(
                          title: 'Nombres ej.- Juan',
                          textEditingController: nombres,
                          textInputType: TextInputType.name,
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
                          title: 'Segundo nombre ej.- Juan',
                          textEditingController: nombres2,
                          textInputType: TextInputType.name,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 40),
                        child: InputTextField(
                          title: 'Apellido Paterno ej.- Perez',
                          textEditingController: apellidoPaterno,
                          textInputType: TextInputType.name,
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
                          title: 'Apellido Materno ej.- Gonzalez',
                          textEditingController: apellidoMaterno,
                          textInputType: TextInputType.name,
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
                        margin: const EdgeInsets.symmetric(
                          horizontal: 40,
                        ),
                        child: DropdownButtonFormField<String>(
                          style: const TextStyle(fontSize: 14.0, height: 2.0, color: Colors.black),
                          value: genero,
                          items: generoOptions.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Center(child: Text(value)),
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
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 40),
                        child: InputTextField(
                          title: 'Correo electrónico',
                          textEditingController: emailController,
                          textInputType: TextInputType.emailAddress,
                          validation: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Este campo no puede estar vacío";
                            } else if (!value.isValidEmail) {
                              return "Ingresa un correo válido";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 40),
                        child: InputTextField(
                          title: 'Teléfono',
                          textEditingController: telefonoController,
                          textInputType: TextInputType.phone,
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
                          title: 'Dirección',
                          textEditingController: direccionController,
                          textInputType: TextInputType.streetAddress,
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
                        child: TextFormField(
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
                      ),
                      const SizedBox(height: 8),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 40),
                        child: SizedBox(
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
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: Column(
                    children: [
                      Visibility(
                        visible: _acceptTerms,
                        child: Column(
                          children: [
                            InputTextButton(
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
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: InputOutlineButton(
                          title: "Volver",
                          onClick: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
                      },
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Ya tengo cuenta, Ingresar",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
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
