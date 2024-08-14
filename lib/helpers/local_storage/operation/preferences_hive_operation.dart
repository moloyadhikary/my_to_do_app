import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_to_do_app/helpers/enum_helper.dart';
import 'package:my_to_do_app/helpers/local_storage/model/preferences_hive_model.dart';

enum PreferencesSaveResult { success, failure }

class PreferencesHiveOperation {
  late Box<PreferencesHiveModel> __preferencesBox;

  Future<PreferencesSaveResult> save({
    required PreferencesHiveModel objToSave,
  }) async {
    try {
      __preferencesBox = await Hive.openBox<PreferencesHiveModel>(
        'preferencesBox',
      );
      if (__preferencesBox.values.toList().isEmpty) {
        await __preferencesBox.add(
          objToSave,
        );
      } else {
        await __preferencesBox.clear();
        await __preferencesBox.add(
          objToSave,
        );
      }
      return PreferencesSaveResult.success;
    } on Exception {
      return PreferencesSaveResult.failure;
    }
  }

  Future<PreferencesHiveModel> get() async {
    var obj = PreferencesHiveModel(
      themeType: ThemeType.light.name,
    );

    try {
      __preferencesBox = await Hive.openBox<PreferencesHiveModel>(
        'preferencesBox',
      );
      if (__preferencesBox.isNotEmpty) {
        obj = __preferencesBox.values.first;
      }
    } catch (e) {
      //No Object Found
      if (kDebugMode) {
        print(e);
      }
    }
    return obj;
  }

  Future<bool> deleteDeviceData() async {
    var isSuccess = false;

    try {
      __preferencesBox = await Hive.openBox<PreferencesHiveModel>(
        'preferencesBox',
      );

      await __preferencesBox.clear();
      isSuccess = true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      isSuccess = false;
    }
    return isSuccess;
  }
}
