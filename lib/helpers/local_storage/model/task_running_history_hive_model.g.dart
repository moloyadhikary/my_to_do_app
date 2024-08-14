// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_running_history_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskRunningHistoryHiveModelAdapter
    extends TypeAdapter<TaskRunningHistoryHiveModel> {
  @override
  final int typeId = 1;

  @override
  TaskRunningHistoryHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskRunningHistoryHiveModel(
      taskId: fields[0] as String,
      startedOn: fields[1] as String,
      endedOn: fields[2] as String?,
      markCompletedOn: fields[3] as String?,
      duration: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TaskRunningHistoryHiveModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.taskId)
      ..writeByte(1)
      ..write(obj.startedOn)
      ..writeByte(2)
      ..write(obj.endedOn)
      ..writeByte(3)
      ..write(obj.markCompletedOn)
      ..writeByte(4)
      ..write(obj.duration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskRunningHistoryHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
