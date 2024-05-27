import 'package:flutter/material.dart';
import 'package:pac/component/input_outline_button.dart';
import 'package:pac/component/input_text_button.dart';
import 'package:pac/component/input_text_field.dart';
import 'package:pac/controller/controllers.dart';

class ChangePassScreen extends StatefulWidget {
  const ChangePassScreen({super.key});

  @override
  State<ChangePassScreen> createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();
  @override
  void dispose() {
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
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Modificación de contraseña,",
                  style: TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 120,
                ),
                InputTextField(
                  title: 'Nueva contraseña',
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
                const SizedBox(height: 200),
                InputTextButton(
                  title: "Modificar",
                  onClick: () {
                    if (_formKey.currentState!.validate()) {
                      authController.cambiaPass(rut: authController.user.value!.rut, password: passwordController.text);
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
