import 'package:json_annotation/json_annotation.dart';

part 'encuesta_usuario.g.dart';

@JsonSerializable()
class EncuestaUsuario {
  int id;
  String titulo;
  String fechaInicio;
  String fechaTermino;
  String descripcion;
  String? imagen;
  int estadoVotacion;
  int estadoVotante;

  EncuestaUsuario({
    required this.id,
    required this.titulo,
    required this.fechaInicio,
    required this.fechaTermino,
    required this.descripcion,
    required this.imagen,
    required this.estadoVotacion,
    required this.estadoVotante,
  });
  factory EncuestaUsuario.fromJson(Map<String, dynamic> data) => _$EncuestaUsuarioFromJson(data);
  Map<String, dynamic> toJson() => _$EncuestaUsuarioToJson(this);
}
