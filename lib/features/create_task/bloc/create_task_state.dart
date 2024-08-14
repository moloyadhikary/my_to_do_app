part of 'create_task_bloc.dart';

sealed class CreateTaskState extends Equatable {
  const CreateTaskState();

  @override
  List<Object> get props => [];
}

final class CreateTaskInitial extends CreateTaskState {}

class CreateTaskLoading extends CreateTaskState {
  const CreateTaskLoading();

  @override
  List<Object> get props => [];
}

class CreateTaskLoaded extends CreateTaskState {
  const CreateTaskLoaded({
    required this.sections,
  });

  final ProejctSection sections;
  @override
  List<Object> get props => [sections];
}

class CreateTaskFailed extends CreateTaskState {
  const CreateTaskFailed({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}

class CreateTaskSuccess extends CreateTaskState {
  const CreateTaskSuccess();

  @override
  List<Object> get props => [];
}
