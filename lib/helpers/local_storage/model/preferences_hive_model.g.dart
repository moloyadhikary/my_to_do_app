// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preferences_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PreferencesHiveModelAdapter extends TypeAdapter<PreferencesHiveModel> {
  @override
  final int typeId = 0;

  @override
  PreferencesHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PreferencesHiveModel(
      themeType: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PreferencesHiveModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.themeType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PreferencesHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
