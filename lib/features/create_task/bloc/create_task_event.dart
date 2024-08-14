part of 'create_task_bloc.dart';

sealed class CreateTaskEvent extends Equatable {
  const CreateTaskEvent();

  @override
  List<Object> get props => [];
}

class OnLoadPage extends CreateTaskEvent {
  const OnLoadPage();

  @override
  List<Object> get props => [];
}

class OnCreateTask extends CreateTaskEvent {
  const OnCreateTask({
    required this.content,
    required this.description,
    required this.dueDate,
    required this.sectionId,
  });

  final String content;
  final String description;
  final String dueDate;
  final String sectionId;
  @override
  List<Object> get props => [content, description, dueDate, sectionId];
}
