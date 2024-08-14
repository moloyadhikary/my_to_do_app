import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:humanize_duration/humanize_duration.dart';
import 'package:my_to_do_app/core/data_access/repositories/repository_remote_data.dart';
import 'package:my_to_do_app/core/models/task_comments/comment.dart';
import 'package:my_to_do_app/helpers/local_storage/model/task_running_history_hive_model.dart';
import 'package:my_to_do_app/helpers/local_storage/operation/task_running_history_hive_operation.dart';

part 'task_detail_event.dart';
part 'task_detail_state.dart';

class TaskDetailBloc extends Bloc<TaskDetailEvent, TaskDetailState> {
  TaskDetailBloc() : super(TaskDetailInitial()) {
    on<TaskDetailEvent>((event, emit) {});
    on<OnLoadTaskComments>((event, emit) async {
      //emit(const TaskDetailLoading());

      // var ops = TaskRunningHistoryHiveOperation();
      // await ops.clearData();

      var comments = await _repositoryRemoteData.getTaskComments(event.taskId);

      if (comments.hasError) {
        emit(const TaskCommentsLoaded(comments: []));
        return;
      }

      emit(
        TaskCommentsLoaded(
          comments: comments.taskComments!.comments ?? [],
        ),
      );
    });

    on<OnCreateComment>((event, emit) async {
      emit(const TaskDetailLoading());

      var createComment = await _repositoryRemoteData.createComment(
          event.taskId, event.comment);

      if (createComment.hasError) {
        emit(const TaskDetailFailed(message: 'Failed to create comment'));
      }

      var comments = await _repositoryRemoteData.getTaskComments(event.taskId);

      if (comments.hasError) {
        emit(const TaskCommentsLoaded(comments: []));
        return;
      }

      emit(
        TaskCommentsLoaded(
          comments: comments.taskComments!.comments ?? [],
        ),
      );
    });

    on<OnTaskStart>((event, emit) async {
      emit(const TaskDetailLoading());

      var ops = TaskRunningHistoryHiveOperation();

      var taskRunningStatus = TaskRunningHistoryHiveModel(
          taskId: event.taskId, startedOn: DateTime.now().toString());

      var saveStatus = await ops.save(objToSave: taskRunningStatus);
      if (saveStatus == TaskRunningHistorySaveResult.success) {
        emit(TaskStartStopSuccess(
          taskRunningStatus: taskRunningStatus,
          shouldReload: false,
        ));
        return;
      }

      emit(const TaskDetailFailed(message: 'Task running status failed'));
    });

    on<OnStopTask>((event, emit) async {
      emit(const TaskDetailLoading());

      var ops = TaskRunningHistoryHiveOperation();

      var taskRunningStatus = await ops.get(event.taskId);

      if (taskRunningStatus == null) {
        emit(const TaskDetailFailed(message: 'Stopping task failed'));
        return;
      }
      var now = DateTime.now();
      var startedDate = DateTime.parse(taskRunningStatus.startedOn);
      var diff = now.difference(startedDate);

      var durationString = humanizeDuration(
        diff,
        options: const HumanizeOptions(
          units: [Units.day, Units.hour, Units.minute, Units.second],
        ),
      );

      taskRunningStatus.endedOn = DateTime.now().toString();
      taskRunningStatus.duration = durationString;

      var saveStatus = await ops.save(objToSave: taskRunningStatus);
      if (saveStatus == TaskRunningHistorySaveResult.success) {
        emit(TaskStartStopSuccess(
          taskRunningStatus: taskRunningStatus,
          shouldReload: false,
        ));
        return;
      }

      emit(const TaskDetailFailed(message: 'Task running status failed'));
    });

    on<OnTaskMarkedCompleted>((event, emit) async {
      emit(const TaskDetailLoading());

      var status = await _repositoryRemoteData.taskMarkCompleted(
          event.taskId, DateTime.now().toUtc().toIso8601String());

      if (status.hasError) {
        emit(const TaskDetailFailed(message: 'Marking task failed'));
        return;
      }

      var ops = TaskRunningHistoryHiveOperation();

      var taskRunningStatus = await ops.get(event.taskId);

      if (taskRunningStatus == null) {
        emit(const TaskDetailFailed(message: 'Marking task failed'));
        return;
      }

      taskRunningStatus.markCompletedOn = DateTime.now().toString();

      var saveStatus = await ops.save(objToSave: taskRunningStatus);
      if (saveStatus == TaskRunningHistorySaveResult.success) {
        emit(TaskStartStopSuccess(
          taskRunningStatus: taskRunningStatus,
          shouldReload: true,
        ));
        return;
      }

      emit(const TaskDetailFailed(message: 'Marking task failed'));
    });
  }

  final _repositoryRemoteData = RepositoryRemoteData();
}
