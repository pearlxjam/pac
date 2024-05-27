import 'dart:io';

import 'package:http/http.dart' as http;

class RemoteAuthService {
  var client = http.Client();

  Future<dynamic> signIn({
    required String rut,
    required String password,
  }) async {
    var url = 'https://www.tarjetavecinopac.com/api/usuarios.php?usuario=$rut&password=$password';

    var response = await client.get(Uri.parse(url));

    return response;
  }

  Future<dynamic> getProfile({
    required String token,
  }) async {
    var url = 'https://www.tarjetavecinopac.com/api/datosUsuario.php?token=$token';

    var response = await client.get(
      Uri.parse(url),
    );

    return response;
  }

  Future<dynamic> revisaUsuario({
    required String rut,
    required String correo,
  }) async {
    var url = 'https://www.tarjetavecinopac.com/api/revisaUsuario.php?rut=$rut&correo=$correo';

    var response = await client.get(Uri.parse(url));

    return response;
  }

  Future<dynamic> revisaCodigo({
    required String rut,
    required String codigo,
    required String password,
  }) async {
    var url = 'https://www.tarjetavecinopac.com/api/revisaCodigo.php?rut=$rut&codigo=$codigo&password=$password';

    var response = await client.get(Uri.parse(url));

    return response;
  }

  Future<dynamic> cambiaPass({
    required String? rut,
    required String password,
  }) async {
    var url = 'https://www.tarjetavecinopac.com/api/cambiaPass.php?rut=$rut&password=$password';

    var response = await client.get(Uri.parse(url));

    return response;
  }

  Future<dynamic> resetPass({
    required String? rut,
    required String correo,
  }) async {
    var url = 'https://www.tarjetavecinopac.com/api/resetPass.php?rut=$rut&correo=$correo';

    var response = await client.get(Uri.parse(url));

    return response;
  }

  Future<dynamic> subeImagen({
    required String? usuarioID,
    required File? imagen,
  }) async {
    var url = 'https://www.tarjetavecinopac.com/api/subeImagen.php';
    final uri = Uri.parse(url);
    var request = http.MultipartRequest('POST', uri);
    request.fields['usuarioID'] = usuarioID!;

    var pic = await http.MultipartFile.fromPath('image', imagen!.path);
    request.files.add(pic);

    var response = await request.send();

    return response;
  }

  Future<dynamic> creaUsuario(
      {required String rut,
      required String nombres,
      required String nombres2,
      required String apellidoPaterno,
      required String apellidoMaterno,
      required String email,
      required String telefono,
      required String direccion,
      required String genero,
      required String fechaNacimiento,
      required String contrasenia}) async {
    final Map<String, String> body = {
      'rut': rut,
      'nombres': nombres,
      'nombres2': nombres2,
      'apellidoPaterno': apellidoPaterno,
      'apellidoMaterno': apellidoMaterno,
      'email': email,
      'telefono': telefono,
      'direccion': direccion,
      'genero': genero,
      'fechaNacimiento': fechaNacimiento,
      'contrasenia': contrasenia,
    };
    var url = 'https://www.tarjetavecinopac.com/api/creaUsuario.php';

    var response = await client.post(Uri.parse(url), body: body);

    return response;
  }
}
