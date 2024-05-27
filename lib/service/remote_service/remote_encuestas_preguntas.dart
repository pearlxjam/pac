import 'dart:convert';

import 'package:http/http.dart';
import 'package:pac/model/modelos.dart';

Future<List<PreguntasEncuestas>> getPreguntasEncuesta(encuestaID) async {
  String url = 'https://www.tarjetavecinopac.com/api/datosPreguntas.php?votacionID=$encuestaID';

  final response = await get(Uri.parse(url));

  return await Future.delayed(const Duration(seconds: 2), () {
    List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));

    List<PreguntasEncuestas> preguntas = data.map((data) => PreguntasEncuestas.fromJson(data)).toList();
    return preguntas;
  });
}
