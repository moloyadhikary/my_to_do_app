part of 'task_detail_bloc.dart';

sealed class TaskDetailEvent extends Equatable {
  const TaskDetailEvent();

  @override
  List<Object> get props => [];
}

class OnLoadTaskComments extends TaskDetailEvent {
  const OnLoadTaskComments({required this.taskId});

  final String taskId;

  @override
  List<Object> get props => [taskId];
}

class OnCreateComment extends TaskDetailEvent {
  const OnCreateComment({
    required this.taskId,
    required this.comment,
  });

  final String taskId;
  final String comment;

  @override
  List<Object> get props => [taskId, comment];
}

class OnTaskStart extends TaskDetailEvent {
  const OnTaskStart({
    required this.taskId,
  });

  final String taskId;

  @override
  List<Object> get props => [taskId];
}

class OnStopTask extends TaskDetailEvent {
  const OnStopTask({
    required this.taskId,
  });

  final String taskId;

  @override
  List<Object> get props => [taskId];
}

class OnTaskMarkedCompleted extends TaskDetailEvent {
  const OnTaskMarkedCompleted({
    required this.taskId,
  });

  final String taskId;

  @override
  List<Object> get props => [taskId];
}
