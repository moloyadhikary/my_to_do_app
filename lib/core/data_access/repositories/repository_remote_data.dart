import 'package:dio/dio.dart';
import 'package:my_to_do_app/core/data_access/interfaces/interface_remote_data.dart';
import 'package:my_to_do_app/core/models/generic_response_model.dart';
import 'package:my_to_do_app/core/models/proejct_section/proejct_section.dart';
import 'package:my_to_do_app/core/models/proejct_section/proejct_section_response_data.dart';
import 'package:my_to_do_app/core/models/project_task/proejct_task_response_data.dart';
import 'package:my_to_do_app/core/models/project_task/project_task.dart';
import 'package:my_to_do_app/core/models/project_task/project_task_detail_response_data.dart';
import 'package:my_to_do_app/core/models/project_task/task.dart';
import 'package:my_to_do_app/core/models/task_comments/task_comments.dart';
import 'package:my_to_do_app/core/models/task_comments/task_comments_response_data.dart';
import 'package:my_to_do_app/helpers/constants/action_url_constant.dart';
import 'package:my_to_do_app/helpers/constants/app_setting_constants.dart';
import 'package:my_to_do_app/helpers/constants/message_constant.dart';
import 'package:my_to_do_app/helpers/generic_client.dart';
import 'package:uuid/uuid.dart';

class RepositoryRemoteData implements InterfaceRemoteData {
  @override
  Future<ProejctSectionResponseData> getProjectSections(
      String projectId) async {
    final proejctSectionResponseData = ProejctSectionResponseData();

    try {
      final result = await GenericClient.dioGet(
        actionUrl: ActionUrlConstant.getProjectSections + projectId,
        jsonName: 'section_data',
      );
      if (result.hasError) {
        proejctSectionResponseData
          ..hasError = true
          ..errorMessage = result.errorMessage
          ..responseStr = '';
        return proejctSectionResponseData;
      }
      proejctSectionResponseData.hasError = false;
      proejctSectionResponseData.proejctSection =
          ProejctSection.fromJson(result.responseStr);
    } catch (e) {
      proejctSectionResponseData
        ..hasError = true
        ..errorMessage = MessageConstant.commonErrorMessage
        ..responseStr = '';
    }

    return proejctSectionResponseData;
  }

  @override
  Future<ProejctTaskResponseData> getProjectTasks(String projectId) async {
    final proejctTaskResponseData = ProejctTaskResponseData();

    try {
      final result = await GenericClient.dioGet(
        actionUrl: ActionUrlConstant.getSectionTasks + projectId,
        jsonName: 'tasks',
      );
      if (result.hasError) {
        proejctTaskResponseData
          ..hasError = true
          ..errorMessage = result.errorMessage
          ..responseStr = '';
        return proejctTaskResponseData;
      }
      proejctTaskResponseData.hasError = false;
      proejctTaskResponseData.projectTask =
          ProjectTask.fromJson(result.responseStr);
    } catch (e) {
      proejctTaskResponseData
        ..hasError = true
        ..errorMessage = MessageConstant.commonErrorMessage
        ..responseStr = '';
    }

    return proejctTaskResponseData;
  }

  @override
  Future<ProejctTaskDetailResponseData> updateTask(
    String id,
    String content,
    String description,
    String dueDate,
    String projectId,
  ) async {
    final proejctTaskDetailResponseData = ProejctTaskDetailResponseData();

    try {
      final formData = FormData.fromMap({
        'content': content,
        'due_date': dueDate,
        'project_id': projectId,
        'description': description,
      });

      final result = await GenericClient.dioPost(
        actionUrl: AppSettingConstants.apiBaseUrl +
            ActionUrlConstant.createUpdateTask +
            id,
        jsonName: 'task',
        formData: formData,
      );
      if (result.hasError) {
        proejctTaskDetailResponseData
          ..hasError = true
          ..errorMessage = result.errorMessage
          ..responseStr = '';
        return proejctTaskDetailResponseData;
      }
      proejctTaskDetailResponseData.hasError = false;
      proejctTaskDetailResponseData.task = Task.fromJson(result.responseStr);
    } catch (e) {
      proejctTaskDetailResponseData
        ..hasError = true
        ..errorMessage = MessageConstant.commonErrorMessage
        ..responseStr = '';
    }

    return proejctTaskDetailResponseData;
  }

  @override
  Future<GenericResponseModel> moveTask(String id, String sectionId) async {
    final genericResponseModel = GenericResponseModel(
        responseStr: '',
        hasError: true,
        errorMessage: MessageConstant.commonErrorMessage);

    try {
      var uuid = const Uuid();
      final formData = FormData.fromMap({
        'commands':
            '[{"args": {"id": "$id", "section_id": "$sectionId"},"type": "item_move","uuid": "${uuid.v1()}"}]',
      });

      final result = await GenericClient.dioPost(
        actionUrl: AppSettingConstants.apiBaseSyncUrl,
        jsonName: 'task',
        formData: formData,
      );
      if (result.hasError) {
        genericResponseModel
          ..hasError = true
          ..errorMessage = result.errorMessage
          ..responseStr = '';
        return genericResponseModel;
      }
      genericResponseModel.hasError = false;
    } catch (e) {
      genericResponseModel
        ..hasError = true
        ..errorMessage = MessageConstant.commonErrorMessage
        ..responseStr = '';
    }

    return genericResponseModel;
  }

  @override
  Future<TaskCommentsResponseData> getTaskComments(String taskId) async {
    final taskCommentsResponseData = TaskCommentsResponseData();

    try {
      final result = await GenericClient.dioGet(
        actionUrl: ActionUrlConstant.getTaskComments + taskId,
        jsonName: 'comments',
      );
      if (result.hasError) {
        taskCommentsResponseData
          ..hasError = true
          ..errorMessage = result.errorMessage
          ..responseStr = '';
        return taskCommentsResponseData;
      }
      taskCommentsResponseData.hasError = false;
      taskCommentsResponseData.taskComments =
          TaskComments.fromJson(result.responseStr);
    } catch (e) {
      taskCommentsResponseData
        ..hasError = true
        ..errorMessage = MessageConstant.commonErrorMessage
        ..responseStr = '';
    }

    return taskCommentsResponseData;
  }

  @override
  Future<GenericResponseModel> createComment(
      String taskId, String comment) async {
    final genericResponseModel = GenericResponseModel(
        responseStr: '',
        hasError: true,
        errorMessage: MessageConstant.commonErrorMessage);

    try {
      final formData = FormData.fromMap({
        'task_id': taskId,
        'content': comment,
      });

      final result = await GenericClient.dioPost(
        actionUrl:
            AppSettingConstants.apiBaseUrl + ActionUrlConstant.createComment,
        jsonName: 'comment',
        formData: formData,
      );
      if (result.hasError) {
        genericResponseModel
          ..hasError = true
          ..errorMessage = result.errorMessage
          ..responseStr = '';
        return genericResponseModel;
      }
      genericResponseModel.hasError = false;
    } catch (e) {
      genericResponseModel
        ..hasError = true
        ..errorMessage = MessageConstant.commonErrorMessage
        ..responseStr = '';
    }

    return genericResponseModel;
  }

  @override
  Future<GenericResponseModel> createTask(
    String content,
    String description,
    String dueDate,
    String projectId,
    String sectionId,
  ) async {
    final genericResponseModel = GenericResponseModel(
        responseStr: '',
        hasError: true,
        errorMessage: MessageConstant.commonErrorMessage);

    try {
      final formData = FormData.fromMap({
        'content': content,
        'due_date': dueDate,
        'project_id': projectId,
        'section_id': sectionId,
        'description': description,
      });

      final result = await GenericClient.dioPost(
        actionUrl:
            AppSettingConstants.apiBaseUrl + ActionUrlConstant.createUpdateTask,
        jsonName: 'task',
        formData: formData,
      );
      if (result.hasError) {
        genericResponseModel
          ..hasError = true
          ..errorMessage = result.errorMessage
          ..responseStr = '';
        return genericResponseModel;
      }
      genericResponseModel.hasError = false;
    } catch (e) {
      genericResponseModel
        ..hasError = true
        ..errorMessage = MessageConstant.commonErrorMessage
        ..responseStr = '';
    }

    return genericResponseModel;
  }

  @override
  Future<GenericResponseModel> taskMarkCompleted(
      String id, String completionDate) async {
    final genericResponseModel = GenericResponseModel(
        responseStr: '',
        hasError: true,
        errorMessage: MessageConstant.commonErrorMessage);

    try {
      var uuid = const Uuid();
      final formData = FormData.fromMap({
        'commands':
            '[{"args": {"id": "$id", "date_completed": "$completionDate"},"type": "item_complete","uuid": "${uuid.v1()}"}]',
      });

      final result = await GenericClient.dioPost(
        actionUrl: AppSettingConstants.apiBaseSyncUrl,
        jsonName: 'task',
        formData: formData,
      );
      if (result.hasError) {
        genericResponseModel
          ..hasError = true
          ..errorMessage = result.errorMessage
          ..responseStr = '';
        return genericResponseModel;
      }
      genericResponseModel.hasError = false;
    } catch (e) {
      genericResponseModel
        ..hasError = true
        ..errorMessage = MessageConstant.commonErrorMessage
        ..responseStr = '';
    }

    return genericResponseModel;
  }
}
