part of 'setting_bloc.dart';

class SettingState extends Equatable {
  const SettingState({
    required this.themeType,
  });

  final ThemeType themeType;

  @override
  List<Object> get props => [themeType];
}

class SettingInitial extends SettingState {
  const SettingInitial()
      : super(
          themeType: ThemeType.light,
        );

  @override
  List<Object> get props => [];
}

class SettingLoaded extends SettingState {
  const SettingLoaded({required super.themeType});

  @override
  List<Object> get props => [themeType];
}
