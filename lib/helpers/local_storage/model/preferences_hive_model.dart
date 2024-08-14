import 'package:hive_flutter/hive_flutter.dart';

part 'preferences_hive_model.g.dart';

@HiveType(typeId: 0)
class PreferencesHiveModel extends HiveObject {
  PreferencesHiveModel({
    required this.themeType,
  });

  @HiveField(0)
  String themeType;
}
