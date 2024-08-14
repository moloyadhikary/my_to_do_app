part of 'update_task_bloc.dart';

sealed class UpdateTaskEvent extends Equatable {
  const UpdateTaskEvent();

  @override
  List<Object> get props => [];
}

class OnLoadPage extends UpdateTaskEvent {
  const OnLoadPage();

  @override
  List<Object> get props => [];
}

class OnUpdateTask extends UpdateTaskEvent {
  const OnUpdateTask({
    required this.taskId,
    required this.content,
    required this.description,
    required this.dueDate,
  });

  final String taskId;
  final String content;
  final String description;
  final String dueDate;
  @override
  List<Object> get props => [taskId, content, description, dueDate];
}
