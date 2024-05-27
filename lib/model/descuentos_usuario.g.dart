// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'descuentos_usuario.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DescuentosUsuario _$DescuentosUsuarioFromJson(Map<String, dynamic> json) =>
    DescuentosUsuario(
      fechaDescarga: json['fechaDescarga'] as String?,
      tituloDescuento: json['tituloDescuento'] as String?,
      descripcionDescuento: json['descripcionDescuento'] as String?,
      fechaInicioDescuento: json['fechaInicioDescuento'] as String?,
      fechaTerminoDescuento: json['fechaTerminoDescuento'] as String?,
      estadoDescuento: json['estadoDescuento'] as String?,
      nombreEmpresa: json['nombreEmpresa'] as String?,
      imagenDescuento: json['imagenDescuento'] as String?,
      descuentoID: json['descuentoID'] as int,
    );

Map<String, dynamic> _$DescuentosUsuarioToJson(DescuentosUsuario instance) =>
    <String, dynamic>{
      'fechaDescarga': instance.fechaDescarga,
      'tituloDescuento': instance.tituloDescuento,
      'descripcionDescuento': instance.descripcionDescuento,
      'fechaInicioDescuento': instance.fechaInicioDescuento,
      'fechaTerminoDescuento': instance.fechaTerminoDescuento,
      'estadoDescuento': instance.estadoDescuento,
      'nombreEmpresa': instance.nombreEmpresa,
      'imagenDescuento': instance.imagenDescuento,
      'descuentoID': instance.descuentoID,
    };
