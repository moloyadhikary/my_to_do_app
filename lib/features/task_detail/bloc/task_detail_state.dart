part of 'task_detail_bloc.dart';

sealed class TaskDetailState extends Equatable {
  const TaskDetailState();

  @override
  List<Object> get props => [];
}

final class TaskDetailInitial extends TaskDetailState {}

class TaskDetailLoading extends TaskDetailState {
  const TaskDetailLoading();

  @override
  List<Object> get props => [];
}

class TaskDetailFailed extends TaskDetailState {
  const TaskDetailFailed({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}

class TaskCommentsLoaded extends TaskDetailState {
  const TaskCommentsLoaded({required this.comments});

  final List<Comment> comments;

  @override
  List<Object> get props => [comments];
}

class TaskStartStopSuccess extends TaskDetailState {
  const TaskStartStopSuccess({
    required this.taskRunningStatus,
    required this.shouldReload,
  });

  final TaskRunningHistoryHiveModel taskRunningStatus;
  final bool shouldReload;

  @override
  List<Object> get props => [shouldReload, taskRunningStatus];
}
