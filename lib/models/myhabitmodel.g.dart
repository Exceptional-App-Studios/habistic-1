// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'myhabitmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyHabitModelAdapter extends TypeAdapter<MyHabitModel> {
  @override
  final int typeId = 0;

  @override
  MyHabitModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyHabitModel(
      name: fields[0] as String,
      type: fields[1] as String,
      complete: fields[2] as bool,
      reminder: fields[3] as String,
      totaldays: fields[4] as int,
      totaltime: fields[5] as int,
      todaytime: fields[6] as int,
      avgtime: fields[7] as int,
      minigoal: fields[8] as int,
      donedates: (fields[9] as List)?.cast<String>(),
      everydaytime: (fields[10] as List)?.cast<int>(),
      trackway: fields[11] as String,
      streak: fields[12] as int,
    )..skipped = fields[13] as bool;
  }

  @override
  void write(BinaryWriter writer, MyHabitModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.complete)
      ..writeByte(3)
      ..write(obj.reminder)
      ..writeByte(4)
      ..write(obj.totaldays)
      ..writeByte(5)
      ..write(obj.totaltime)
      ..writeByte(6)
      ..write(obj.todaytime)
      ..writeByte(7)
      ..write(obj.avgtime)
      ..writeByte(8)
      ..write(obj.minigoal)
      ..writeByte(9)
      ..write(obj.donedates)
      ..writeByte(10)
      ..write(obj.everydaytime)
      ..writeByte(11)
      ..write(obj.trackway)
      ..writeByte(12)
      ..write(obj.streak)
      ..writeByte(13)
      ..write(obj.skipped);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyHabitModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
