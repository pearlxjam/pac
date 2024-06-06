import 'package:flutter/material.dart';
import 'package:pac/component/input_outline_button.dart';
import 'package:pac/component/input_text_button.dart';
import 'package:pac/component/input_text_field.dart';
import 'package:pac/controller/controllers.dart';
import 'package:pac/view/view.dart';
import 'package:rut_utils/rut_utils.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController rutController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    rutController.dispose();
    passwordController.dispose();
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
                  "Bienvenido/a,",
                  style: TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Ingresa tus datos para continuar!",
                  style: TextStyle(color: Colors.grey, fontSize: 22, fontWeight: FontWeight.w400, letterSpacing: 1.2),
                ),
                const Spacer(
                  flex: 3,
                ),
                InputTextField(
                  hint: "Ingrese su RUT ej.- 12345678-9",
                  // inputFormatters: [
                  //   RutFormatter(),
                  // ],
                  title: 'Rut ej.- 12345678-9',

                  textEditingController: rutController,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ResetPassScreen()));
                      },
                      child: const Text(
                        "Olvidé mi contraseña",
                        style: TextStyle(fontSize: 12),
                      ),
                    )
                  ],
                ),
                const Spacer(),
                InputTextButton(
                  title: "Ingresar",
                  onClick: () {
                    if (_formKey.currentState!.validate()) {
                      authController.signIn(rut: rutController.text, password: passwordController.text);
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
