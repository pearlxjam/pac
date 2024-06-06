import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pac/const/const.dart';
import 'package:pac/const/footer.dart';
import 'package:pac/controller/controllers.dart';
import 'package:pac/view/view.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 20),
          Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.white,
                      radius: 70,
                      backgroundImage: AssetImage("assets/logo_sin_fondo.png"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      authController.user.value?.fullName ?? "Ingresa a tu cuenta",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: verde),
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 50),
          Obx(
            () => authController.user.value == null
                ? const SizedBox()
                : buildAccountCard(
                    title: "Información",
                    onClick: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const InformacionPersonal(),
                        ),
                      );
                    }),
          ),
          Obx(
            () => authController.user.value == null
                ? const SizedBox()
                : buildAccountCard(
                    title: "Mis Descuentos",
                    onClick: () {
                      if (authController.user.value == null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignInScreen(),
                          ),
                        );
                      } else {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const MisDescuentos()));
                      }
                    }),
          ),
          buildAccountCard(
              title: "Términos y condiciones",
              onClick: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TerminosYCondiciones(),
                  ),
                );
              }),
          buildAccountCard(
              title: "Instructivo",
              onClick: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Instructivo(),
                  ),
                );
              }),
          Obx(
            () => authController.user.value == null
                ? const SizedBox()
                : buildAccountCard(
                    title: "Cambiar Contraseña",
                    onClick: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePassScreen()));
                    }),
          ),
          Obx(
            () => authController.user.value != null
                ? const SizedBox()
                : buildAccountCard(
                    title: "Registro",
                    onClick: () {
                      if (authController.user.value == null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      } else {}
                    }),
          ),
          Obx(
            () => buildAccountCard(
                title: authController.user.value == null ? "Ingresar" : "Salir",
                onClick: () {
                  if (authController.user.value != null) {
                    authController.signOut();
                  } else {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
                  }
                }),
          ),
          Obx(
            () {
              final user = authController.user.value;
              if (user != null) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.14,
                );
              } else {
                return SizedBox(height: MediaQuery.of(context).size.height * 0.23);
              }
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.225,
            child: const Align(
              alignment: FractionalOffset.bottomCenter,
              child: Footer(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAccountCard({required String title, required Function() onClick}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: GestureDetector(
        onTap: () {
          onClick();
        },
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(color: amarillo, borderRadius: const BorderRadius.all(Radius.circular(12)), boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 0.1,
              blurRadius: 7,
            )
          ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
              const Icon(Icons.keyboard_arrow_right_outlined)
            ],
          ),
        ),
      ),
    );
  }
}
