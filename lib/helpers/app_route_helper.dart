import 'package:flutter/material.dart';
import 'package:my_to_do_app/features/completed_tasks/view/completed_tasks_page.dart';
import 'package:my_to_do_app/features/create_task/view/create_task_page.dart';
import 'package:my_to_do_app/features/home/view/home_page.dart';
import 'package:my_to_do_app/features/setting/view/setting_page.dart';
import 'package:my_to_do_app/features/task_detail/view/task_detail_page.dart';
import 'package:my_to_do_app/features/update_task/view/update_task_page.dart';

class AppRouteHelper {
  static const String initialRoute = '/initial';
  static const String home = '/home';
  static const String setting = '/setting';
  static const String createTask = '/createTask';
  static const String taskDetail = '/taskDetail';
  static const String updateTask = '/updateTask';
  static const String completedTasks = '/completedTasks';

  static Map<String, WidgetBuilder> get routes => {
        initialRoute: HomePage.builder,
        home: HomePage.builder,
        setting: SettingPage.builder,
        createTask: CreateTaskPage.builder,
        taskDetail: TaskDetailPage.builder,
        updateTask: UpdateTaskPage.builder,
        completedTasks: CompletedTasksPage.builder,
      };
}
