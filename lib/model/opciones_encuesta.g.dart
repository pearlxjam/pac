// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'opciones_encuesta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpcionesPreguntas _$OpcionesPreguntasFromJson(Map<String, dynamic> json) =>
    OpcionesPreguntas(
      id: (json['id'] as num).toInt(),
      votacionID: (json['votacionID'] as num).toInt(),
      preguntaID: (json['preguntaID'] as num).toInt(),
      estado: (json['estado'] as num).toInt(),
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
