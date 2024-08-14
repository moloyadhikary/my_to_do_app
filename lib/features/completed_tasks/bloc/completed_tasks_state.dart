part of 'completed_tasks_bloc.dart';

sealed class CompletedTasksState extends Equatable {
  const CompletedTasksState();

  @override
  List<Object> get props => [];
}

final class CompletedTasksInitial extends CompletedTasksState {}

class CompletedTaskLoading extends CompletedTasksState {
  const CompletedTaskLoading();

  @override
  List<Object> get props => [];
}

class CompletedTaskLoaded extends CompletedTasksState {
  const CompletedTaskLoaded({
    required this.tasks,
  });

  // final List<VmCompletedTask> tasks;
  final List<TaskRunningHistoryHiveModel> tasks;
  @override
  List<Object> get props => [tasks];
}

class CompletedaskFailed extends CompletedTasksState {
  const CompletedaskFailed({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
