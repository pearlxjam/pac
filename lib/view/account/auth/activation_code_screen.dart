import 'package:flutter/material.dart';
import 'package:pac/component/input_outline_button.dart';
import 'package:pac/component/input_text_button.dart';
import 'package:pac/component/input_text_field.dart';
import 'package:pac/controller/controllers.dart';
import 'package:pac/view/view.dart';
import 'package:rut_utils/rut_utils.dart';

class ActivationCodeScreen extends StatefulWidget {
  const ActivationCodeScreen({super.key});

  @override
  State<ActivationCodeScreen> createState() => _ActivationCodeScreenState();
}

class _ActivationCodeScreenState extends State<ActivationCodeScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController rutController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();
  @override
  void dispose() {
    rutController.dispose();
    codeController.dispose();
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                const Text(
                  "Bienvenido/a nuevamente,",
                  style: TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Ingresa tus datos para continuar!",
                  style: TextStyle(color: Colors.grey, fontSize: 22, fontWeight: FontWeight.w400, letterSpacing: 1.2),
                ),
                const Spacer(
                  flex: 2,
                ),
                InputTextField(
                  hint: "Ingrese su RUT ej.- 12345678-9",
                  title: 'Rut ej.- 12345678-9',
                  textEditingController: rutController,
                  validation: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Este campo no puede estar vacío";
                    } else if (!isRutValid(value)) {
                      return "El rut ingresado no es válido";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                InputTextField(
                  title: 'Código',
                  textEditingController: codeController,
                  onChange: (value) {
                    // Convierte el texto a mayúsculas y establece en codeController
                    codeController.text = value.toUpperCase();
                  },
                  validation: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Este campo no puede estar vacío";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                InputTextField(
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
                const SizedBox(height: 10),
                InputTextField(
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
                const SizedBox(height: 10),
                const Spacer(),
                InputTextButton(
                  title: "Ingresar",
                  onClick: () {
                    if (_formKey.currentState!.validate()) {
                      authController.verificaCodigo(rut: rutController.text, codigo: codeController.text, password: passwordController.text);
                    }
                  },
                ),
                const SizedBox(height: 10),
                InputOutlineButton(
                  title: "Volver",
                  onClick: () {
                    Navigator.of(context).pop();
                  },
                ),
                const Spacer(
                  flex: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Soy nuevo/a, "),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
                      },
                      child: const Text(
                        "Registro",
                        style: TextStyle(color: Colors.blue),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
