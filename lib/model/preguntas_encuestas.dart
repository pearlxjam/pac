import 'package:json_annotation/json_annotation.dart';

part 'preguntas_encuestas.g.dart';

@JsonSerializable()
class PreguntasEncuestas {
  int id;
  String pregunta;
  String? descripcion;
  String estado;
  String tipoRespuesta;

  PreguntasEncuestas({
    required this.id,
    required this.pregunta,
    required this.descripcion,
    required this.estado,
    required this.tipoRespuesta,
  });
  factory PreguntasEncuestas.fromJson(Map<String, dynamic> data) =>
      _$PreguntasEncuestasFromJson(data);
  Map<String, dynamic> toJson() => _$PreguntasEncuestasToJson(this);
}
