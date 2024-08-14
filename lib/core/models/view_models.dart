import 'package:my_to_do_app/core/models/proejct_section/section_datum.dart';
import 'package:my_to_do_app/core/models/project_task/task.dart';
import 'package:my_to_do_app/helpers/local_storage/model/task_running_history_hive_model.dart';

class VmSectionDetail {
  VmSectionDetail({required this.section, required this.tasks});

  SectionDatum section;
  List<Task> tasks;
}

class VmCompletedTask {
  VmCompletedTask({required this.task, required this.completionInformation});

  Task task;
  TaskRunningHistoryHiveModel completionInformation;
}
