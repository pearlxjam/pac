// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preguntas_encuestas.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreguntasEncuestas _$PreguntasEncuestasFromJson(Map<String, dynamic> json) =>
    PreguntasEncuestas(
      id: json['id'] as int,
      pregunta: json['pregunta'] as String,
      descripcion: json['descripcion'] as String?,
      estado: json['estado'] as String,
      tipoRespuesta: json['tipoRespuesta'] as String,
    );

Map<String, dynamic> _$PreguntasEncuestasToJson(PreguntasEncuestas instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pregunta': instance.pregunta,
      'descripcion': instance.descripcion,
      'estado': instance.estado,
      'tipoRespuesta': instance.tipoRespuesta,
    };
