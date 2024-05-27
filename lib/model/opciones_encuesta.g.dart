// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'opciones_encuesta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpcionesPreguntas _$OpcionesPreguntasFromJson(Map<String, dynamic> json) =>
    OpcionesPreguntas(
      id: json['id'] as int,
      votacionID: json['votacionID'] as int,
      preguntaID: json['preguntaID'] as int,
      estado: json['estado'] as int,
      opcion: json['opcion'] as String,
    );

Map<String, dynamic> _$OpcionesPreguntasToJson(OpcionesPreguntas instance) =>
    <String, dynamic>{
      'id': instance.id,
      'votacionID': instance.votacionID,
      'preguntaID': instance.preguntaID,
      'estado': instance.estado,
      'opcion': instance.opcion,
    };
