import 'package:json_annotation/json_annotation.dart';

part 'descuentos_usuario.g.dart';

@JsonSerializable()
class DescuentosUsuario {
  String? fechaDescarga;
  String? tituloDescuento;
  String? descripcionDescuento;
  String? fechaInicioDescuento;
  String? fechaTerminoDescuento;
  String? estadoDescuento;
  String? nombreEmpresa;
  String? imagenDescuento;
  int descuentoID;

  DescuentosUsuario({
    required this.fechaDescarga,
    required this.tituloDescuento,
    required this.descripcionDescuento,
    required this.fechaInicioDescuento,
    required this.fechaTerminoDescuento,
    required this.estadoDescuento,
    required this.nombreEmpresa,
    required this.imagenDescuento,
    required this.descuentoID,
  });
  factory DescuentosUsuario.fromJson(Map<String, dynamic> data) => _$DescuentosUsuarioFromJson(data);
  Map<String, dynamic> toJson() => _$DescuentosUsuarioToJson(this);
}
