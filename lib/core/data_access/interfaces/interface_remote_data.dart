import 'package:my_to_do_app/core/models/generic_response_model.dart';
import 'package:my_to_do_app/core/models/proejct_section/proejct_section_response_data.dart';
import 'package:my_to_do_app/core/models/project_task/proejct_task_response_data.dart';
import 'package:my_to_do_app/core/models/project_task/project_task_detail_response_data.dart';
import 'package:my_to_do_app/core/models/task_comments/task_comments_response_data.dart';

abstract interface class InterfaceRemoteData {
  Future<ProejctSectionResponseData> getProjectSections(String projectId);
  Future<ProejctTaskResponseData> getProjectTasks(String projectId);
  Future<ProejctTaskDetailResponseData> updateTask(
    String id,
    String content,
    String description,
    String dueDate,
    String projectId,
  );
  Future<GenericResponseModel> moveTask(String id, String sectionId);
  Future<TaskCommentsResponseData> getTaskComments(String taskId);
  Future<GenericResponseModel> createComment(String taskId, String comment);
  Future<GenericResponseModel> createTask(
    String content,
    String description,
    String dueDate,
    String projectId,
    String sectionId,
  );

  Future<GenericResponseModel> taskMarkCompleted(
      String id, String completionDate);
}
