part of 'setting_bloc.dart';

sealed class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object> get props => [];
}

class OnLoadPage extends SettingEvent {
  const OnLoadPage();

  @override
  List<Object> get props => [];
}

class OnTapThemeSwitch extends SettingEvent {
  const OnTapThemeSwitch({
    this.themeType = ThemeType.light,
  });

  final ThemeType themeType;

  @override
  List<Object> get props => [themeType];
}
