part of 'update_task_bloc.dart';

sealed class UpdateTaskState extends Equatable {
  const UpdateTaskState();

  @override
  List<Object> get props => [];
}

final class UpdateTaskInitial extends UpdateTaskState {}

class UpdateTaskLoading extends UpdateTaskState {
  const UpdateTaskLoading();

  @override
  List<Object> get props => [];
}

class UpdateTaskLoaded extends UpdateTaskState {
  const UpdateTaskLoaded({
    required this.sections,
  });

  final ProejctSection sections;
  @override
  List<Object> get props => [sections];
}

class UpdateTaskFailed extends UpdateTaskState {
  const UpdateTaskFailed({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}

class UpdateTaskSuccess extends UpdateTaskState {
  const UpdateTaskSuccess();

  @override
  List<Object> get props => [];
}
