import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_to_do_app/helpers/local_storage/model/task_running_history_hive_model.dart';

enum TaskRunningHistorySaveResult { success, failure }

class TaskRunningHistoryHiveOperation {
  late Box<TaskRunningHistoryHiveModel> __taskRunningHistoryHiveModel;

  Future<TaskRunningHistorySaveResult> save({
    required TaskRunningHistoryHiveModel objToSave,
  }) async {
    try {
      __taskRunningHistoryHiveModel =
          await Hive.openBox<TaskRunningHistoryHiveModel>(
        'taskRunningHistoryBox',
      );
      var addedTasks = __taskRunningHistoryHiveModel.values.toList();
      if (addedTasks.isEmpty) {
        await __taskRunningHistoryHiveModel.add(
          objToSave,
        );
      } else {
        var thisTaskIndex =
            addedTasks.indexWhere((e) => e.taskId == objToSave.taskId);
        if (thisTaskIndex > -1) {
          // This task is already added

          final Map<dynamic, TaskRunningHistoryHiveModel> deliveriesMap =
              __taskRunningHistoryHiveModel.toMap();
          dynamic desiredKey;
          deliveriesMap.forEach((key, value) {
            if (value.taskId == objToSave.taskId) desiredKey = key;
          });
          __taskRunningHistoryHiveModel.delete(desiredKey);
        }
        await __taskRunningHistoryHiveModel.add(
          objToSave,
        );
      }
      return TaskRunningHistorySaveResult.success;
    } on Exception {
      return TaskRunningHistorySaveResult.failure;
    }
  }

  Future<TaskRunningHistoryHiveModel?> get(String taskId) async {
    try {
      __taskRunningHistoryHiveModel =
          await Hive.openBox<TaskRunningHistoryHiveModel>(
        'taskRunningHistoryBox',
      );
      var addedTasks = __taskRunningHistoryHiveModel.values.toList();
      if (addedTasks.isNotEmpty) {
        var thisTaskIndex = addedTasks.indexWhere((e) => e.taskId == taskId);
        if (thisTaskIndex > -1) {
          // This task is already added
          return addedTasks[thisTaskIndex];
        }
      }
    } catch (e) {
      //No Object Found
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  Future<List<TaskRunningHistoryHiveModel>> getCompletedTasks() async {
    try {
      __taskRunningHistoryHiveModel =
          await Hive.openBox<TaskRunningHistoryHiveModel>(
        'taskRunningHistoryBox',
      );
      var addedTasks = __taskRunningHistoryHiveModel.values.toList();
      if (addedTasks.isNotEmpty) {
        var completedTasks =
            addedTasks.where((e) => e.markCompletedOn != null).toList();
        return completedTasks;
      }
    } catch (e) {
      //No Object Found
      if (kDebugMode) {
        print(e);
      }
    }
    return [];
  }

  Future<void> clearData() async {
    __taskRunningHistoryHiveModel =
        await Hive.openBox<TaskRunningHistoryHiveModel>(
      'taskRunningHistoryBox',
    );

    final Map<dynamic, TaskRunningHistoryHiveModel> deliveriesMap =
        __taskRunningHistoryHiveModel.toMap();
    deliveriesMap.forEach((key, value) {
      __taskRunningHistoryHiveModel.delete(key);
    });
  }
}
