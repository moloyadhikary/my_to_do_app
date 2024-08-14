part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {
  const HomeLoading();

  @override
  List<Object> get props => [];
}

class HomeLoaded extends HomeState {
  const HomeLoaded({
    required this.sections,
  });

  final List<VmSectionDetail> sections;
  @override
  List<Object> get props => [sections];
}

class HomeFailed extends HomeState {
  const HomeFailed({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
