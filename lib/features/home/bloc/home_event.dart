part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class OnLoadPage extends HomeEvent {
  const OnLoadPage();

  @override
  List<Object> get props => [];
}

class OnMoveTask extends HomeEvent {
  const OnMoveTask({
    required this.taskId,
    required this.newSectionId,
  });

  final String taskId;
  final String newSectionId;

  @override
  List<Object> get props => [taskId, newSectionId];
}
