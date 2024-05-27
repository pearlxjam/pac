import 'dart:convert';

import 'package:hive/hive.dart';

part 'user.g.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

@HiveType(typeId: 4)
class User {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? fullName;
  @HiveField(2)
  String? email;
  @HiveField(3)
  String? image;
  @HiveField(4)
  DateTime? birthDay;
  @HiveField(5)
  String? rut;
  @HiveField(6)
  int? estado;
  @HiveField(7)
  int? perfilID;
  @HiveField(8)
  String? direccion;

  User(
      {this.id,
      this.fullName,
      this.email,
      this.image,
      this.birthDay,
      this.rut,
      this.estado,
      this.perfilID,
      this.direccion});

  factory User.fromJson(Map<String, dynamic> data) => User(
        id: data['id'].toString(),
        fullName: data['fullName'],
        email: data['email'],
        image: data['image'] == null ? null : data['image']['url'],
        birthDay: data['fecha_nacimiento'] == null
            ? null
            : DateTime.parse(data['fecha_nacimiento']),
        rut: data['rut'],
        estado: data['estado'],
        perfilID: data['perfil_id'],
        direccion: data['direccion'],
      );
}
