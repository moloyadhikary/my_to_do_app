part of 'completed_tasks_bloc.dart';

sealed class CompletedTasksEvent extends Equatable {
  const CompletedTasksEvent();

  @override
  List<Object> get props => [];
}

class OnLoadPage extends CompletedTasksEvent {
  const OnLoadPage();

  @override
  List<Object> get props => [];
}
