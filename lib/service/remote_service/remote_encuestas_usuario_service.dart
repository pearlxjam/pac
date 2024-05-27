import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:pac/model/modelos.dart';

Future<List<EncuestaUsuario>> getEncuestasUsuario(usuarioID) async {
  DateTime currentDate = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
  String url = 'https://www.tarjetavecinopac.com/api/datosEncuesta.php?usuarioID=$usuarioID&fechaActual=$formattedDate';

  final response = await get(Uri.parse(url));

  return await Future.delayed(const Duration(seconds: 2), () {
    List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));

    List<EncuestaUsuario> encuestasUsuario = data.map((data) => EncuestaUsuario.fromJson(data)).toList();
    return encuestasUsuario;
  });
}
