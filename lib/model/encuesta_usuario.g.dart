// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encuesta_usuario.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EncuestaUsuario _$EncuestaUsuarioFromJson(Map<String, dynamic> json) =>
    EncuestaUsuario(
      id: (json['id'] as num).toInt(),
      titulo: json['titulo'] as String,
      fechaInicio: json['fechaInicio'] as String,
      fechaTermino: json['fechaTermino'] as String,
      descripcion: json['descripcion'] as String,
      imagen: json['imagen'] as String?,
      estadoVotacion: (json['estadoVotacion'] as num).toInt(),
      estadoVotante: (json['estadoVotante'] as num).toInt(),
    );

Map<String, dynamic> _$EncuestaUsuarioToJson(EncuestaUsuario instance) =>
    <String, dynamic>{
      'id': instance.id,
      'titulo': instance.titulo,
      'fechaInicio': instance.fechaInicio,
      'fechaTermino': instance.fechaTermino,
      'descripcion': instance.descripcion,
      'imagen': instance.imagen,
      'estadoVotacion': instance.estadoVotacion,
      'estadoVotante': instance.estadoVotante,
    };
