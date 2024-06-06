import 'package:json_annotation/json_annotation.dart';

part 'opciones_encuesta.g.dart';

@JsonSerializable()
class OpcionesPreguntas {
  int id;
  int votacionID;
  int preguntaID;
  int estado;
  String opcion;

  OpcionesPreguntas({
    required this.id,
    required this.votacionID,
    required this.preguntaID,
    required this.estado,
    required this.opcion,
  });
  factory OpcionesPreguntas.fromJson(Map<String, dynamic> data) => _$OpcionesPreguntasFromJson(data);
  Map<String, dynamic> toJson() => _$OpcionesPreguntasToJson(this);
}
