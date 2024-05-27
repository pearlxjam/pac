import 'dart:convert';

import 'package:http/http.dart';
import 'package:pac/model/modelos.dart';

Future<List<DescuentosUsuario>> getResumenDescuentosUsuarios(usuarioID) async {
  String url = 'https://www.tarjetavecinopac.com/api/datosDescuentoUsuario.php?usuarioID=$usuarioID';

  final response = await get(Uri.parse(url));

  return await Future.delayed(const Duration(seconds: 2), () {
    List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));

    List<DescuentosUsuario> descuentos = data.map((data) => DescuentosUsuario.fromJson(data)).toList();
    return descuentos;
  });
}
