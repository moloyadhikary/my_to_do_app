import 'package:my_to_do_app/core/models/generic_response_model.dart';
import 'package:my_to_do_app/core/models/project_task/task.dart';
import 'package:my_to_do_app/helpers/constants/message_constant.dart';

class ProejctTaskDetailResponseData extends GenericResponseModel {
  ProejctTaskDetailResponseData({
    this.task,
  }) : super(
          hasError: true,
          responseStr: '',
          errorMessage: MessageConstant.commonErrorMessage,
        );

  Task? task;
}
