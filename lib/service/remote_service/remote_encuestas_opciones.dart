import 'dart:convert';

import 'package:http/http.dart';
import 'package:pac/model/modelos.dart';

Future<List<OpcionesPreguntas>> getOpcionesPreguntas(encuestaID, preguntaID) async {
  String url = 'https://www.tarjetavecinopac.com/api/datosOpciones.php?votacionID=$encuestaID&preguntaID=$preguntaID';

  final response = await get(Uri.parse(url));

  return await Future.delayed(const Duration(seconds: 2), () {
    List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));

    List<OpcionesPreguntas> opciones = data.map((data) => OpcionesPreguntas.fromJson(data)).toList();
    return opciones;
  });
}
