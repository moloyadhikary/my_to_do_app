import 'package:hive_flutter/hive_flutter.dart';

part 'task_running_history_hive_model.g.dart';

@HiveType(typeId: 1)
class TaskRunningHistoryHiveModel extends HiveObject {
  TaskRunningHistoryHiveModel({
    required this.taskId,
    required this.startedOn,
    this.endedOn,
    this.markCompletedOn,
    this.duration,
  });

  @HiveField(0)
  String taskId;

  @HiveField(1)
  String startedOn;

  @HiveField(2)
  String? endedOn;

  @HiveField(3)
  String? markCompletedOn;

  @HiveField(4)
  String? duration;
}
