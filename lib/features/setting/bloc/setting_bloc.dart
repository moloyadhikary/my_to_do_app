import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_to_do_app/helpers/enum_cast_helper.dart';
import 'package:my_to_do_app/helpers/enum_helper.dart';
import 'package:my_to_do_app/helpers/local_storage/operation/preferences_hive_operation.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(const SettingInitial()) {
    on<SettingEvent>((event, emit) async {
      final lastPref = await _preferencesOps.get();
      emit(
        SettingState(
          themeType: EnumCastHelper.themeEnumFromString(lastPref.themeType),
        ),
      );
    });

    on<OnLoadPage>((event, emit) async {
      final lastPref = await _preferencesOps.get();
      emit(
        SettingState(
          themeType: EnumCastHelper.themeEnumFromString(lastPref.themeType),
        ),
      );
    });

    on<OnTapThemeSwitch>((event, emit) async {
      final lastPref = await _preferencesOps.get();
      final newPref = lastPref..themeType = event.themeType.name;
      final res = await _preferencesOps.save(objToSave: newPref);

      if (res == PreferencesSaveResult.success) {
        emit(
          SettingState(
            themeType: event.themeType,
          ),
        );
      } else {
        emit(
          SettingState(
            themeType: EnumCastHelper.themeEnumFromString(lastPref.themeType),
          ),
        );
      }
    });
  }

  final _preferencesOps = PreferencesHiveOperation();
}
