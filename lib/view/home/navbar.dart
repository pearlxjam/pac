import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pac/controller/controllers.dart';
import 'package:pac/view/view.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final bool customIcon = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Obx(
            () => authController.user.value == null
                ? UserAccountsDrawerHeader(
                    accountName: const Text(
                      "Ingresa a tu cuenta",
                      style: TextStyle(color: Colors.white),
                    ),
                    accountEmail: const Text(''),
                    decoration: BoxDecoration(
                      color: Colors.blue[200],
                      image: const DecorationImage(image: AssetImage('assets/fondo_pac.jpg'), fit: BoxFit.cover),
                    ),
                  )
                : UserAccountsDrawerHeader(
                    accountName: Text(
                      authController.user.value?.fullName ?? "Ingresa a tu cuenta",
                      style: const TextStyle(color: Colors.white),
                    ),
                    accountEmail: Text(authController.user.value?.email ?? "Ingresa a tu cuenta", style: const TextStyle(color: Colors.white)),
                    currentAccountPicture: CircleAvatar(
                      child: ClipOval(
                        child: Image.asset('assets/logo_sin_fondo.png'),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue[200],
                      image: const DecorationImage(image: AssetImage('assets/fondo_pac.jpg'), fit: BoxFit.cover),
                    ),
                  ),
          ),
          ExpansionTile(
            title: const Text('Documentos'),
            controlAffinity: ListTileControlAffinity.leading,
            children: <Widget>[
              ListTile(
                leading: const FaIcon(FontAwesomeIcons.fileContract),
                title: const Text('Términos y condiciones'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TerminosYCondiciones(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const FaIcon(FontAwesomeIcons.fileContract),
                title: const Text('Instructivo'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Instructivo(),
                    ),
                  );
                },
              ),
            ],
          ),
          Obx(
            () => authController.user.value != null
                ? ExpansionTile(
                    title: const Text('Mi cuenta'),
                    controlAffinity: ListTileControlAffinity.leading,
                    children: <Widget>[
                      Obx(
                        () => authController.user.value != null
                            ? ListTile(
                                leading: const FaIcon(FontAwesomeIcons.idCard),
                                title: const Text('Mis Datos'),
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const InformacionPersonal(),
                                    ),
                                  );
                                },
                              )
                            : const SizedBox(),
                      ),
                      Obx(
                        () => authController.user.value != null && authController.user.value?.estado == 1
                            ? ListTile(
                                leading: const FaIcon(FontAwesomeIcons.key),
                                title: const Text('Cambiar Contraseña'),
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const ChangePassScreen(),
                                    ),
                                  );
                                },
                              )
                            : const SizedBox(),
                      ),
                    ],
                  )
                : const SizedBox(),
          ),
          Obx(
            () => authController.user.value != null && authController.user.value?.estado == 1
                ? ListTile(
                    leading: const FaIcon(FontAwesomeIcons.ticket),
                    title: const Text('Mis Descuentos'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MisDescuentos(),
                        ),
                      );
                    },
                  )
                : const SizedBox(),
          ),
          Obx(
            () => authController.user.value != null && authController.user.value?.estado == 1
                ? ListTile(
                    leading: const FaIcon(FontAwesomeIcons.creditCard),
                    title: const Text('Mi Tarjeta Vecino'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MiTarjeta(),
                        ),
                      );
                    },
                  )
                : const SizedBox(),
          ),
          Obx(
            () => authController.user.value == null
                ? ListTile(
                    leading: const FaIcon(FontAwesomeIcons.arrowRightToBracket),
                    title: const Text('Ingresar'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInScreen(),
                        ),
                      );
                    },
                  )
                : ListTile(
                    leading: const FaIcon(FontAwesomeIcons.arrowRightFromBracket),
                    title: const Text('Salir'),
                    onTap: () {
                      Navigator.pop(context);
                      authController.signOut();
                    },
                  ),
          ),
          Obx(
            () => authController.user.value == null
                ? ListTile(
                    leading: const FaIcon(FontAwesomeIcons.fileSignature),
                    title: const Text('Registro'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                  )
                : const SizedBox(),
          ),
          Obx(
            () => authController.user.value != null && authController.user.value?.estado == 4
                ? ListTile(
                    leading: const FaIcon(FontAwesomeIcons.fileArrowUp),
                    title: const Text('Verificar dirección'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const VerificaDireccion(),
                        ),
                      );
                    },
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
