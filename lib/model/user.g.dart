// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 4;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as String?,
      fullName: fields[1] as String?,
      email: fields[2] as String?,
      image: fields[3] as String?,
      birthDay: fields[4] as DateTime?,
      rut: fields[5] as String?,
      estado: fields[6] as int?,
      perfilID: fields[7] as int?,
      direccion: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.fullName)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.birthDay)
      ..writeByte(5)
      ..write(obj.rut)
      ..writeByte(6)
      ..write(obj.estado)
      ..writeByte(7)
      ..write(obj.perfilID)
      ..writeByte(8)
      ..write(obj.direccion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
