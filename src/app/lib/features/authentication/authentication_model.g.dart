// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthenticationModelAdapter extends TypeAdapter<AuthenticationModel> {
  @override
  final int typeId = 1;

  @override
  AuthenticationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuthenticationModel(
      token: fields[0] as String,
      scope: fields[1] as String,
      tokenType: fields[2] as String,
      expiresIn: fields[3] as int,
      clientId: fields[4] as String?,
      login: fields[5] as String?,
      scopes: (fields[6] as List?)?.cast<String>(),
      userId: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AuthenticationModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.token)
      ..writeByte(1)
      ..write(obj.scope)
      ..writeByte(2)
      ..write(obj.tokenType)
      ..writeByte(3)
      ..write(obj.expiresIn)
      ..writeByte(4)
      ..write(obj.clientId)
      ..writeByte(5)
      ..write(obj.login)
      ..writeByte(6)
      ..write(obj.scopes)
      ..writeByte(7)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthenticationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
