// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WinnerAdapter extends TypeAdapter<Winner> {
  @override
  final int typeId = 1;

  @override
  Winner read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Winner(
      name: fields[0] as String,
      time: fields[1] as String,
      moves: fields[2] as int,
      size: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Winner obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.moves)
      ..writeByte(3)
      ..write(obj.size);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WinnerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
