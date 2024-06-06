import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pac/controller/controllers.dart';
import 'package:pac/model/modelos.dart';
import 'package:pac/service/local_service/local_auth_service.dart';
import 'package:pac/service/remote_service/remote_auth_service.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  Rxn<User> user = Rxn<User>();
  final LocalAuthService _localAuthService = LocalAuthService();

  @override
  void onInit() async {
    await _localAuthService.init();
    super.onInit();
  }

  void signUp({
    required String rut,
    required String nombres,
    required String nombres2,
    required String apellidoPaterno,
    required String apellidoMaterno,
    required String email,
    required String telefono,
    required String direccion,
    required String genero,
    required String fechaNacimiento,
    required String contrasenia,
  }) async {
    try {
      EasyLoading.show(
        status: 'Cargando...',
        dismissOnTap: false,
      );
      var result = await RemoteAuthService().revisaUsuario(rut: rut, correo: email);
      if (result.statusCode == 200) {
        List<dynamic> data = jsonDecode(result.body);
        final int tieneRut = data[0]['tieneRut'];
        final int tieneCorreo = data[0]['tieneCorreo'];
        bool continuaRut = false, continuaCorreo = false;
        if (tieneRut == 0) {
          continuaRut = true;
        } else {
          EasyLoading.showError('El RUT ingresado ya existe en nuestra base de datos!');
        }
        if (tieneCorreo == 0) {
          continuaCorreo = true;
        } else {
          EasyLoading.showError('El correo ingresado ya existe en nuestra base de datos!');
        }

        if (continuaCorreo == true && continuaRut == true) {
          result = RemoteAuthService().creaUsuario(
              rut: rut,
              nombres: nombres,
              nombres2: nombres2,
              apellidoPaterno: apellidoPaterno,
              apellidoMaterno: apellidoMaterno,
              email: email,
              telefono: telefono,
              direccion: direccion,
              fechaNacimiento: fechaNacimiento,
              genero: genero,
              contrasenia: contrasenia);
          EasyLoading.showSuccess("Bienvenid@, has completado exitosamente tu inscripción. Solo debes esperar la validación del administrador para que puedas disfrutar de tus beneficios");
          Navigator.of(Get.overlayContext!).pop();
        }
      }
    } catch (e) {
      EasyLoading.showError('Algo extraño ha pasado, intenta nuevamente!');
    } finally {
      EasyLoading.dismiss();
    }
  }

  void signIn({required String rut, required String password}) async {
    try {
      EasyLoading.show(
        status: 'Cargando...',
        dismissOnTap: false,
      );
      var result = await RemoteAuthService().signIn(
        rut: rut,
        password: password,
      );
      if (result.statusCode == 200) {
        String token = json.decode(result.body)[0]['jwt'];
        if (token == '0') {
          EasyLoading.showError('Usuario o contraseña incorrecto');
        } else {
          var userResult = await RemoteAuthService().getProfile(token: token);

          if (userResult.statusCode == 200) {
            user.value = userFromJson(userResult.body);
            await _localAuthService.addToken(token: token);
            await _localAuthService.addUser(user: user.value!);
            var nombre = user.value?.fullName;
            var estado = user.value?.estado;

            if (estado == 0) {
              EasyLoading.showSuccess("Estimado, $nombre, Tu usuario ha sido desactivado, si esto es un error comunícate con nosotros en nuestra pagina web.");
              Navigator.of(Get.overlayContext!).pop();
            } else {
              EasyLoading.showSuccess("Hola, $nombre, Bienvenida/o a tus descuentos");
              Navigator.of(Get.overlayContext!).pop();
            }
          } else {
            EasyLoading.showError('Algo extraño ha pasado, intenta nuevamente!');
          }
        }
      } else {
        EasyLoading.showError('Usuario o contraseña incorrecto');
      }
    } catch (e) {
      debugPrint(e.toString());
      EasyLoading.showError('Algo extraño ha pasado, intenta nuevamente!');
    } finally {
      EasyLoading.dismiss();
    }
  }

  void verificaCodigo({required String rut, required String codigo, required String password}) async {
    try {
      EasyLoading.show(
        status: 'Cargando...',
        dismissOnTap: false,
      );
      var resultRevisa = await RemoteAuthService().revisaCodigo(rut: rut, codigo: codigo, password: password);

      if (resultRevisa.statusCode == 200) {
        List<dynamic> data = jsonDecode(resultRevisa.body);

        final int codigoValido = data[0]['codigoValido'];

        bool boolCodigo = false;
        if (codigoValido == 1) {
          boolCodigo = true;
        } else {
          EasyLoading.showError('El código ingresado no es correcto!');
        }
        if (boolCodigo == true) {
          authController.signIn(rut: rut, password: password);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
      EasyLoading.showError('Algo extraño ha pasado, intenta nuevamente!');
    } finally {
      EasyLoading.dismiss();
    }
  }

  void cambiaPass({required String? rut, required String password}) async {
    try {
      EasyLoading.show(
        status: 'Cargando...',
        dismissOnTap: false,
      );
      var resultRevisa = await RemoteAuthService().cambiaPass(rut: rut, password: password);

      if (resultRevisa.statusCode == 200) {
        EasyLoading.showSuccess("Contraseña modificada!");
        Navigator.of(Get.overlayContext!).pop();
      }
    } catch (e) {
      debugPrint(e.toString());
      EasyLoading.showError('Algo extraño ha pasado, intenta nuevamente!');
    } finally {
      EasyLoading.dismiss();
    }
  }

  void resetPass({required String? rut, required String correo}) async {
    try {
      EasyLoading.show(
        status: 'Cargando...',
        dismissOnTap: false,
      );
      var resultRevisa = await RemoteAuthService().resetPass(rut: rut, correo: correo);

      if (resultRevisa.statusCode == 200) {
        EasyLoading.showSuccess("Enviamos una nueva contraseña a tu correo");
        Navigator.of(Get.overlayContext!).pop();
      }
    } catch (e) {
      debugPrint(e.toString());
      EasyLoading.showError('Algo extraño ha pasado, intenta nuevamente!');
    } finally {
      EasyLoading.dismiss();
    }
  }

  void subeImagen({required String? usuarioID, required File? imagen}) async {
    try {
      EasyLoading.show(
        status: 'Cargando...',
        dismissOnTap: false,
      );
      var resultRevisa = await RemoteAuthService().subeImagen(usuarioID: usuarioID, imagen: imagen);

      if (resultRevisa.statusCode == 200) {
        EasyLoading.showSuccess("Archivo subido!\nDebes esperar que un administrador valide tu dirección");
        Navigator.of(Get.overlayContext!).pop();
      }
    } catch (e) {
      debugPrint(e.toString());
      EasyLoading.showError('Algo extraño ha pasado, intenta nuevamente!');
    } finally {
      EasyLoading.dismiss();
    }
  }

  void signOut() async {
    EasyLoading.showError('Saliste de la aplicación. Hasta la proxima!');
    user.value = null;
    await _localAuthService.clear();
  }
}
